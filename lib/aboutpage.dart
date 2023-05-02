import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';


class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with WidgetsBindingObserver  {


  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg332.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(40),
                  child:  Align(
                    alignment: Alignment.center,
                    child: Text('About', style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),),
                  )
              ),
              SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 6,bottom: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 160,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircleAvatar(
                                  radius: 200,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(120),
                                      child: InstaImageViewer(child: Image.asset("assets/images/rishabh.png"))
                                  )),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Rishabh Dev Sahu",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight:
                                FontWeight
                                    .w600),),
                          SizedBox(height: 8,),
                          Text(
                            "(Full Stack Developer)",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight:
                                FontWeight
                                    .normal),),
                          SizedBox(height: 8,),
                          Text(
                            "Version 1.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight:
                                FontWeight
                                    .normal),),
                        ],
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),

      ),
    );


  }
}
