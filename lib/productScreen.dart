import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:mzad/Constants/widthandheight.dart';
import 'package:mzad/Login.dart';
import 'package:mzad/sentproduct.dart';
import 'package:mzad/showbids.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'chat.dart';
class Product extends StatefulWidget {
  bool lang;
  String id;
  String user_id;

  String name;
  Product(this.id,this.user_id,this.lang,this.name);
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var now = new DateTime.now();
  bool show=false;
  @override
  void initState() {
    addSeen();
    // TODO: implement initState
    super.initState();
  }


  TextEditingController bid_cont=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.id);


    return Scaffold(backgroundColor: Colors.grey[200],
      appBar: AppBar(actions: [IconButton(onPressed: (){
        String selected;
        showModalBottomSheet(
            context: context,
            builder: (builder){
              return  SendProduct(widget.lang,widget.user_id,widget.id);
            }
        );
      },icon: Icon(Icons.share,),)],centerTitle: true,title: Text(widget.name,style:TextStyle(fontFamily: 'mohab'),),),
      body:
        StreamBuilder(
        stream: Firestore.instance.collection('Items').document(widget.id).snapshots(),

    builder: (BuildContext context, AsyncSnapshot Snap) {
    if (!Snap.hasData) {
    return Container(child: Center(child: Text('Loading')));

    }
    else {

     return  Container(child:ListView(children: [
      Container(height:getheight(context)/3,child:

Container(child:
Stack(children: [
  (Snap.data['images'].length==0)?
  Container(height: getheight(context)/3,child: Center(child:

    Text('لا توجد صور بالعرض',style: TextStyle(fontFamily: 'mohab'),),),):
  CarouselSlider(height:  getheight(context)/3,
    autoPlay: true,
    viewportFraction: 1.0,
    items: ero(Snap.data['images']).map(
          (url) {
        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child:
            Image.network('https://firebasestorage.googleapis.com/v0/b/gproject-8e0ce.appspot.com/o/'+url+'?alt=media&token=0ff658be-b089-4954-b143-967bf39f5223',width: getwidth(context),height:  getheight(context)/3 ,fit: BoxFit.fill,),

          ),
        );
      },
    ).toList(),
  ),

  Positioned(top: 10,left: 0,child:
  Container(decoration: BoxDecoration(
  color: Colors.cyan,
    borderRadius: new BorderRadius.only(
  bottomRight: const Radius.circular(17.0),
    topRight: const Radius.circular(17.0),
  ),
  ),alignment: Alignment.center,width: 100,height: 35,child:Text(getStatus(widget.lang,(Snap.data['status']==null)?5:Snap.data['status']),style: TextStyle(fontFamily: 'mohab',fontSize: 14,color: Colors.white),))




  )


],)




)



        ,),
      Card(elevation: 0.0,child:Column(children: [
        Container(padding: EdgeInsets.only(left: 5,top: 10,right: 5,bottom: 0),child:
        Row(children: [
          Text(Snap.data['Qu'].toString()+'x',style: TextStyle(fontFamily: 'mohab'),),
          Text(Snap.data['name'],textDirection: TextDirection.rtl,style: TextStyle(fontSize: 18,fontFamily: 'mohab'),)

        ],)


          ,),
        Container(padding: EdgeInsets.only(left: 5,right: 5,bottom: 10),child:
      Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,children: [

      Text((widget.lang)?'السعر الابتدائي:  ':'Start price: ',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 14,fontFamily: 'mohab',fontWeight: FontWeight.w900,color: Colors.black38),),
      Text(Snap.data['price'],textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 16,fontFamily: 'mohab',fontWeight: FontWeight.w300,color: Colors.red,decoration: TextDecoration.lineThrough),),
      SizedBox(width: 5,),
      Text(Snap.data['bidprice']+' جنية ',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 16,fontFamily: 'mohab',fontWeight: FontWeight.w700,color: Colors.green),),

      ],)

      )

      ],)),
      Card(elevation: 0.0,child:Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,children: [

          Text((widget.lang)?' حالة المزاد:  ':' Auction Status: ',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 14,fontFamily: 'mohab',fontWeight: FontWeight.w900,color: Colors.black38),),
          (DateTime.fromMillisecondsSinceEpoch(Snap.data['timeleft'].millisecondsSinceEpoch).difference(DateTime.now()).isNegative)?Text((widget.lang)?'مغلق':'Closed',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 16,fontFamily: 'mohab',fontWeight: FontWeight.w300,color: Colors.red),):
          Text((widget.lang)?'مفتوح':'Open',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 16,fontFamily: 'mohab',fontWeight: FontWeight.w300,color: Colors.green),),

          /*(DateTime.fromMillisecondsSinceEpoch(Snap.data['timeleft'].millisecondsSinceEpoch).difference(DateTime.now()).isNegative)?Container(child:Text('mohab',style: TextStyle(color: Colors.white,fontFamily: 'mohab'),)):
          CountdownTimer(

            endTime: Snap.data['timeleft'].millisecondsSinceEpoch,
            daysSymbol: Text((widget.lang)?'يوم':'day',style: TextStyle(fontFamily: 'mohab'),),
            textStyle: TextStyle(fontSize: 15, color: Colors.green,fontFamily: 'mohab'),
            onEnd: (){
              setState(() {

              });
            },
          )*/

        ],),
        Container(padding: EdgeInsets.only(left: 20,right: 20),child:
        RaisedButton(color: Colors.green,onPressed:(DateTime.fromMillisecondsSinceEpoch(Snap.data['timeleft'].millisecondsSinceEpoch).difference(DateTime.now()).isNegative)?null:(){

       Navigator.push(context, MaterialPageRoute(builder: (context){
         return ShowBids(widget.id,widget.lang,Snap.data['timeleft'].millisecondsSinceEpoch,Snap.data['name'],widget.user_id);
       }));

        },child:
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Icon(Icons.gavel,color: Colors.white,),
              Text('مزيادة الان',style: TextStyle(fontFamily: 'mohab',color: Colors.white,fontWeight: FontWeight.w700),)

            ],)



          ,))
        
      ],)),


       
       

      Card(elevation: 0.0,child: Column(textDirection: TextDirection.ltr,children: [
      Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,child:Text((widget.lang)?': وصف السلعة ':' Description ',
      textAlign:(widget.lang)? TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: 'mohab',color: Colors.grey[400]),)),
        Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,child:Text(Snap.data['des'],textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style:
      TextStyle(fontFamily: 'mohab'))),
        Divider(),
        Row(textDirection: TextDirection.rtl,children: [
          Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,child:Text((widget.lang)?': المنطقة':'Location',
            textAlign:(widget.lang)? TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: 'mohab',color: Colors.grey[400]),)),
          FutureBuilder(future:Firestore.instance.collection('Countries').document(Snap.data['country']).get(),
            builder: (BuildContext context,AsyncSnapshot Snap){
              if(!Snap.hasData){
                return Text('Loading');


              }else{

                return Text((!widget.lang)?Snap.data['cn_name_en']:Snap.data['cn_name_ar'],textDirection: TextDirection.ltr,style: TextStyle(fontFamily: 'mohab'));

              }


            },






          ),
          Text(' - '),
          FutureBuilder(future:Firestore.instance.collection('Cities').document(Snap.data['gaver_id']).get(),
            builder: (BuildContext context,AsyncSnapshot Snap){
              if(!Snap.hasData){
                return Text('Loading');


              }else{

                return Text(Snap.data['ci_name_ar'],textDirection: TextDirection.ltr,style: TextStyle(fontFamily: 'mohab'),);
              }


            },






          ),

        ],),
        Divider(),
        Row(textDirection: TextDirection.rtl,children: [
          Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,child:Text((widget.lang)?':  المشاهدات  ':' Seens ',
            textAlign:(widget.lang)? TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: 'mohab',color: Colors.grey[400]),)),
          Text(Snap.data['seen'].toString(),style: TextStyle(fontFamily: 'mohab'),)


        ],),
        Divider(),
        Row(textDirection: TextDirection.rtl,children: [
          Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,child:Text((widget.lang)?':  المزيدات  ':'  Bids  ',
            textAlign:(widget.lang)? TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: 'mohab',color: Colors.grey[400]),)),
          Text(Snap.data['bidscount'].toString(),style: TextStyle(fontFamily: 'mohab'),)


        ],)


      ],)




      ),


       Card(elevation: 0.0,child:
       FutureBuilder(future: FirebaseFirestore.instance.collection('Users').doc(Snap.data['user_id']).get(),
         builder: (BuildContext context,AsyncSnapshot Snapp){
           if(!Snapp.hasData){
             return
               Column(children: [
                 SizedBox(height: 20,),
                 Container(height: 100,child:CircleAvatar(backgroundColor: Colors.grey,maxRadius: 100,child: Text('م',style: TextStyle(fontFamily: 'mohab',fontSize: 30,color: Colors.black),),)),
                 Text('مزاد',style: TextStyle(fontFamily: 'mohab',fontSize: 18,fontWeight: FontWeight.w700),),
                 Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                   RaisedButton(onPressed: null,child:Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.message),Text('محادثة',style: TextStyle(fontFamily: 'mohab'),)],)),
                   SizedBox(width: 5,),
                   RaisedButton(onPressed: null,child:Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.message),Text('محادثة',style: TextStyle(fontFamily: 'mohab'),)],))




                 ],)



               ],);

           }else{

             return
               Column(children: [
                 Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,child:Text((widget.lang)?' الحساب ':' Account ',
                   textAlign:(widget.lang)? TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: 'mohab',color: Colors.grey[400]),)),


                 SizedBox(height: 5,),
               Container(height: 100,child:CircleAvatar(backgroundColor: Colors.cyan,maxRadius: 100,child: Text(Snapp.data.get('name')[0],style: TextStyle(fontFamily: 'mohab',fontSize: 30,color: Colors.white),),)),
               Text(Snapp.data.get('name'),style: TextStyle(fontFamily: 'mohab',fontSize: 18,fontWeight: FontWeight.w700),),
               Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                 RaisedButton(color: Colors.blue,onPressed: (Snap.data['user_id']==widget.user_id)?null:(){














                   Firestore.instance.collection('mychats').where('ids', whereIn:[
                     [widget.user_id,Snap.data['user_id']], [Snap.data['user_id'],widget.user_id]
                   ]).where('name',isEqualTo: widget.name).getDocuments().then((value){
                     if(value.documents.length==0){
                       Firestore.instance
                           .collection('mychats').add({
                         'time': DateTime.now(),
                         'ids': [widget.user_id,Snap.data['user_id']],
                         'msg':'Start Now',
                         'name':widget.name





                       }).then((ov) {

                         print('added');
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return Chat(Snap.data['user_id'],widget.user_id,'mohab',widget.lang,ov.documentID);
                         }));
                       });


                     }else{
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return Chat(Snap.data['user_id'],widget.user_id,'mohab',widget.lang,value.documents[0].documentID);
                       }));


                       print(value.documents[0].documentID);


                     }



                   });








                 },child:Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.message,color: Colors.white,),Text((widget.lang)?'محادثة':'Chat',style: TextStyle(fontFamily: 'mohab',color: Colors.white),)],)),
                 SizedBox(width: 5,),
                 RaisedButton(color: Colors.green,onPressed: (){
                   UrlLauncher.launch(('tel:${Snapp.data.get('phone')}'));


                 },child:Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.phone,color: Colors.white,),Text((widget.lang)?'الاتصـال':'Call',style: TextStyle(fontFamily: 'mohab',color: Colors.white,),)],))




               ],)



             ],);


           }},)



       )










    ],) ,);}})
      
      
      
      
      
      
      ,);
  }







  String getStatus(bool lang,int s){
    List Status;
    if(lang){
      Status=[ '','جديد','مستعمل','تم تجديدة','استخلاص','مرتجع','تم بيعه'];
      return Status[s];

    }
    else{
      Status=['','New','Used','Refurbished','Salvage','Returns','Solded'];
      return Status[s];

    }



  }
  List<String> ero(var x){
    List<String> mm=[];

    for (var c in x){


      mm.add(c);

    }


    return mm;




  }


  addSeen ()async{
    var x=await Firestore.instance.collection('Items').document(widget.id).get();
    print(x['seen']);
    await Firestore.instance.collection('Items').document(widget.id).updateData(
        {
          'seen': x['seen']+1
        });


  }








}
