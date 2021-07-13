import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mzad/productScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Search extends StatefulWidget {
  bool lang;
  Search(this.lang);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchkey='';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('Items').where('name',isGreaterThan: searchkey).limit(10).snapshots(),
    builder: (BuildContext context, AsyncSnapshot Snap) {
    if (!Snap.hasData) {
    return Container(child: Center(child: Text('جار التحميل',style: TextStyle(fontFamily: 'mohab'),)));

    }
    else {

      return Container();

    }
        });





  }
}