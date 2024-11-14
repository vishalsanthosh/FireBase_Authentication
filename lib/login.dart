
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newprojauth/forgot.dart';
import 'package:newprojauth/homepage.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
   TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      print('User signed in');
    } catch (e) {
      print('Sign-in error: $e');
      _showErrorDialog(e.toString());
    }
  }
   void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              height: 300,
              width: double.infinity,
              
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _email,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
            ),
              SizedBox(height: 10,),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                _signIn();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdScreen()));
              },
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                color: Colors.red),
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign in",style: TextStyle(color: Colors.white),),
                )),
              ),
            ),
            SizedBox(height: 10,),
           
            SizedBox(height: 5,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
              },
              child: Text("Forgot Password",style: TextStyle(color: Colors.blue),)),
             
        
          ],
        ),
      ),
    ); 
  
  }
}