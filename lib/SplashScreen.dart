import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    checkUserId();
  }

    Future<Null> checkUserId() async {
      setState(() {
        Timer(Duration(seconds: 3),(){
          // Toast.show("Created By Rishabh Dev Sahu", backgroundColor: Colors.green, duration: Toast.lengthLong, gravity:  Toast.bottom);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Click To Chat', mobileNumber: '', countryCode: 'IN')));
        });
      });
    }

  @override
  Widget build(BuildContext context) {
   return Scaffold(

     body: Container(
       height: double.infinity,
         width: double.infinity,
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/images/chitchatlogo.png"),
             fit: BoxFit.cover,
             alignment: const Alignment(0.1,0),
           ),
         ),
     ),

   );
  }}
