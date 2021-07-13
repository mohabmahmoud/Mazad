import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/widthandheight.dart';

class Offers extends StatefulWidget {
  bool lang;
  int type;
  String name;
  String id;
  Offers(this.lang,this.type,this.name,this.id);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  ScrollController scrollController ;


  @override
  void initState() {

    scrollController = ScrollController();

    // TODO: implement initState
    super.initState();
  }
  int limit=10;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;


    return Scaffold(appBar: AppBar(centerTitle: true,
      title: Text(widget.name),),body: Container(child: StreamBuilder( stream:

    (widget.type==0)? //offers
    FirebaseFirestore.instance.collection('Items').where('status',isEqualTo: 2).orderBy('time', descending: true).limit(limit).snapshots():
    (widget.type==1)? //items by category
    FirebaseFirestore.instance.collection('Items').where('cat_id',isEqualTo: widget.id).where('status', whereIn: [1,2]).orderBy('time', descending: true).limit(limit).snapshots():
    (widget.type==2)? //mostvisted
    FirebaseFirestore.instance.collection('Items').orderBy('seen', descending: true).limit(limit).snapshots():
    (widget.type==3)? //add recently
    FirebaseFirestore.instance.collection('Items').orderBy('time', descending: true).limit(limit).snapshots():
    (widget.type==4)? //store items
    FirebaseFirestore.instance.collection('Items').where('status',isEqualTo: 1).where('store_id',isEqualTo: widget.id).limit(limit).snapshots():
    (widget.type==5)?
    FirebaseFirestore.instance.collection('Items').where('status',isEqualTo: 2).where('store_id',isEqualTo: widget.id).limit(limit).snapshots():null



      ,


      builder: (BuildContext context, Snapshot) {

        if(Snapshot.hasData){
          print(Snapshot.data.documents[0].runtimeType);
          return NotificationListener(child:
          SingleChildScrollView(controller:scrollController ,child
              :
          GridView.count(physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: ((getwidth(context)/2) / getheight(context)*3),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: Snapshot.data.documents.map<Widget>((value) {
              return
                InkWell(onTap: ()async{
                  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return null;//ItemScreen(widget.lang,value.get('name'),value.documentID,sharedPreferences.get('id'));

                  }));
                },child:Card(child:Stack(children: [

                Container(child: Column(children: [
                  Card(child:Image.network('https://firebasestorage.googleapis.com/v0/b/mzad-3c99c.appspot.com/o/'+value.get('images')[0]+'?alt=media&token=0ff658be-b089-4954-b143-967bf39f5223',height:getheight(context)/3-90-8-8 ,width: getwidth(context)/2,fit: BoxFit.fill,)),

                  Container(height: 30,padding: EdgeInsets.only(right:10,left: 10),child:Row(textDirection: (!widget.lang)?TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text(value.get('price'),textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 13,fontFamily: 'mohab',fontWeight: FontWeight.w600),),

                    Text(value.get('name'),maxLines: 1,style: TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w700),),
                  ],)
                  ),
                  Container(alignment: Alignment.topCenter,height: 20,padding: EdgeInsets.only(right:10,left: 10),child:
                  Row(textDirection: (!widget.lang)?TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text(value.get('price'),textDirection:  (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 12,decoration:TextDecoration.lineThrough,color: Colors.red,fontFamily: 'mohab',fontWeight: FontWeight.w400),),


                    Row(textDirection: TextDirection.rtl,children: [
                      Icon(Icons.visibility,size: 15,color: Theme.of(context).primaryColor,),
                      Container(width: 7,),

                      Text('('+value.get('seen').toString()+')',textDirection:(widget.lang)?TextDirection.ltr: TextDirection.rtl,textAlign: TextAlign.start,style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'mohab',fontSize: 12,fontWeight: FontWeight.w400),),


                    ],),



                  ],),


                  ),
                  Divider(color: Colors.grey,),
                  /*CountdownTimer(
                    endTime: value['timeleft'].millisecondsSinceEpoch,
                    daysSymbol: Text((widget.lang)?'يوم':'day',style: TextStyle(fontFamily: 'mohab'),),
                    textStyle: TextStyle(fontSize: 10, color: Colors.black,fontFamily: 'mohab',fontWeight: FontWeight.w900),
                    onEnd: (){
                      setState(() {

                      });
                    },
                  )*/






                ],),),


              ],)));
            }).toList(),
          ),
          ),



              onNotification: (t) {
            if (t is ScrollEndNotification) {
              if(scrollController.position.pixels==scrollController.position.maxScrollExtent){

                setState(() {
                  print(limit);
                  limit=limit+10;
                  print(limit);


                });

              }
            }
          });


        }
        else{

          return Container(alignment: Alignment.center,height:getheight(context),child:
          CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,)

          );

        }

      },),),);
  }




}

