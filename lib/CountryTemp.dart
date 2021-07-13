import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller.dart';

class CountryTemp extends StatefulWidget {
  bool lang;

  CountryTemp(this.lang);
  @override
  _CountryTempState createState() => _CountryTempState();
}

class _CountryTempState extends State<CountryTemp> {
  ScrollController scrollController ;


  @override
  void initState() {

    scrollController = ScrollController();

  }
  int limit=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,title: Text((widget.lang)?'اختيار الدولة':'Select Country',style: TextStyle(fontFamily: 'mohab'),),),body:


    StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Countries').limit(limit).snapshots(),
      builder: (BuildContext context, AsyncSnapshot Snap) {
        if (!Snap.hasData) {
          return Container(child: Center(child: Text('جار التحميل',style: TextStyle(fontFamily: 'mohab'),)));

        }
        else {
          print(Snap.data.documents);
          return Container(child:
              NotificationListener(child:
          ListView.builder(controller: scrollController,itemCount: Snap.data.documents.length, itemBuilder: (context, index) {
            return
              Card(child:ListTile(onTap: ()async{
               SharedPreferences sharedPreferences;
                 sharedPreferences=await SharedPreferences.getInstance();
                 sharedPreferences.setString('country',Snap.data.documents[index].documentID);
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){

                   return Controller(Snap.data.documents[index].documentID,widget.lang,sharedPreferences.getString('id'));
                 }));





              },trailing: Icon(Icons.place),
                title: Text(Snap.data.documents[index]['cn_name_ar'],textAlign:TextAlign.center,style: TextStyle(fontFamily: 'mohab'),)
                  ,subtitle: Text(Snap.data.documents[index]['cn_name_en'],textAlign:TextAlign.center,style: TextStyle(fontFamily: 'mohab'),),
                ));
          }),

    onNotification: (t) {
    if (t is ScrollEndNotification) {
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){

    setState(() {
    print(limit);
    limit=limit+30;
    print(limit);


    });

    }}}
              ));
        }
      },)




      ,);
  }
}

