import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mzad/Constants/loader.dart';
import 'package:mzad/Constants/widthandheight.dart';
import 'package:mzad/Offers.dart';
import 'package:mzad/productScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../search.dart';


class HOME extends StatefulWidget {
  String cou_id;
  bool lang;
  HOME(this.cou_id,this.lang);
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  String selected=null;
  String Selectedcategory;
  @override
  void initState() {
    Selectedcategory=(widget.lang)?'المحـــــــلـي':'Local';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,appBar: AppBar(actions: (!widget.lang)?[IconButton(icon: Icon(Icons.search,color: Colors.white),)]:null,leading: (widget.lang)?IconButton(icon: Icon(Icons.search,color: Colors.white),onPressed: (){


Navigator.push(context, MaterialPageRoute(builder: (context){
  return Search(widget.lang);
}));


      },):null,centerTitle: true,title: Text(Selectedcategory,style: TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w600),),),body: ListView(
      
      children: [
        
        Container(height: getwidth(context)/4,


            child:

        StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Categroies').snapshots(),

    builder: (BuildContext context, AsyncSnapshot Snap) {
    if ( !Snap.hasData) {
      return ListView.builder(reverse: widget.lang,scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,index){
        return
          Container(margin: EdgeInsets.all(2),child:CircleAvatar(backgroundColor: Colors.grey[200],maxRadius: getwidth(context)/8,minRadius: getwidth(context)/8,
              ));



      });
    }
    else {


    return ListView.builder(reverse: widget.lang,scrollDirection: Axis.horizontal,itemCount: Snap.data.documents.length,itemBuilder: (context,index){
    return
      InkWell(onTap: ()async{
        setState(() {
          selected=Snap.data.documents[index].documentID;
          Selectedcategory=(widget.lang)?Snap.data.documents[index].get('cat_name_ar'):Snap.data.documents[index].get('cat_name_en');
        });


    },child:
      Container(margin: EdgeInsets.all(2),child:CircleAvatar(backgroundColor: (selected==Snap.data.documents[index].documentID)? Colors.white:Colors.grey[200],maxRadius: getwidth(context)/8,minRadius: getwidth(context)/8,child:
      Container(margin: EdgeInsets.all(0),width: getwidth(context)/5,decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(getwidth(context)/5),image:DecorationImage(image:
      NetworkImage(Snap.data.documents[index].get('image')),
        fit: BoxFit.fitWidth,),),)))


      );



    });


    }})




        ),


        Container(padding: EdgeInsets.all(10),width: getwidth(context),child: Row(textDirection:(widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [

          Container(alignment: (widget.lang)?Alignment.centerRight:Alignment.centerLeft,width: getwidth(context)/2-10,child: Text((widget.lang)?'الاكثر زيارة':'MostVisited:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontFamily: 'mohab'),)),
          Container(alignment: (widget.lang)?Alignment.centerLeft:Alignment.centerRight,width: getwidth(context)/2-10,child:
          InkWell(child:
          Text((widget.lang)?'عرض المزيد':'Show More',textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor),),onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context){
  return null;

}));


          },)

          ),


        ],),)
    ,
        StreamBuilder(
    stream: (selected!=null)?
    FirebaseFirestore.instance.collection('Items').orderBy('seen', descending: true).where('cat_id',isEqualTo:selected ).limit(2).snapshots():

    FirebaseFirestore.instance.collection('Items').orderBy('seen', descending: true).where('country',isEqualTo:widget.cou_id ).limit(2).snapshots(),

    builder: (BuildContext context, AsyncSnapshot Snap) {
    if (!Snap.hasData) {
                     return Container(height: getheight(context)/3,child:

    ListView.builder(scrollDirection: Axis.horizontal,itemCount: 3,itemBuilder: (context,index){
      return Loader(context,widget.lang);
    }));
      }



    else {
    print(Snap.data.documents.length);




        return Container(height: getheight(context)/3,child:
        ListView.builder(reverse: widget.lang,scrollDirection: Axis.horizontal,itemCount:Snap.data.documents.length,itemBuilder: (context,index){
          return
            SingleProduct(Snap , index);







        }));


    }}),

        Container(padding: EdgeInsets.all(10),width: getwidth(context),child: Row(textDirection:(widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [

          Container(alignment:(widget.lang)?Alignment.centerRight :Alignment.centerLeft,width: getwidth(context)/2-10,child: Text((widget.lang)?'اضيفة موخرا':'Add Recently:',style: TextStyle(fontFamily: 'mohab',color: Colors.black,fontWeight: FontWeight.w800),)),
          Container(alignment:(widget.lang)?Alignment.centerLeft :Alignment.centerRight,width: getwidth(context)/2-10,child:
          InkWell(child:
          Text((widget.lang)?'عرض المزيد':'Show More',textDirection: TextDirection.rtl,style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'mohab'),),onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context){

  return Offers(widget.lang,3,(widget.lang)?'اضيفة موخرا':'Add Recently:','');

}));



            },)

          ),


        ],),)
        ,
        StreamBuilder(
            stream:
            (selected!=null)?
            FirebaseFirestore.instance.collection('Items').orderBy('time', descending: true).where('cat_id',isEqualTo:selected ).limit(2).snapshots():

            FirebaseFirestore.instance.collection('Items').orderBy('time',descending:true).where('country',isEqualTo:widget.cou_id ).limit(10).snapshots(),

            builder: (BuildContext context, AsyncSnapshot Snap) {
              if (!Snap.hasData) {

                return Container(height: getheight(context)/3,child:

                ListView.builder(scrollDirection: Axis.horizontal,itemCount: 3,itemBuilder: (context,index){
                  return Loader(context,widget.lang);
                }));

              }
              else {
                print(Snap.data.documents.length);




                return Container(height: getheight(context)/3,child:
                ListView.builder(reverse: widget.lang,scrollDirection: Axis.horizontal,itemCount:Snap.data.documents.length,itemBuilder: (context,index){
                  return
                    SingleProduct(Snap , index)

                  ;







                }));}}),





        Container(height: 20,),





      ],
      
      
      
    ),);
  }

 List<String> ero(var x){
    List<String> mm=[];

    for (var c in x){


    mm.add(c.toString());

    }


    return mm;




  }



  SingleProduct(var Snap ,int index){
   return InkWell(onTap: ()async{
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

      Navigator.push(context, MaterialPageRoute(builder: (context){

        return Product(Snap.data.documents[index].documentID,sharedPreferences.getString('id'),widget.lang,                            Snap.data.documents[index].get('name')
        );
      }));


    },child:
    Container(alignment: Alignment.topLeft,width: getheight(context)/3,child:

      Card(child:
      Column(children: [
        Snap.data.documents[index]['images'].length==0?
            Container(height:  getheight(context)/3-90-8,child:
  Card(color: Colors.grey,child:
  Center(child:Text('لاتوجد صور بالعرض',style: TextStyle(fontFamily: 'mohab'),))),


            ):

      Stack(children: [
        Card(color: Colors.grey,child:
        Container(height:  getheight(context)/3-90-8,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child:
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/gproject-8e0ce.appspot.com/o/"+
                  Snap.data.documents[index]['images'][0]+
                  '?alt=media&token=4c6ea3d4-0a0d-4a03-abc6-8c626229deb6',
              width: getwidth(context) / 1.5,
              height: getheight(context) / 3 - 80,
              fit: BoxFit.fill,),

          ),
        )


        ),

        Positioned(top: 8,right: 8,child: Container(padding: EdgeInsets.all(5),color:Theme.of(context).primaryColor,child:FutureBuilder(future:Firestore.instance.collection('Cities').document(Snap.data.documents[index]['gaver_id']).get(),
          builder: (BuildContext context,AsyncSnapshot Snap){
            if(!Snap.hasData){
              return Text('Loading');


            }else{

              return Text( (widget.lang)?Snap.data['ci_name_ar']:Snap.data['ci_name_en'],style: TextStyle(fontFamily: 'mohab',color: Colors.white),);
            }


          },






        )),)

      ]),



        Container(height: 82,color: Colors.white,
          child:
          Column(children: [
            Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

              Expanded(
                  child: Text(Snap.data.documents[index]['name'],textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700,color: Theme.of(context).primaryColor,fontFamily: 'mohab',))),

              Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                Icon(Icons.visibility,color: Theme.of(context).primaryColor,size: 13,),
                Text(' ('+Snap.data.documents[index]['seen'].toString()+') ',textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 10,fontFamily: 'mohab')),

              ],),
              Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                Icon(Icons.gavel,color: Theme.of(context).primaryColor,size: 13,),
                Text(' ('+Snap.data.documents[index]['bidscount'].toString()+') ',textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 10,fontFamily: 'mohab')),

              ],),

            ],),
        Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          Card(elevation: 0,color:Colors.grey[300],child:
            Text('  '+getStatus(Snap.data.documents[index]['status'])+'  ',style: TextStyle(fontFamily: 'mohab',color: Colors.redAccent,fontSize: 13),)),
          Card(elevation: 0,color:Colors.grey[300],child:
            Text(gettime(Snap, index),style: TextStyle(fontFamily: 'mohab',color: Colors.redAccent,fontSize: 13),)),


        ]),
            Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,children: [
              Row(textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [
                Icon(Icons.gavel,color: Theme.of(context).primaryColor,size: 17,),
                SizedBox(width: 5,),

                Text(Snap.data.documents[index]['bidprice']+'جنية',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 13,fontFamily: 'mohab',fontWeight: FontWeight.w700),),

              ],),
              SizedBox(width: 5,),
              Row(textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [
                Icon(Icons.gavel,color: Theme.of(context).primaryColor,size: 17,),
                SizedBox(width: 5,),

                Text(Snap.data.documents[index]['price']+'جنية',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 13,fontFamily: 'mohab',fontWeight: FontWeight.w700),),

              ],),
            ],)



          ],)







          ,
        )
      ],)





        ,),



    )
   );

  }




gettime(var Snap,int index){
  var time=DateTime.fromMillisecondsSinceEpoch(Snap.data.documents[index]['timeleft'].millisecondsSinceEpoch).difference(DateTime.now());
if(time.inSeconds<0){
  return (widget.lang)?' المزاد مغلق  ':'  Bid Closed  ';
}else{
  return 'المزاد مفتوح';
}

}


  String getStatus(int s){
    List Status;
    if(widget.lang){
      Status=[ '','جديد','مستعمل','تم تجديدة','استخلاص','مرتجع','تم بيعه'];
      return Status[s];

    }
    else{
      Status=['','New','Used','Refurbished','Salvage','Returns','Solded'];
      return Status[s];

    }



  }





}


