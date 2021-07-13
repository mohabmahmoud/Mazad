import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
class MyChats extends StatefulWidget {
  bool lang;
  String user_id;
  MyChats(this.user_id,this.lang);
  @override
  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,title: Text((widget.lang)?'الدردشات':'MyChats',style: TextStyle(fontFamily: 'mohab'),),),body: Container(

       child: FutureBuilder(
          future: Firestore.instance.collection('mychats').where('ids',arrayContains: widget.user_id).orderBy('time',descending:true).getDocuments(),
          builder: (BuildContext context, AsyncSnapshot Snap) {
            if (!Snap.hasData) {
              return Container(child: Center(child: Text('جار التحميل',style: TextStyle(fontFamily: 'mohab'),)));

            }
            else {
              print(Snap.data.documents);
              return Container(child:
              ListView.builder(itemCount: Snap.data.documents.length, itemBuilder: (context, index) {
                var time=DateTime.fromMillisecondsSinceEpoch(Snap.data.documents[index]['time'].millisecondsSinceEpoch).difference(DateTime.now());



                return
                  Card(child:ListTile(onTap: ()async{


                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      List x=Snap.data.documents[index]['ids'].toString().split('-');
                        return   Chat((x[0]==widget.user_id)?x[1]:x[0],widget.user_id,Snap.data.documents[index]['name'],widget.lang,Snap.data.documents[index].documentID);
                    }));





                  },leading: Text((time.inMinutes*-1<60)?'منذ '+(time.inMinutes*-1).toString()+'دقائق':
                  (time.inHours*-1<24)?'منذ '+(time.inHours*-1).toString()+'ساعة':(time.inDays*-1<99)?
                  'منذ '+(time.inDays*-1).toString()+'يوم':DateTime.fromMillisecondsSinceEpoch(Snap.data.documents[index]['time'].millisecondsSinceEpoch).year.toString()+'-'+
                      DateTime.fromMillisecondsSinceEpoch(Snap.data.documents[index]['time'].millisecondsSinceEpoch).month.toString()+'-'+

                      DateTime.fromMillisecondsSinceEpoch(Snap.data.documents[index]['time'].millisecondsSinceEpoch).day.toString()
                    ,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 10,fontFamily: 'mohab'),),trailing:CircleAvatar(child: Text(Snap.data.documents[index]['name'][0]),),
                    title: Text(Snap.data.documents[index]['name'],textAlign:TextAlign.center,style: TextStyle(fontFamily: 'mohab'),)
                    ,subtitle: Text(Snap.data.documents[index]['msg'],textAlign:TextAlign.center,style: TextStyle(fontFamily: 'mohab'),),



                  ));
              }),);
            }
          },)


    ),);
  }
}
