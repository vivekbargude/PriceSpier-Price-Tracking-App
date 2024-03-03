const puppeteer = require('puppeteer');
const cheerio = require('cheerio');
const CronJob = require('cron').CronJob;
const nodemailer = require('nodemailer');
const dotenv = require('dotenv');
const express = require('express');
const colors = require('colors');

const app = express();

app.use(express.json());


dotenv.config();

async function configureBrowser(url) {

    const browser = await puppeteer.launch({headless: 'new'});
    const page = await browser.newPage();
    await page.goto(url);
    return page;
}


async function checkPrice(page,targetedPrice,emailId,url){

    // id :: a-price-whole

    await page.reload();

    const priceElement = await page.$('.a-price-whole'); 
    if (priceElement) {
        const currentPrice = await page.evaluate(element => element.textContent.replace(/,/g, ''), priceElement);
        console.log(currentPrice);
    
        if(currentPrice < targetedPrice){
            sendEmail(url,emailId,targetedPrice);
        }

    } else {
        console.log('Price element not found');
    }

}

async function sendEmail(url,emailId,targetedPrice){

    let transporter = nodemailer.createTransport({
        service : 'gmail',
        auth : {
            user : 'vivek.221193108@vcet.edu.in',
            pass : 'ddvo ixyb iwsn ixah'
        }
    });

    const textToSend = `Hurry Up!! It's time to buy. The price has dropped to ₹${targetedPrice}.`;
    const htmlText = `<p>${textToSend}</p><p><a href="${url}">Link</a></p>`;

    let emailbody = await transporter.sendMail({
        from : '"Price Spyer" <pricespyer@gmail.com>',
        to : emailId,
        subject : 'Price Alert!!',
        text : textToSend,
        html : htmlText
    });

    console.log("Message send : %s",emailbody.messageId);
}


async function startTracking(url,emailId,targetedPrice) {

    const page = await configureBrowser(url);

    let job = new CronJob('0 */2 * * *',function() {
        checkPrice(page,targetedPrice,emailId,url);
    },null,true,null,null,true);

    job.start();

}

app.post('/track',(req,res)=>{

    const {productUrl,targetEmail,targetPrice} = req.body;

    startTracking(productUrl,targetEmail,targetPrice);

    res.status(200).json({
        success : true,
    });

});

app.listen(3000,()=>{
    console.log("Server is running at http://localhost:3000");
});