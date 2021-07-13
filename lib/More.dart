import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
class More extends StatefulWidget {
  bool lang;
  More(this.lang);
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
show();
super.initState();
  }
  String id=null;
  show()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    id=sharedPreferences.getString('id');
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text((widget.lang)?'المزيد':'More',),centerTitle: true,),body: Container(color: Colors.white,child: ListView(children: [
      ListTile(onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text((widget.lang)?" تغير اللغة":'Change language',style: TextStyle(fontFamily: 'mohab'),),
                actions: [
                  FlatButton(
                    child: Text((widget.lang)?"عربية":'Arbic',style: TextStyle(fontFamily: 'mohab'),),
                    onPressed: () async{

                      if(widget.lang) {
                        Navigator.of(context).pop();
                      }else{

                        SharedPreferences shared=await SharedPreferences.getInstance();
                        shared.setBool('lang', true);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return Splash();
                        }));
                      }

                      },
                  ),
                  FlatButton(
                    child: Text((widget.lang)?"الانجليزية":'English',style: TextStyle(fontFamily: 'mohab'),),
                    onPressed: () async{

                      if(!widget.lang) {
                        Navigator.of(context).pop();
                      }else{

                        SharedPreferences shared=await SharedPreferences.getInstance();
                        shared.setBool('lang', !true);
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return Splash();
                        }));
                      }

                      },
                  ),
                ],
              );
            });


      },title: Text((widget.lang)?'تغير اللغة':'Change language',style: TextStyle(fontFamily: 'mohab'),),leading: Icon(Icons.translate,color:Theme.of(context).primaryColor,),),
      ListTile(onTap: ()async{
        SharedPreferences shared=await SharedPreferences.getInstance();
        shared.setString('country',null);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return Splash();
        }));

      },title: Text((widget.lang)?'تغير البلد':'Change language',style: TextStyle(fontFamily: 'mohab'),),leading: Icon(Icons.language,color:Theme.of(context).primaryColor,),),
      (id==null)?Container():ListTile(
          onTap: ()async{
            SharedPreferences shared=await SharedPreferences.getInstance();
            FirebaseAuth.instance.signOut().then((value) {
              shared.setString('id',null);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return Splash();
              }));

            });


          }


        ,title: Text((widget.lang)?'تسجيل الخروج':'Logout',style: TextStyle(fontFamily: 'mohab'),),leading: Icon(Icons.logout,color:Theme.of(context).primaryColor,),),


    ],)




      ,),);
  }
}
