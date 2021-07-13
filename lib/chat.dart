import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'dart:async';

import 'Constants/widthandheight.dart';



class Chat extends StatefulWidget {
  String userid;
  String myid;
  String name;
  bool lang;
  String mydoc;

  Chat(this.userid,this.myid,this.name,this.lang,this.mydoc);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {









  @override
  void initState() {
    super.initState();
  }


























  TextEditingController con=new TextEditingController();

String kk;

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Colors.grey[300],


    appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.close,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),

        actions: <Widget>[





        ],elevation: 1,
        centerTitle: false,title:
    Text(widget.name,maxLines: 1,textDirection:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab',fontSize: 17),)
    )
    ,
    body:


    Container(height: getheight(context),
      child:
      ListView(children: <Widget>[
        Container(height: getheight(context)*.8,child:
        StreamBuilder(stream: Firestore.instance.collection('msg').where('chat_id',isEqualTo: widget.mydoc).orderBy('time',descending:true).snapshots(),
            builder: (BuildContext context,AsyncSnapshot Snap){
              if(Snap.data==null){
                return Center(child:CircularProgressIndicator());
              }

              else{

                return ListView.builder(reverse: true,itemCount: Snap.data.documents.length,itemBuilder: (context,index){
                  return (Snap.data.documents[index]['id']!=widget.myid)?
                      reciver(Snap.data.documents[index]['msg']):
                  sender( Snap.data.documents[index]['msg']);

                } );}})









        ),








        Container(height: getheight(context)*.1,color: Colors.white,child:
        Container(color: Colors.grey[200],height: getheight(context)*.1,
            child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Container(width: getwidth(context),height: getheight(context)*.1-20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: Colors.white






                      ),
                    ),child:Container(padding: EdgeInsets.only(left: 30,right: 30),
                        child:TextField(maxLines: 20,
                      controller: con,keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(suffixIcon: Container(child:IconButton(icon:Icon(Icons.send),onPressed: (){


                        Firestore.instance.collection('msg')
                            .document()
                            .setData({
                          'type':1,
                          'id':widget.myid.toString(),
                          'msg': con.text,
                          'time':DateTime.now(),
                          'chat_id':widget.mydoc
                        });


                        Firestore.instance.collection('mychats')
                            .document(widget.mydoc)
                            .updateData({
                          'msg': con.text,
                          'time':DateTime.now()
                        });


                        con.clear();



                      })),hintText: (widget.lang)?'رسالة':'message',
                      border: InputBorder.none
                    ),
                      textAlign: TextAlign.start,

                      cursorColor: Colors.grey,enableSuggestions: true,autocorrect: true,))
                ),


              ],
            )
        ),

        ),


      ],),),






    );





  }
Widget sender(String msg){
    return Column(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[

        Container(padding: EdgeInsets.only(right: 20,left: 70),

            child:
            Container(padding:EdgeInsets.all(10),decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    bottomLeft:  const Radius.circular(15),
                    topRight:  const Radius.circular(15)
                )

            ),
              child:

                Text(msg,style:
              TextStyle(fontFamily: 'mohab',color: Colors.white,fontWeight: FontWeight.w700),),
            )


        ),
      Padding(padding: EdgeInsets.only(bottom: 10),)


    ],);
}


Widget reciver(String msg){
  return Column(children: <Widget>[
    Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[

      Container(padding: EdgeInsets.only(right: 70,left: 20),


          child:
          (Container(padding:EdgeInsets.all(10),decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  bottomRight:  const Radius.circular(15),
                  topRight:  const Radius.circular(15)
              )

          ),
            child:
            Center(child:Text(msg,style:TextStyle(fontFamily: 'mohab',color: Colors.black,fontWeight: FontWeight.w700),)),
          ))


      ),
      Container(),


    ],),
    Padding(padding: EdgeInsets.only(bottom: 10),)
  ],);
}
  b() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }


}
