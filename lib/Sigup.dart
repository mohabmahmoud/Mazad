import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {
  bool lang;
  SignUp(this.lang);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController Email=new TextEditingController();
  TextEditingController Pass=new TextEditingController();
  TextEditingController name=new TextEditingController();
  TextEditingController business=new TextEditingController();
  TextEditingController rePass=new TextEditingController();
  TextEditingController phone=new TextEditingController();



  DateTime mydate;
  int status = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: Container(color: Theme.of(context).primaryColor,height: 60,child: FlatButton(onPressed: (){



      Signup();
    },child: Text('SignUp',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),),),body:


    Container(child:ListView(children: [
      Container(padding: EdgeInsets.only(top: 30,left: 20),child:
      Text('SignUp',style: TextStyle(fontFamily: 'mohab',fontSize: 30,fontWeight: FontWeight.bold),)),


      SizedBox(height: 30,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        alignment: Alignment.centerLeft,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: name,
          textAlign:TextAlign.left,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                  Icons.person,color: Theme.of(context).primaryColor
              ),
              hintText:'Full Name',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              new Radio(

                value: 2,
                activeColor:Theme.of(context).primaryColor,

                groupValue: status,

                onChanged: (int value) {
                  setState(() {
                    status = value;


                    switch (status) {
                      case 1:
                        break;

                      case 2:
                        break;
                    }
                  });
                },

              ),

              new Text(

                (widget.lang) ? 'شخصي' : 'Personal',

                style: new TextStyle(

                    fontSize: 16.0,
                    fontFamily: 'mohab'

                ),

              ),

            ],

          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              new Radio(

                value: 1,
                activeColor: Theme.of(context).primaryColor,

                groupValue: status,

                onChanged: (int value) {
                  setState(() {
                    status = value;


                    switch (status) {
                      case 1:
                        break;

                      case 2:
                        break;
                    }
                  });
                },

              ),

              new Text(

                (widget.lang) ? 'عمل' : 'Business',

                style: new TextStyle(

                    fontSize: 16.0,
                    fontFamily: 'mohab'


                ),

              ),

            ],

          ),

        ],),
      (status==1)?Column(children: [
        SizedBox(height: 30,),
        Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
          alignment: Alignment.centerLeft,
          decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Theme.of(context).primaryColor)),
          height: 60.0,
          child: TextField(onChanged: (email){



          },controller: name,
            textAlign:TextAlign.left,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'mohab',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),

                prefixIcon: Icon(
                    Icons.work_outlined,color: Theme.of(context).primaryColor
                ),
                hintText:'Business Name',
                hintStyle:
                TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor)
            ),
          ),
        )),
      ],):SizedBox(height:0),
      SizedBox(height: 20,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        alignment: Alignment.centerLeft,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: Email,
          textAlign:TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                  Icons.mail,color: Theme.of(context).primaryColor
              ),
              hintText:'E-mail',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 20,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        alignment: Alignment.centerLeft,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: phone,
          textAlign:TextAlign.left,
          keyboardType: TextInputType.phone,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                  Icons.phone,color: Theme.of(context).primaryColor
              ),
              hintText:'Phone',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 20,),Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        alignment: Alignment.centerLeft,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: ListTile(

          onTap: ()async{

    showDatePicker(context: context, initialDate: DateTime.now().subtract(new Duration(days:365*18)), firstDate: DateTime.now().subtract(new Duration(days:365*100)), lastDate:DateTime.now().subtract(new Duration(days:365*18))


    ).then((value){

    setState(() {
    mydate=value;
    });});




    },

    leading: Icon(Icons.calendar_today,color: Theme.of(context).primaryColor,),title: Text((mydate==null)?'Brithdate':mydate.year.toString()+'-'+mydate.month.toString()+'-'+mydate.day.toString(),textAlign: TextAlign.left,style: TextStyle(color: Theme.of(context).primaryColor),),),
    )),
      SizedBox(height: 20,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        decoration:
        BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: Pass,

          textAlign:TextAlign.left,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                Icons.lock,
                color:Theme.of(context).primaryColor,
              ),
              hintText:'Password',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 20,),
      Padding(padding: EdgeInsets.only(left: 10,right: 10),child:Container(
        decoration:
        BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 60.0,
        child: TextField(onChanged: (email){



        },controller: rePass,

          textAlign:TextAlign.left,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'mohab',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                Icons.lock,
                color:Theme.of(context).primaryColor,
              ),
              hintText:'Password',
              hintStyle:
              TextStyle(fontFamily: 'mohab',color: Theme.of(context).primaryColor)
          ),
        ),
      )),
      SizedBox(height: 20,),







    ],),));
  }


  Signup() async {
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: Email.text, password: Pass.text)
        .then((result) {
      Firestore.instance.collection('Users').document(result.user.uid).setData({
        'name':name.text,
        'email':Email.text,
        'phone':phone.text,
        'brithdate':mydate,
        'status':status,
        'business':business.text,
        'rank':1,
      }).then((res) {
        sharedPreferences.setString('id',result.user.uid);
        print('171');
       Navigator.pop(context);
      });
    }).
    catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });


  }





}



/*

*/