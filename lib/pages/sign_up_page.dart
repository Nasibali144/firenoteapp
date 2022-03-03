import 'package:firebase_auth/firebase_auth.dart';
import 'package:firenoteapp/pages/sign_in_page.dart';
import 'package:firenoteapp/services/auth_service.dart';
import 'package:firenoteapp/services/db_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "sign_up_page";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>  _doSingUp() async {
    String firstName = firstNameController.text.trim().toString();
    String lastName = lastNameController.text.trim().toString();
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if(email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      // error msg
      return;
    }

    DBService.storeString(StorageKeys.FIRSTNAME, firstName);
    DBService.storeString(StorageKeys.LASTNAME, lastName);
    
    await AuthService.signUpUser(firstName + " " + lastName, email, password).then((value) => _getFirebaseUser(value));
  }

  void _getFirebaseUser(User? user) {
    if(user != null) {
      Navigator.pushReplacementNamed(context, SignInPage.id);
    } else {
      // print error msg
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // #firstname
              TextField(
                textInputAction: TextInputAction.next,
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: "Firstname"
                ),
              ),
              SizedBox(height: 10,),

              // #lastname
              TextField(
                textInputAction: TextInputAction.next,
                controller: lastNameController,
                decoration: InputDecoration(
                    hintText: "Lastname"
                ),
              ),
              SizedBox(height: 10,),

              // #email
              TextField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
              ),
              SizedBox(height: 10,),

              // #password
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password"
                ),
              ),
              SizedBox(height: 10,),

              // #sign_in
              MaterialButton(
                onPressed: _doSingUp,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                height: 50,
                minWidth: MediaQuery.of(context).size.width - 50,
                color: Colors.blueAccent,
                child: Text("Sign Up"),
                textColor: Colors.white,
              ),
              SizedBox(height: 20,),

              // #don't_have_account
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Already have an account? ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignInPage.id);
                    },
                    child: Text("Sign In", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
