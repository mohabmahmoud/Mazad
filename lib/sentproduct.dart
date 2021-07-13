import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SendProduct extends StatefulWidget {
  bool lang;
  String userid;
  String product;
  SendProduct(this.lang,this.userid,this.product);
  @override
  _SendProductState createState() => _SendProductState();
}

class _SendProductState extends State<SendProduct> {
  String selected;
  String name='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RaisedButton(color: Colors.blueAccent,child:
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Text((widget.lang)?'ارسال':'Send',style: TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w700,color: Colors.white)),
            SizedBox(width: 5,),
            Icon(Icons.send,color: Colors.white),

            ],)

        ,onPressed: (selected==null)?null:(){


          FirebaseFirestore.instance.collection('msg')
              .doc()
              .set({
            'type':2,
            'id':widget.userid,
            'product':widget.product,
            'time':DateTime.now(),
            'chat_id':selected
          });


          FirebaseFirestore.instance.collection('mychats')
              .doc(selected)
              .update({
            'msg':'عرض',
            'time':DateTime.now()
          });
          Navigator.pop(context);



        },),appBar: AppBar(leading: IconButton(icon: Icon(Icons.close),onPressed:(){
          Navigator.pop(context);
          },),centerTitle: true,title: Text((widget.lang)?'مشاركة':'Share'),),body: FutureBuilder(
      future: Firestore.instance.collection('mychats').where('ids',arrayContains: widget.userid).orderBy('time',descending:true).getDocuments(),
      builder: (BuildContext context, AsyncSnapshot Snap) {
        if (!Snap.hasData) {
          return Container(child: Center(child: Text((widget.lang)?'جار التحميل':'Loading',style: TextStyle(fontFamily: 'mohab'),)));

        }
        else {
          print(Snap.data.documents);
          return Container(child:
          ListView.builder(itemCount: Snap.data.documents.length, itemBuilder: (context, index) {



            return
              Card(color: (Snap.data.documents[index].documentID==selected)?Colors.blueAccent[100]:Colors.white,elevation: 0.0,child:
              FutureBuilder(future: FirebaseFirestore.instance.collection('Users').doc((Snap.data.documents[index]['ids'][0]==widget.userid)?Snap.data.documents[index]['ids'][1]:Snap.data.documents[index]['ids'][0]).get()
                  ,
                  builder: (BuildContext context, AsyncSnapshot Snapp) {
                    if (!Snap.hasData) {
                      return Container(child: Center(child: Text((widget.lang)?'جار التحميل':'Loading',style: TextStyle(fontFamily: 'mohab'),)));

                    }else{
                      return  ListTile(onTap: (){

                        setState(() {
                          selected=Snap.data.documents[index].documentID;

                        });





                      },trailing:(widget.lang)?CircleAvatar(child: Text(Snapp.data.get('name')[0],style: TextStyle(fontFamily: 'mohab')),):null,
                        leading:(!widget.lang)?CircleAvatar(child: Text(Snapp.data.get('name')[0],style: TextStyle(fontFamily: 'mohab')),):null,
                        title: Text(Snapp.data.get('name'),textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab',),)
                        ,subtitle: Text(((widget.lang)?' رسالة: ':' Message: ')+Snap.data.documents[index]['msg'],textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab'),),



                      );
                    }
                  }
              )   ,



              );
          }),);
        }
      },),);
  }
}
