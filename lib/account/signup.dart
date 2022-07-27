import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vox_vibe/account/signin.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
class signup extends StatefulWidget {
   signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  Future<FirebaseApp> _initializeFirebase() async{
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}
 final passwordController = TextEditingController();
  final emailController = TextEditingController();
  late bool _success;
  late String _userEmail;

  @override
   dispose(){
       emailController.dispose();
       passwordController.dispose();
       super.dispose();

       }


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
                   // obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Enter your email',  
                      hintText: 'Enter Password',  
                    ),  
                  ),   
          const SizedBox(height: 30),
                     TextField(  
                       controller: passwordController,
                   // obscureText: true,  
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
                  child: Text('Sign up'),  
                  onPressed: ()  async {
                    signup();   },  
                )  
          
           ],
          ) ,
          ),

       

      ),
      ),
    );
  }

  Future<void> signup() async {
    _initializeFirebase();
final User? user = (
  await _auth.createUserWithEmailAndPassword(
    email: emailController.text.trim(),
     password: passwordController.text.trim())
).user;
    
    if(user != null){
      setState(() {
        _success = true;
        _userEmail = user.email!;
         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignInScreen()),
  );
      });
    } else{
      _success = false;

    }
// await FirebaseAuth.instance.signInWithEmailAndPassword(
//   email: emailController.text.trim(),
//   password: passwordController.text.trim(),
//   );

  }
}