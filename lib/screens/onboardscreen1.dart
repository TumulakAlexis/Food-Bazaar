import 'package:bite_bazaar/screens/onboardingscreen2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardScreen1 extends StatelessWidget {
  const OnboardScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150),
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
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardScreen2()));
              },
              child: Text('Get Started!',
              style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // background color
                foregroundColor: Colors.black, // text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
