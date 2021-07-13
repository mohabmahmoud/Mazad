import 'package:flutter/material.dart';
import 'package:mzad/Constants/widthandheight.dart';
Loader(BuildContext context,bool lang){
  return  SizedBox(width: getwidth(context)/1.5,child:

  Card(child:
  Column(children: [


    Stack(children: [
      Card(color: Colors.grey[300],child:
      Container(width: getwidth(context)/1.5,height:  getheight(context)/3-90-8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          child:
          Center(child:Icon(Icons.image)),

        ),
      )


      ),

      Positioned(top: 8,right: 8,child: Container(padding: EdgeInsets.all(5),color:Theme.of(context).primaryColor,child:
      Container(child:Text('......'))
      ),)

    ]),



    Container(height: 82,color: Colors.white,
      child:
      Column(children: [
        Row(textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

Container(color:Colors.grey[300],child:Expanded(
              child: Text('......',textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700,color: Theme.of(context).primaryColor,fontFamily: 'mohab',)))),

          Row(textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Icon(Icons.visibility,color:Colors.grey[300],size: 13,),
            Text(' (..) ',textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 10,fontFamily: 'mohab')),

          ],),
          Row(textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Icon(Icons.gavel,color:Colors.grey[300],size: 13,),
            Text(' (..) ',textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 10,fontFamily: 'mohab')),

          ],),

        ],),
        Row(textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          Card(elevation: 0,color:Colors.grey[300],child:
          Text('   حالة المزاد  ',style: TextStyle(fontFamily: 'mohab',color: Colors.redAccent,fontSize: 13),)),
          Card(elevation: 0,color:Colors.grey[300],child:
          Text(' وقت الانتهاء ',style: TextStyle(fontFamily: 'mohab',color: Colors.redAccent,fontSize: 13),)),


        ]),
        Row(textDirection:(lang)? TextDirection.rtl:TextDirection.ltr,children: [
          Row(textDirection: (lang)?TextDirection.rtl:TextDirection.ltr,children: [
            Icon(Icons.gavel,color: Theme.of(context).primaryColor,size: 17,),
            SizedBox(width: 5,),

            Text('',textDirection: (lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 13,fontFamily: 'mohab',fontWeight: FontWeight.w700),),

          ],),
          SizedBox(width: 5,),
          Row(textDirection: (lang)?TextDirection.rtl:TextDirection.ltr,children: [
            Icon(Icons.gavel,color: Theme.of(context).primaryColor,size: 17,),
            SizedBox(width: 5,),

            Text('',textDirection: (lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 13,fontFamily: 'mohab',fontWeight: FontWeight.w700),),

          ],),
        ],)



      ],)







      ,
    )
  ],)





    ,),



  );


}