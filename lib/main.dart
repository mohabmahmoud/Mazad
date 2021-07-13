import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:mzad/Constants/widthandheight.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller.dart';
import 'CountryTemp.dart';
import 'Constants/apptheme.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.apptheme,
      home: Splash(),
    );
  }
}




class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>  {
  var x=SystemChrome.setEnabledSystemUIOverlays ([]);
  String id;
  int rank;
  GifController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    const duartion=Duration(seconds: 4 );


    new Timer(duartion,(){
      setState(() {
        x= SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      });

    getdata();


    });


  }

  @override
  Widget build(BuildContext context) {
    x;
    return Scaffold(
        body: Container(
            child:
                Stack(
                  children: [
                    Container(child:
                    Image.asset('images/splashground.png',fit:BoxFit.fitWidth,),height: getheight(context),),

                     Center(child:Image(image:  AssetImage("images/splash.gif")))
                  ],
                )



            )
    );
  }
getdata()async{
SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
bool lang=sharedPreferences.getBool('lang');

if(sharedPreferences.getString('country')==null){

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    return CountryTemp((lang==null)?true:(lang)?true:false);

  }));

}
else {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return Controller(sharedPreferences.getString('country'),(lang==null)?true:(lang)?true:false,sharedPreferences.getString('id'));
  }));

}




  }


}



