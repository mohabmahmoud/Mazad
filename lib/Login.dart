import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mzad/Constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Sigup.dart';

class Login extends StatefulWidget {
  bool lang;
  Login(this.lang);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController Email=new TextEditingController();
  TextEditingController Pass=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: Container(child:FlatButton(onPressed: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){

        return SignUp(widget.lang);
      }));

    },child:Text('Haven\'t an account? SignUp!' ))),body: Container(color: HexColor('efefef'),child: ListView(children: [
      SizedBox(height: 20,),

      Container(height: MediaQuery.of(context).size.height/4,child:Image.asset('images/icon.png',fit:BoxFit.fitHeight ,)),
      SizedBox(height: 30,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: Email,
          textAlign:TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                  Icons.mail,color: Theme.of(context).primaryColor
              ),
              hintText:'E-mail',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color:Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 30,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        decoration:
        BoxDecoration(


            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: Pass,

          textAlign:TextAlign.left,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                Icons.lock,
                color:Theme.of(context).primaryColor,
              ),
              hintText:'Password',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color:Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 30,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
          decoration:BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Theme.of(context).primaryColor)),
          height: 60.0,child:FlatButton(onPressed: (){
        Login();
      },child:Text('Login',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))))


    ],),),);
  }



  Login()async{
    print('login');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth
        .signInWithEmailAndPassword(
        email: Email.text, password: Pass.text).then((result){
      Getdata(result.user.uid);


    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });

  }

  Getdata(String uid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var ref = db.collection('Users');
    await ref.doc(uid).get().then((result) {
      //results.add(User.fromMap(result.data, result.documentID));
      prefs.setString('id', uid);

     Navigator.pop(context);






    }).catchError((error){    print(error.toString());  });







  }
  bool isemail(String email){

    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email );

  }









}