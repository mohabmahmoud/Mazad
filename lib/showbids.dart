import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:mzad/Constants/widthandheight.dart';
class ShowBids extends StatefulWidget {
  String id;
  bool lang;
  var time;
  String user_id;
  String name;
  ShowBids(this.id,this.lang,this.time,this.name,this.user_id);
  @override
  _ShowBidsState createState() => _ShowBidsState();
}

class _ShowBidsState extends State<ShowBids> {
  TextEditingController bid_cont=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[200],
    appBar: AppBar(centerTitle: true,title:Text(widget.name)
    ,bottom:PreferredSize(child:
    StreamBuilder(
    stream: Firestore.instance.collection('Items').document(widget.id).snapshots(),

    builder: (BuildContext context, AsyncSnapshot Snap) {
    if (!Snap.hasData) {
    return Container(child: Center(child: Text('..')));

    }else{
    return Container(padding: EdgeInsets.only(left:20,right: 20),height: 40,child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          /*CountdownTimer(
            endTime: Snap.data['timeleft'].millisecondsSinceEpoch,
            daysSymbol: Text((widget.lang)?'يوم':'day',style: TextStyle(fontFamily: 'mohab'),),
            textStyle: TextStyle(fontSize: 15, color: Colors.black,fontFamily: 'mohab',fontWeight: FontWeight.w900),
            onEnd: (){
              setState(() {

              });
            },
          )*/ SizedBox(width: 5,),
          Text(Snap.data['bidprice']+' جنية ',textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontSize: 16,fontFamily: 'mohab',fontWeight: FontWeight.w700,color: Colors.green),),

        ],)

    ,);
    }})
          ,preferredSize: Size.fromHeight(40)



      ),),
    body: StreamBuilder(
      stream: Firestore.instance.collection('Bids').where('pro_id',isEqualTo: widget.id).orderBy('time' ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot Snap) {
        if (!Snap.hasData) {
          return Container(child: Center(child: Text((widget.lang)?'جار التحميل':'loading',style: TextStyle(fontFamily: 'mohab'),)));

        }
        else {
          print(Snap.data.documents);
          return Container(height: getheight(context),child:
              Column(children: [
                Expanded(child:
                ListView.builder(itemCount: Snap.data.documents.length, itemBuilder: (context, index) {
                  return
                    Card(child:ListTile(trailing: Icon(Icons.gavel),
                      title:
                       FutureBuilder(
    future: FirebaseFirestore.instance.collection('Users').doc(Snap.data.documents[index]['user_id']).get(),
    builder: (BuildContext context, AsyncSnapshot s) {
    if (!s.hasData) {
    return Container(child: Center(child: Text('...',style: TextStyle(fontFamily: 'mohab'),)));

    }
    else {
                 return     Text(s.data.get('name'),textAlign:TextAlign.center,style: TextStyle(fontFamily: 'mohab'),);
    }})

                      ,subtitle: Text('  جنية '+Snap.data.documents[index]['price'],textAlign:TextAlign.center,style: TextStyle(fontFamily: 'mohab'),),
                    ));
                }),),
                Container(height: 50,child:Row(children: [
                  Padding(padding: EdgeInsets.only(left: 5,right: 5),child:Container(width: getwidth(context)/2,
                    alignment: Alignment.center,
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Theme.of(context).primaryColor)),
                    height: 40.0,
                    child: TextField(onChanged: (email){



                    },controller: bid_cont,
                      textAlign:TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'mohab',
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets. all(5),


                          hintText:(widget.lang)?'السعر':'Price',
                          hintStyle:
                          TextStyle(fontFamily: 'mohab',color: Colors.green)
                      ),
                    ),
                  )),
                  Padding(padding: EdgeInsets.only(left: 5,right: 5),child:Container(width: getwidth(context)/2-20,child:RaisedButton(color: Colors.green,onPressed: () async{

                    var x=await Firestore.instance.collection('Items').document(widget.id).get();
                    if(int.parse(x['bidprice'])<int.parse(bid_cont.text)) {
                      await Firestore.instance.collection('Items')
                          .document(widget.id)
                          .updateData(
                          {
                            'bidprice': bid_cont.text,
                            'bidscount':x['bidscount']+1
                          });



                      await Firestore.instance
                          .collection('Bids').add({
                        'user_id':widget.user_id,
                        'pro_id':widget.id,
                        'price':bid_cont.text,
                        'time':DateTime.now()


                      });
                      Navigator.pop(context);



                    }else{
                      Navigator.pop(context);

                      showDialog<void>(
                          context: context,
                          barrierDismissible: true, // user must tap button!
                          builder: (BuildContext context) {

                            return AlertDialog(backgroundColor: Theme.of(context).primaryColor,
                              title: Text((widget.lang)?'خطا':'Error',textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab',color: Colors.white)),
                              content:




                              Text((widget.lang)?'يجب ان يكون السعر اعلي من اخر مزايدة':'Time Out',textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab',color: Colors.white)),



                              actions: <Widget>[
                                FlatButton(
                                  child: Text((widget.lang)?'اغلاق':'Colse',style: TextStyle(fontFamily: 'mohab',color: Colors.redAccent)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),

                              ],
                            );});





                    }



                    },child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.gavel,color:Colors.white),
                    Text((widget.lang)?'مزيادة الان':'Bid Now',style: TextStyle(color:Colors.white,fontFamily: 'mohab',fontWeight: FontWeight.w700),)

                  ],)
                  )))


                ],))

              ],)




          );
        }
      },) ,
    );
  }
}
