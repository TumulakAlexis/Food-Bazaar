import 'package:bite_bazaar/screens/login.dart';
import 'package:bite_bazaar/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class OnboardScreen2 extends StatelessWidget {
  const OnboardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/logo.json', fit: BoxFit.fill),
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Heyam',
                  fontSize: 40,
                ),
                children: [
                  TextSpan(text: 'F', style: TextStyle(color: Colors.red)),
                  TextSpan(text: 'o', style: TextStyle(color: Colors.yellow)),
                  TextSpan(text: 'o', style: TextStyle(color: Colors.blue)),
                  TextSpan(text: 'd', style: TextStyle(color: Colors.green)),
                  TextSpan(text: ' ', style: TextStyle(color: Colors.transparent)),
                  TextSpan(text: 'B', style: TextStyle(color: Colors.purple)),
                  TextSpan(text: 'a', style: TextStyle(color: Colors.orange)),
                  TextSpan(text: 'z', style: TextStyle(color: Colors.cyan)),
                  TextSpan(text: 'a', style: TextStyle(color: Colors.pink)),
                  TextSpan(text: 'a', style: TextStyle(color: Colors.lime)),
                  TextSpan(text: 'r', style: TextStyle(color: Colors.indigo)),
                ],
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Container(
                width: 280,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text("Log In",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),)),
              
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Container(
                width: 280,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
              
                ),
                child: Center(child: Text("Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}