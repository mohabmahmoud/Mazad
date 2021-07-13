import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/widthandheight.dart';
import '../productScreen.dart';
class Categoryproducts extends StatefulWidget {
  String id;
  String name;
  String user_id;
  String cou_id;
  bool lang;
  Categoryproducts(this.id,this.name,this.user_id,this.cou_id,this.lang);
  @override
  _CategoryproductsState createState() => _CategoryproductsState();
}

class _CategoryproductsState extends State<Categoryproducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,title: Text(widget.name,style: TextStyle(fontFamily: 'mohab'),),),body: StreamBuilder(
        stream: Firestore.instance.collection('Items').orderBy('time', descending: true).where('cat_id',isEqualTo: widget.id).where('country',isEqualTo:widget.cou_id ).limit(10).snapshots(),

        builder: (BuildContext context, AsyncSnapshot Snap) {
          if (!Snap.hasData) {
            return Container(child: Center(child: Text('Loading')));

          }
          else {

            print(Snap.data.documents.length);




            return ListView.builder(itemCount:Snap.data.documents.length,itemBuilder: (context,index){
              var time=DateTime.fromMillisecondsSinceEpoch(Snap.data.documents[index]['timeleft'].millisecondsSinceEpoch).difference(DateTime.now());

              return

                InkWell (
                    onTap: ()async{
                      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context){

                        return Product(Snap.data.documents[index].documentID,sharedPreferences.getString('id'),widget.lang,
                            Snap.data.documents[index].get('name')
                        );
                      }));

                    },child:
                Container(width:getwidth(context),child:
                Card(color: Theme.of(context).primaryColor,child:
                Column(children: [
                  Stack(children: [
                    CarouselSlider(height: getheight(context)/3,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      items: ero(Snap.data.documents[index]['images']).map(
                            (url) {
                          return Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(0.0)),
                              child:
                              Image.network('https://firebasestorage.googleapis.com/v0/b/mzad-3c99c.appspot.com/o/'+url+'?alt=media&token=0ff658be-b089-4954-b143-967bf39f5223',width: getwidth(context),height:  getheight(context)/2-80 ,fit: BoxFit.fill,),

                            ),
                          );
                        },
                      ).toList(),
                    ),
                    Positioned(top: 8,right: 8,child: Container(padding: EdgeInsets.all(5),color:Theme.of(context).primaryColor,child:FutureBuilder(future:Firestore.instance.collection('Cities').document(Snap.data.documents[index]['gaver_id']).get(),
                      builder: (BuildContext context,AsyncSnapshot Snap){
                        if(!Snap.hasData){
                          return Text('Loading');


                        }else{

                          return Text((widget.lang)?Snap.data['ci_name_ar']:Snap.data['ci_name_en'],style: TextStyle(fontFamily: 'mohab',color: Colors.white),);
                        }


                      },






                    )),)
                    ,Positioned(bottom: 3,right: 5,child:Container(padding: EdgeInsets.all(5),color: (time.inSeconds>0)?Theme.of(context).primaryColor:Colors.red,child:Text((time.inSeconds>0)?'Days ('+time.inDays.toString()+') ,Hours ('+(time.inHours-time.inDays*24).toString()+')':'Closed',style: TextStyle(color: Colors.white,fontFamily: 'mohab'),))),


                  ],),


                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [

                    Container(width: getwidth(context)*2/3,alignment: Alignment.topLeft,child:
                    Text(Snap.data.documents[index]['name'],style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'mohab'))


                      ,)
                    ,Text(Snap.data.documents[index]['price'] +Snap.data.documents[index]['currency'],style: TextStyle(fontSize: 14,decoration: TextDecoration.lineThrough,color: Colors.white,fontFamily: 'mohab'),),

                  ],),
                  Row(children: [

                    Text('    LastBid : ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white,fontFamily: 'mohab'),),
                    Text(Snap.data.documents[index]['bidprice']+Snap.data.documents[index]['currency'],style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'mohab'),),
                    SizedBox(width: 5,),
                    Icon(Icons.visibility,color: Colors.white,),
                    Text('  (seen:'+Snap.data.documents[index]['seen'].toString()+')  ',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'mohab')),
                    SizedBox(width: 5,),
                    Icon(Icons.gavel,color: Colors.white,),
                    Text('  (bids:'+Snap.data.documents[index]['bidscount'].toString()+')  ',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'mohab')),

                  ],),
                  ListTile(subtitle: Text(Snap.data.documents[index]['des'],maxLines: 3,style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'mohab'))
                    ,)
                ],)





                  ,),



                )



                );







            });}}),);
  }

  List<String> ero(var x){
    List<String> mm=[];

    for (var c in x){


      mm.add(c);

    }


    return mm;




  }



}
