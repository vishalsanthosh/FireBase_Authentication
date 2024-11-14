import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newprojauth/forgot.dart';
import 'package:newprojauth/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();

   Future<UserCredential?>loginwithGoogle()async{
    try{
    final GoogleSignIn googleSignIn=GoogleSignIn(
      clientId: "193627740084-bplbv8ukp04tc3047r8i5n2njlhav6j0.apps.googleusercontent.com"
    );
    final googleUser=await googleSignIn.signIn();
    final googleAuth=await googleUser?.authentication;
    final cred=GoogleAuthProvider.credential(idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken);
    return await FirebaseAuth.instance.signInWithCredential(cred);

   }catch(e){
    print(e.toString());

   }
   return null;

   }
   Future<void> _signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      print('User signed up');
    } catch (e) {
      print('Sign-up error: $e');
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
       body: Column(
        children: [
          Container(
            height:400,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/signup.jpg"),fit: BoxFit.cover)
            ),
          ),
           SizedBox(height:20),

           SizedBox(
            height:40,
            width:300,
             child: TextField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
              ),
           ),
           SizedBox(height:20),
            SizedBox(
              height:40,
            width:300,
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))
              ),
            ),
            SizedBox(height: 55),
            SizedBox(
              height:40,
              width:300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white),

                onPressed: (){
                  _signUp();
                  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen())
);
                },
                child: Text('Sign Up',style:TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Already have an Account?",style: TextStyle(color:Colors.black,fontSize: 18),),
              SizedBox(width:10),
              GestureDetector(
                onTap:(){
                 Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen())
);

                } ,
                child: Text("Login",style: TextStyle(color:Colors.red,fontSize: 18),))
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                },
                child: Text("Forgot password?",style: TextStyle(fontSize: 18,color:Colors.blue),)),
            ],),
            SizedBox(height: 10,),
            Center(
              child: GestureDetector(
                onTap: ()async {
                  await loginwithGoogle();
                
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Sign In With"),
                    SizedBox(width: 8,),
                    Image.asset("assets/images/google-icon-2048x2048-pks9lbdv.png",height: 22,width: 22,)
                  ],
                ),
              ),
            ),
           
        ],
      ),
    );
  }
}