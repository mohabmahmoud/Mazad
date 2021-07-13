import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mzad/Constants/widthandheight.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddProduct extends StatefulWidget {
  String country_id;
  String user_id;
  bool lang;
  AddProduct(this.country_id,this.user_id,this.lang);
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var image = null;
  List images = [];
  List images_path = [];
  String catname;

  String gavname;
  String catid;
  String gavid;
  int st_id;

  String Currencyname;
  String status;


  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController Qu = TextEditingController();

  int Q = 1;

var mydate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar:


    Container(color: Theme
        .of(context)
        .primaryColor,
        child: FlatButton(child: Text((widget.lang)?'اضـــافة':'Add', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
        ,fontFamily: 'mohab'
        ),),
          onPressed: () {
          if(name.text.length<5){


          }else if(images.length<1){


          }
          else if(catid==null){


          }else if(st_id==null){


          }else if(gavid==null){


          }else if(Qu.text==null){


          }else if(price.text==''){


          }else if(desc.text==''){


          }else{
print("kkk");
            add();

          }














          },))


      ,
      appBar: AppBar(centerTitle: true, title: Text((!widget.lang)?'Add Product':'اضافة مزاد',style: TextStyle(fontFamily: 'mohab'),),),
      body: Container(child: ListView(
        children: [
          SizedBox(height: 30,),
          Container(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text((widget.lang)?'اضافة صور:'+images_path.length.toString():'Add Photos:'+images_path.length.toString(),textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,
                style: TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.bold, color: Theme
                    .of(context)
                    .primaryColor),)),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10), child: InkWell(
            child:
            Container(


                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Theme
                        .of(context)
                        .primaryColor)),
                height: 60.0, child: Icon(Icons.add, color: Colors.black)),
            onTap: () {
              getimage();
            },)),
          SizedBox(height: 30,),

          Padding(padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(padding: EdgeInsets.only(left: 10, right: 10),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Theme
                        .of(context)
                        .primaryColor)),
                height: 60.0,
                child: TextField(onChanged: (email) {


                },
                  controller: name,
                  textAlign: (widget.lang)?TextAlign.right:TextAlign.left,
                  keyboardType: TextInputType.text,textDirection:TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'mohab',
                  ),
                  decoration: InputDecoration(
                    prefixText: (widget.lang)?'':'Product Name:',
                    suffixText:  (!widget.lang)?'':':اسم المنتج ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 5.0),
                  ),
                ),
              )),
          SizedBox(height: 30,),

          InkWell(onTap: () {
            selectcategory();



          },
              child: Padding(padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Theme
                              .of(context)
                              .primaryColor)),
                      height: 60.0,
                      child:
                      Row(textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [

                        Text((widget.lang)?': القسم':'Category:',
                          style: TextStyle(color: Colors.black87,fontFamily: 'mohab'),),
                        Container(
                            child: Text((catname==null&&widget.lang)?'اسم القسم':(catname==null&&!widget.lang)?'Category Name':catname, textAlign: TextAlign.center,style: TextStyle(fontFamily: 'mohab',fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),))


                      ],)
                  ))),
          SizedBox(height: 30,),

          InkWell(onTap: () {
            selectgaverment();


          },
              child: Padding(padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Theme
                              .of(context)
                              .primaryColor)),
                      height: 60.0,
                      child:
                      Row(textDirection:(widget.lang)? TextDirection.rtl:TextDirection.ltr,children: [

                        Text((widget.lang)?' : المنطقة':'Region:',
                          style: TextStyle(color: Colors.black87,fontFamily: 'mohab'),),
                        Container(
                            child: Text((gavname==null&&widget.lang)?'اسم المنطقة':(gavname==null&&!widget.lang)?'Region Name':gavname, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'mohab'),))


                      ],)
                  ))),
          SizedBox(height: 30,),

          Padding(padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(padding: EdgeInsets.only(left: 10, right: 10),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Theme
                        .of(context)
                        .primaryColor)),
                height: 60.0,
                child: TextField(onChanged: (email) {


                },
                  controller: price,
                  textAlign: (widget.lang)?TextAlign.right:TextAlign.left,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'mohab',
                  ),
                  decoration: InputDecoration(prefixText:(widget.lang)? '':'Product Start Price:',
                    suffixText: (!widget.lang)? '':': السعر الابتدائي',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 5.0),
                  ),
                ),
              )),
          SizedBox(height: 30,),


          InkWell(onTap: () {
            selectCurrency();


          },
              child: Padding(padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Theme
                              .of(context)
                              .primaryColor)),
                      height: 60.0,
                      child:
                      Row(textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [

                        Text((!widget.lang)?'Currency:':': العملة ',
                          style: TextStyle(color: Colors.black87,fontFamily: 'mohab'),),
                        Container(
                            child: Text((Currencyname==null&&widget.lang)?'اختيار العملة':(Currencyname==null&&widget.lang)?'Currency Name':Currencyname, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'mohab'),))


                      ],)
                  ))),

          SizedBox(height: 30,),
          InkWell(onTap: () {
            selectstatus();


          },
              child: Padding(padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Theme
                              .of(context)
                              .primaryColor)),
                      height: 60.0,
                      child:
                      Row(textDirection: (widget.lang)?TextDirection.rtl:TextDirection.ltr,children: [

                        Text((widget.lang)?':  الحالة ':'Status:',
                          style: TextStyle(color: Colors.black87,fontFamily: 'mohab'),),
                        Container(
                            child: Text((status==null&&widget.lang)?'اختار الحالة ':(status==null&&!widget.lang)?'Select Status':status, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'mohab'),))


                      ],)
                  ))),

          SizedBox(height: 30,),

          Container(
              padding: EdgeInsets.only(left: 10, right: 10), height: 60, child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

            Container(width: getwidth(context) / 4,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Theme
                      .of(context)
                      .primaryColor)),
              height: 60.0,
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.black,), onPressed: () {
                setState(() {
                  Q = Q + 1;
                  Qu.text = Q.toString();
                });
              },),
            ),
            Container(
              width: getwidth(context) / 3,
              padding: EdgeInsets.only(left: 0, right: 0),
              decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Theme
                      .of(context)
                      .primaryColor)),
              height: 60.0,
              child: TextField(onChanged: (v) {
                setState(() {
                  Q = int.parse(v);
                });
              },
                controller: Qu,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'mohab',
                ),
                decoration: InputDecoration(
                  prefixText: (widget.lang)?'':'Q:',
                  suffixText:(!widget.lang)?'':': الكمية  ',

                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 5.0),


                ),
              ),
            ),
            Container(width: getwidth(context) / 4,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Theme
                      .of(context)
                      .primaryColor)),
              height: 60.0,
              child: IconButton(
                icon: Icon(Icons.remove, color: Colors.black,), onPressed: () {
                setState(() {
                  if (Q != 1) {
                    Q = Q - 1;
                    Qu.text = Q.toString();
                  }
                });
              },),
            ),


          ],)


          ),



          SizedBox(height: 30,),
          Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
            alignment: Alignment.centerLeft,
            decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Theme.of(context).primaryColor)),
            height: 60.0,
            child: ListTile(

              onTap: ()async{

                showDatePicker(context: context, initialDate: DateTime.now().add(new Duration(days:1)), firstDate: DateTime.now().add(new Duration(days:1)), lastDate:DateTime.now().add(new Duration(days:30))


                ).then((value){

                  setState(() {
                    mydate=value;
                  });});




              },

              leading: (widget.lang)?null:Icon(Icons.calendar_today),
              trailing: (widget.lang)?Icon(Icons.calendar_today):null,
              title: Text((mydate==null&&widget.lang)?'وقت انتهاء المزاد':(mydate==null&&!widget.lang)?'Time Lift':mydate.year.toString()+'-'+mydate.month.toString()+'-'+mydate.day.toString(),textAlign:(widget.lang)? TextAlign.right:TextAlign.left,style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'mohab'),),),
          )),
          SizedBox(height: 30,),

          Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Text((widget.lang)?'وصف المنتج :':'Product Discruption:',textDirection: (widget.lang)?TextDirection.rtl:
                TextDirection.ltr,style: TextStyle(fontFamily: 'mohab'),)),
          Padding(padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(padding: EdgeInsets.only(left: 10, right: 10),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Theme
                        .of(context)
                        .primaryColor)),
                height: 140.0,
                child: TextField(
                  controller: desc,
                  textAlign: TextAlign.left,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'mohab',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 5.0),
                  ),
                ),
              )),


        ],


      ),),);
  }

  Future getimage() async {
    String imagename;
    File tempimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      images.add(tempimage);

      imagename = tempimage.path.split('/')[6];

      images_path.add(imagename);
    });
  }


  add() {
    Firestore.instance
        .collection('Items').add({
      'images': images_path,
      'time': DateTime.now(),
      'name': name.text,
      'des': desc.text,
      'timeleft': mydate,
      'price': price.text,
      'Qu': int.parse(Qu.text),
      'seen': 0,
      'bidprice': price.text,
      'status': st_id,
      'currency': Currencyname,
      'country':widget.country_id,
      'gaver_id':gavid,
      'user_id':widget.user_id,
      'cat_id':catid,
      'bidscount':0



    }).then((ov) {
      for (int i = 0; i < images_path.length; i++) {
        addimages(images[i], images_path[i]);
      }

      Navigator.pop(context);
    });
  }


  addimages(File tempimage, String img) {
    final StorageReference storageReference = FirebaseStorage.instance.ref()
        .child(img);
    StorageUploadTask task;

    task = storageReference.putFile(tempimage);
  }

  selectcategory(){

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return
            Container(height: getheight(context)/2,child:Dialog(
              child:Scaffold(appBar:AppBar(title:Text(
                (widget.lang)?'اختيار القسم':"Select Category", style: TextStyle(fontFamily: 'mohab'),),
                  ),body:
              StreamBuilder(
                stream: Firestore.instance.collection('Categroies')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot Snap) {
                  if (!Snap.hasData) {
                    return Container(child: Center(child: Text(
                      'جار التحميل.....',
                      style: TextStyle(fontFamily: 'mohab'),)));
                  }
                  else {
                    print(Snap.data.documents);
                    return Container(height: getheight(context)/2,child:
                    ListView.builder(itemCount: Snap.data.documents.length,
                        itemBuilder: (context, index) {
                          return
                            Card(child: ListTile(onTap: () {
                              setState(() {
                                catname=(widget.lang)?Snap.data.documents[index]['cat_name_ar']:Snap.data.documents[index]['cat_name_en'];
                                catid=Snap.data.documents[index].documentID;


                                Navigator.pop(context);

                              });

                            },leading: Image.network(Snap.data.documents[index]['image'],width: 50,height: 50,),
                              title: Text(
                                  (widget.lang)?Snap.data.documents[index]['cat_name_ar']:Snap.data.documents[index]['cat_name_en'],
                                
                                style: TextStyle(fontFamily: 'mohab'),),));
                        }),);
                  }
                },))


          ));
        }  );







  }
  selectgaverment()async{
    SharedPreferences sharedPreferences;
    sharedPreferences=await SharedPreferences.getInstance();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child:
              Scaffold(appBar:AppBar(title:Text(
                (widget.lang)?'اختيار المنطقة': "Select Region", style: TextStyle(fontFamily: 'mohab'),)),
body:              StreamBuilder(
                stream:


          Firestore.instance.collection('Cities').where('cou_id',isEqualTo:
          sharedPreferences.getString('country')
          )
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot Snap) {
                  if (!Snap.hasData) {
                    return Container(child: Center(child: Text(
                      'جار التحميل.....',
                      style: TextStyle(fontFamily: 'mohab'),)));
                  }
                  else {
                    print(Snap.data.documents);
                    return Container(child:
                    ListView.builder(itemCount: Snap.data.documents.length,
                        itemBuilder: (context, index) {
                          return
                            Card(child: ListTile(onTap: () {
                              setState(() {
                                gavname=(widget.lang)?Snap.data.documents[index]['ci_name_ar']:Snap.data.documents[index]['ci_name_en'];
                                gavid=Snap.data.documents[index].documentID;


                                Navigator.pop(context);

                              });

                            },leading:
                            Icon(Icons.location_on,color: Theme.of(context).primaryColor,),
                              title: Text(
                                  (widget.lang)?Snap.data.documents[index]['ci_name_ar']:Snap.data.documents[index]['ci_name_en'],
                                style: TextStyle(fontFamily: 'mohab'),),));
                        }),);
                  }
                },)


          ));
        }  );







  }
  selectCurrency(){

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child:Scaffold(

              appBar: AppBar(title:Text(
                "Select Currency", style: TextStyle(fontFamily: 'mohab'),)),
              body:
              FutureBuilder(
                future: Firestore.instance.collection('Currency').get(),
                builder: (BuildContext context, AsyncSnapshot Snap) {
                  if (!Snap.hasData) {
                    return Container(child: Center(child: Text(
                      'جار التحميل.....',
                      style: TextStyle(fontFamily: 'mohab'),)));
                  }
                  else {
                    print(Snap.data.documents);
                    return Container(child:
                    ListView.builder(itemCount: Snap.data.documents.length,
                        itemBuilder: (context, index) {
                          return
                            Card(child: ListTile(onTap: () {
                              setState(() {
                                Currencyname=Snap.data.documents[index]['CurName'];


                                Navigator.pop(context);

                              });

                            },leading:
                            Icon(Icons.monetization_on,color: Theme.of(context).primaryColor,),
                              title: Text(
                                Snap.data.documents[index]['CurName'],

                                style: TextStyle(fontFamily: 'mohab'),),));
                        }),);
                  }
                },)


          ));
        }  );







  }
  selectstatus(){

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child:Scaffold(appBar:AppBar(title: Text(
                (widget.lang)?'اختيار الحالة':"Select Status", style: TextStyle(fontFamily: 'mohab'),)),
              body:
              StreamBuilder(
                stream: Firestore.instance.collection('Status').where('st_v',isGreaterThanOrEqualTo:0).snapshots(),
                builder: (BuildContext context, AsyncSnapshot Snap) {
                  if (!Snap.hasData) {
                    return Container(child: Center(child: Text(
                      'جار التحميل.....',
                      style: TextStyle(fontFamily: 'mohab'),)));
                  }
                  else {
                    print(Snap.data.documents);
                    return Container(child:
                    ListView.builder(itemCount: Snap.data.documents.length,
                        itemBuilder: (context, index) {
                          return
                            Card(child: ListTile(onTap: () {
                              setState(() {
                                status=(widget.lang)?
                                Snap.data.documents[index]['st_n_ar']:
                                Snap.data.documents[index]['st_n_en'];
                                st_id=Snap.data.documents[index]['st_v'];


                                Navigator.pop(context);

                              });

                            },leading:
                            Icon(Icons.star,color: Theme.of(context).primaryColor,),
                              title: Text(
                                (widget.lang)?
                                Snap.data.documents[index]['st_n_ar']:
                                Snap.data.documents[index]['st_n_en'],

                                style: TextStyle(fontFamily: 'mohab'),),));
                        }),);
                  }
                },))


          );
        }  );







  }



}