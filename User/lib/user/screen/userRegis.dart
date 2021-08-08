import 'package:User/user/model/user.dart';
import 'package:User/user/screen/userMenu.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegis extends StatefulWidget {
  UserRegis({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserRegisState createState() => _UserRegisState();
}

class _UserRegisState extends State<UserRegis> {
  String email, fname, lname, tel, age;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                child: OutlinedButton(
                  onPressed: () async {
                    if (tel == null ||
                        tel.isEmpty ||
                        fname == null ||
                        fname.isEmpty ||
                        lname.isEmpty ||
                        lname == null ||
                        email == null ||
                        email.isEmpty ||
                        age == null ||
                        age.isEmpty) {
                      print("fail");
                      Fluttertoast.showToast(
                          msg: "Please complete the information.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.blueAccent[100],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      print("okkk");
                      bool chk = await saveUser();

                      print("$fname $lname $age $email $tel");
                      if (chk == true) {
                        Fluttertoast.showToast(
                            msg: "Regis success",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueAccent[100],
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserMenu(
                                      title: "User",
                                    )),
                          );
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Error",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.blueAccent[100],
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(width: 2.0, color: Colors.blueAccent[200]),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.blueAccent[200]),
                  ),
                ))
          ],
        ),
      ))),
    );
  }

  saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var all = prefs.getInt("all");
    print("id $all");
    try {
      if (all != null) {
        prefs.setInt("all", all + 1);
      } else {
        prefs.setInt("all", 1);
      }
      prefs.setStringList(
          "id$all", [fname, lname, email, tel, age, DateTime.now().toString()]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget emailForm() => Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          validator: (value) => EmailValidator.validate(value)
              ? null
              : "Please enter a valid email",
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "email",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      );

  Widget telForm() => Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.57,
        child: TextField(
          inputFormatters: [
            new LengthLimitingTextInputFormatter(10),
          ],
          keyboardType: TextInputType.number,
          onChanged: (value) => tel = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "tel",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      );
  Widget ageForm() => Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.18,
        child: TextField(
          inputFormatters: [
            new LengthLimitingTextInputFormatter(2),
          ],
          keyboardType: TextInputType.number,
          onChanged: (value) => age = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "age",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      );

  Widget fnameForm() => Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          validator: (value) {
            return value.length < 4
                ? 'Name must be greater than 4 characters'
                : null;
          },
          inputFormatters: [
            new LengthLimitingTextInputFormatter(15),
            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9 . _]')),
          ],
          onChanged: (value) => fname = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "firstname",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      );
  Widget lnameForm() => Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          validator: (value) {
            return value.length < 4
                ? 'Name must be greater than 4 characters'
                : null;
          },
          inputFormatters: [
            new LengthLimitingTextInputFormatter(15),
            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9 . _]')),
          ],
          onChanged: (value) => lname = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "lastname",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      );
}
