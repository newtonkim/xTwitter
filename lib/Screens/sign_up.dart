import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final  GlobalKey<FormState> _signInKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp emailValidator = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _signInKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //  const Image(image: AssetImage(
            //   'assets/mytwitter.png',
            //   ),width: 100,
            // ),
               const FaIcon(FontAwesomeIcons.xTwitter, size: 100,),
            SizedBox(height: 20,),
            const Text('Sign up to xTwitter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200, 
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email";
                    }else if(!emailValidator.hasMatch(value) ){
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  ),
            ), // email
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(vertical: 10),
               decoration: BoxDecoration(
                color: Colors.grey.shade200, 
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter a Password",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }else if(value.length < 6){
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
              ),
            ), // password
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 13, 19, 23),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  if(_signInKey.currentState!.validate()){
                     debugPrint("Email: ${emailController.text}");
                     debugPrint("Password: ${passwordController.text}");
                  }
                },
                child: Text('Sign Up', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                  ),
                ),
              ),
            ),

            TextButton(onPressed: (){
              Navigator.of(context).pop();

            }, child: Text("Already have an account ? Log in", 
              style: TextStyle(color: Colors.blue),
            ),
            ),
          ],
        ),
      ),
    );
  }
}