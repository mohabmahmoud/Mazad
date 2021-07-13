import 'package:flutter/material.dart';
import 'package:mzad/Login.dart';
import 'package:mzad/More.dart';
import 'package:mzad/addproduct.dart';
import 'package:mzad/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyChats.dart';
import 'add/nameandimages.dart';
import 'local/home.dart';
class Controller extends StatefulWidget {
  String cou_id;
  bool lang;
  String uid;
  Controller(this.cou_id,this.lang,this.uid);
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  var pages;
@override
  void initState() {
  pages=[(widget.lang)?More(widget.lang):HOME(widget.cou_id,widget.lang),(widget.lang)?Profile(widget.uid,widget.lang):MyChats(widget.uid,widget.lang),(!widget.lang)?Profile(widget.uid,widget.lang):MyChats(widget.uid,widget.lang),(widget.lang)?HOME(widget.cou_id,widget.lang):More(widget.lang),];
    // TODO: implement initState
    super.initState();
  }





  int selected=3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(elevation: 0.0,backgroundColor: Theme.of(context).primaryColor,child: Icon(Icons.add,color: Colors.white,),onPressed: ()async{

      SharedPreferences  prefs = await SharedPreferences.getInstance();
      String id=prefs.getString('id');
      if(id==null){

        Navigator.push(context,MaterialPageRoute(builder: (context){
          return Login(widget.lang);

        }));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context){
          print(id);

          return AddProduct(widget.cou_id,id,widget.lang);
        }));


      }








    },),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,body: pages[selected],
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.white,type: BottomNavigationBarType.fixed,onTap: (index){
      setState(() {
        ([1,2 ].contains(index)&&widget.uid==null)?
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return Login(widget.lang);
        })):
        selected=index;



      });
    },currentIndex: selected,items: [
       BottomNavigationBarItem(icon: Icon((!widget.lang)?Icons.home:Icons.more_horiz),title: Text((widget.lang)?'المزيد':'Home',style:
      TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w700)
      ),),
       BottomNavigationBarItem(icon: Icon((widget.lang)?Icons.person:Icons.message,),title: Text((widget.lang)?'الشخصية':'Chats',style:
      TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w700),),),
       BottomNavigationBarItem(icon: Icon((widget.lang)?Icons.message:Icons.person),title: Text((widget.lang)?'المحادثات':'Profile',style:
      TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w700)
      ),),
       BottomNavigationBarItem(icon: Icon((widget.lang)?Icons.home:Icons.more_horiz,),title: Text((widget.lang)?'الرئسية':'More',style:
    TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w700),),),



    ],),);
  }


}


