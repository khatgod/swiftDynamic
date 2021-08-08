import 'package:User/user/model/user.dart';
import 'package:User/user/screen/userMenu.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends StatefulWidget {
  UserDetail({Key key, this.title, this.id}) : super(key: key);
  final String title;
  final int id;

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  String email = "",
      fname = '',
      lname = '',
      tel = '',
      age = '',
      createDate = '';
  List<User> user;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getdetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                (Icons.account_circle_sharp),
                size: 100,
              ),
              fnameForm(),
              lnameForm(),
              emailForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [telForm(), ageForm()],
              ),
              createForm(),
            ]),
      ))),
    );
  }

  void getdetail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fname = preferences.getString("fname");
      lname = preferences.getString("lname");
      email = preferences.getString("email");
      tel = preferences.getString("tel");
      age = preferences.getString("age");
      createDate = preferences.getString("createDate");
    });
  }

  Widget createForm() => Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(createDate));

  Widget emailForm() => Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(email));

  Widget telForm() => Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.57,
      child: Text(tel));
  Widget ageForm() => Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.18,
      child: Text(age));

  Widget fnameForm() => Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(fname));
  Widget lnameForm() => Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(lname));
}
