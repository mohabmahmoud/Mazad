import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mzad/Constants/widthandheight.dart';
class Profile extends StatefulWidget {
  String id;
  bool lang;
  Profile(this.id,this.lang);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);


    return Scaffold(appBar: AppBar(title: Text((!widget.lang)?'User Profile':'البيانات الشخصية',style: TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.w900),),centerTitle: true,),body: Container(child:
    FutureBuilder(
    future: FirebaseFirestore.instance.collection('Users').doc(widget.id).get(),

    builder: (BuildContext context, AsyncSnapshot Snap) {
    if (!Snap.hasData) {
    return Container(child: Center(child: Text('Loading',style: TextStyle(fontFamily: 'mohab'),)));

    }
    else {
    return

    ListView(
      children: [
        Container(padding: EdgeInsets.all(20),width:200,child:
        CircleAvatar(child: Text(Snap.data['name'].substring(0,1),style: TextStyle(fontSize: 30,fontFamily: 'mohab'),),radius: 50,)
        )
        ,Text(Snap.data['name'],textAlign: TextAlign.center,style: TextStyle(fontSize:20,fontWeight: FontWeight.w900,fontFamily: 'mohab'),),
        Text(Snap.data['email'],textAlign: TextAlign.center,style: TextStyle(fontSize:18,fontWeight: FontWeight.w400,fontFamily: 'mohab'),),
        Text(Snap.data['phone'],textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.w400,fontFamily: 'mohab'),),
       InkWell(onTap: ()async{

           try {
             await FirebaseAuth.instance.sendPasswordResetEmail(email: Snap.data['email']);
             showDialog(
               context: context,
               builder: (BuildContext context) {
                 return AlertDialog(
                   content: Text((widget.lang)?"تحقق من البريد الالكتروني الذي قمت بادخالة عند التسجيل":'Check Your Email Now You Have Recive Email To Chang Your password!' ,style: TextStyle(fontFamily: 'mohab'),),
                   actions: [
                     FlatButton(
                       child: Text((widget.lang)?'غلق':"Close",style: TextStyle(fontFamily: 'mohab'),),
                       onPressed:  () {
                         Navigator.pop(context);
                       },
                     )
                   ],
                 );
               },
             );



           } catch (e) {
             print('mohab');
             print(e);
           }


       },child:
        Row(textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,mainAxisAlignment: MainAxisAlignment.center,children: [
          Icon(Icons.lock_outline,color: Theme.of(context).primaryColor,),
          Text((!widget.lang)?'Change Password':'تغير كلمة المرور',style: TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor,decoration: TextDecoration.underline),)
        ],)),
        StreamBuilder(stream: Firestore.instance.collection('Items').where('user_id',isEqualTo: widget.id).snapshots()
        ,builder:(BuildContext context, AsyncSnapshot Snap) {
    if (!Snap.hasData) {
    return Container(child: Center(child: Text('Loading',style: TextStyle(fontFamily: 'mohab'),)));

    }
    else {

      return ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true ,itemCount: Snap.data.documents.length,itemBuilder: (context,index){
        return


          Card(child:
              Column(children: [
                Row(textDirection:(widget.lang)?TextDirection.rtl:TextDirection.ltr,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Container(width: getwidth(context)/3,child:
                  Card(child:Image.network("https://firebasestorage.googleapis.com/v0/b/gproject-8e0ce.appspot.com/o/"+Snap.data.documents[index]['images'][0]+'?alt=media&token=0ff658be-b089-4954-b143-967bf39f5223'),))

                  , Container(padding: EdgeInsets.all(2),width:(getwidth(context)*2/3)-8 ,child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                    ListTile(title: Text(Snap.data.documents[index]['name'],textDirection:(widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.blueGrey),),
                        subtitle:Text(Snap.data.documents[index]['des'],textDirection:(widget.lang)?TextDirection.rtl:TextDirection.ltr,style: TextStyle(fontFamily: 'mohab',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey))),





                  ],))

                ],),
                (Snap.data.documents[index]['status']!=6)?Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,textDirection:(widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [
                  RaisedButton(color: Colors.blue,onPressed: (){
                    Firestore.instance.collection('Items').document(Snap.data.documents[index].documentID).updateData(
                        {
                          'status': 6,
                          'timeleft':DateTime.now().subtract(Duration(days: 2))
                        });

                  },child:Text((widget.lang)?'تم البيع':'Sell Done',style: TextStyle(fontFamily: 'mohab',fontSize: 13,color: Colors.white),)),
                  RaisedButton(color: Colors.blue,onPressed: (){



                    showDatePicker(context: context, initialDate: DateTime.now().add(new Duration(days:1)), firstDate: DateTime.now().add(new Duration(days:1)), lastDate:DateTime.now().add(new Duration(days:30))


                    ).then((value)async{
                      print(Snap.data.documents[index].documentID);



                      if(value!=null) {
                        await Firestore.instance.collection('Items').document(Snap.data.documents[index].documentID).updateData(
                            {
                              'timeleft': value
                            });
                      }});



                    },child:Text((widget.lang)?'تغير تاريخ الانتهاء':'Change Time left',style: TextStyle(fontFamily: 'mohab',fontSize: 13,color: Colors.white),)),
                  RaisedButton(color: Colors.red,onPressed: (){

                  Firestore.instance.collection('Items').document(Snap.data.documents[index].documentID).delete();


                    },child:Text((widget.lang)?'مسح':'Delete',style: TextStyle(fontFamily: 'mohab',fontSize: 13,color: Colors.white),)),


                ],):Container(height: 2,)
              ],)



          );
      });


      }})
        






      ],
    );}})




    ),);
  }
}
