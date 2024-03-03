import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price Spyer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PriceSpyPage(),
    );
  }
}

class PriceSpyPage extends StatefulWidget {
  const PriceSpyPage({super.key});

  @override
  State<PriceSpyPage> createState() => _PriceSpyPageState();
}

class _PriceSpyPageState extends State<PriceSpyPage> {

   final _formKey = GlobalKey<FormState>();
  TextEditingController _productUrlController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _targetedPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
                        appBar: AppBar(
                          centerTitle: true,
                          title: const Text('Price Spier'),

                          titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        body: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(

                            padding: const EdgeInsets.only(top : 5),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.asset('assets/logo_ps.png',height: 80,width: 100,),
                                  Text("Track Prices, Save Money.",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("Your Personal Shopping Companion.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: _productUrlController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.link),
                                      labelText: 'Product URL',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the product URL';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  // Error message for product URL
                                  if (_productUrlController.text.isNotEmpty &&
                                      _formKey.currentState != null &&
                                      !_formKey.currentState!.validate())
                                    const Text(
                                      'Please enter a valid URL',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      labelText: 'Email ID',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your email ID';
                                      }
                                      // Add more complex email validation if needed
                                      if (!value.contains('@')) {
                                        return 'Please enter a valid email ID';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  // Error message for email ID
                                  if (_emailController.text.isNotEmpty &&
                                      _formKey.currentState != null &&
                                      !_formKey.currentState!.validate())
                                    const Text(
                                      'Please enter a valid email ID',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _targetedPriceController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.price_check),
                                      labelText: 'Targeted Price',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the targeted price';
                                      }
                                      // Validate if value is a valid number
                                      if (double.tryParse(value) == null) {
                                        return 'Please enter a valid number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  // Error message for targeted price
                                  if (_targetedPriceController.text.isNotEmpty &&
                                      _formKey.currentState != null &&
                                      !_formKey.currentState!.validate())
                                    const Text(
                                      'Please enter a valid number',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        String productUrl = _productUrlController.text;
                                        String emailId = _emailController.text;
                                        String targetedPrice = _targetedPriceController.text;

                                        startTracking(productUrl, emailId, targetedPrice);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green, // Background color
                                      onPrimary: Colors.white, // Text color
                                      elevation: 3, // Elevation
                                      padding: const EdgeInsets.symmetric(vertical: 12.0), // Padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0), // Border radius
                                      ),
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(fontSize: 18.0), // Text style
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );




  }
  
  void startTracking(String productUrl, String emailId, String targetedPrice) async {

    String Url = "http://192.168.0.108:3000/track";


  var reqbody = {
    "productUrl" : _productUrlController.text,
    "targetEmail" : _emailController.text,
    "targetPrice" : _targetedPriceController.text,
  };

  try {
    var response = await http.post(
      Uri.parse(Url),
      headers : {"Content-Type" : "application/json"},
      body : jsonEncode(reqbody)
    );

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['success']) {
      _emailController.clear();
      _productUrlController.clear();
      _targetedPriceController.clear();

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Price Tracking Enabled",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        content: Text(
                          "You will be notified once the price drops below your targeted price.",
                          textAlign: TextAlign.center,
                          style: const  TextStyle(

                            fontSize: 16.0,
                          ),
                        ),
                        backgroundColor: Colors.white, // Set background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );

    }
  } catch (err) {
    print(err);
  }
}

}