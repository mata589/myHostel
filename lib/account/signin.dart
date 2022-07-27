import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vox_vibe/account/signup.dart';
import 'package:vox_vibe/homePage.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  int _success = 1;
  String _userEmail = "";

       @override
        dispose(){
       emailController.dispose();
       passwordController.dispose();
       super.dispose();

       }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(gradient: LinearGradient(colors:[ Colors.deepPurple,Colors.black,],
      begin: Alignment.topCenter, end: Alignment.bottomCenter
      
      )),
      child: Center(
          child: Padding(padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height*0.2,20,0),
          child: Column(

           children: [
              TextField(  
                controller: emailController,
                    //obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Enter your email',  
                      hintText: 'Enter Password',  
                    ),  
                  ),   
          const SizedBox(height: 30),
                     TextField(  
                       controller: passwordController,
                   //obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Enter your password',  
                      hintText: 'Enter Password',  
                    ),  
                  ),   
                     
                      const SizedBox(height: 30),
 RaisedButton(  
                  textColor: Colors.white,  
                  color: Colors.blue,  
                  child: Text('Sign In'),  
                  onPressed: ()  {
                    signin();},  
                ) , 
          SizedBox(height: 34,),

          Text('don\'t have an account? '),
           TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => signup()),
  );

            },
            child: const Text('SignUp'),
          ),
           ],
          ) ,
          ),

       

      ),
      ),
    );

    
  }
  
  Future<void> signin() async {
  final User? user = (await _auth.signInWithEmailAndPassword(
    email: emailController.text.trim(), password: passwordController.text.trim())).user;
     if(user != null){
       setState(() {
         _success =2;
         _userEmail = user.email!;
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
       });
     }

     else{
       setState(() {
         _success = 3;
       });
     }


// await FirebaseAuth.instance.signInWithEmailAndPassword(
//   email: emailController.text.trim(),
//   password: passwordController.text.trim(),
//   );

  }
}