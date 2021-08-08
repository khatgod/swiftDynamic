import 'package:User/user/screen/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:User/user/screen/userRegis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserMenu extends StatefulWidget {
  UserMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  List<User> userList = [];
  List<String> mList;

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
          child: new FutureBuilder<List<User>>(
              future: getUser(),
              builder: (context, snapshot) {
                var user = snapshot.data;
                print("value ${user.toString()}");
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.data.isEmpty || snapshot.data == null) {
                  return Center(
                      child: Text(
                    "No User",
                    style: TextStyle(fontSize: 50, color: Colors.grey[400]),
                  ));
                }
                return snapshot.hasData
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: user.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(userList[index].fname),
                                subtitle: Text(userList[index].tel),
                                onTap: () async {
                                  await saveValue_str(
                                      "fname", userList[index].fname);
                                  await saveValue_str(
                                      "lname", userList[index].lname);
                                  await saveValue_str(
                                      "email", userList[index].email);
                                  await saveValue_str(
                                      "tel", userList[index].tel);
                                  await saveValue_str(
                                      "age", userList[index].age);
                                  await saveValue_str(
                                      "createDate", userList[index].createDate);
                                  Future.delayed(Duration.zero, () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserDetail(
                                                title: "User Detail",
                                              )),
                                    );
                                  });
                                },
                              );
                            }))
                    : new Center(child: new CircularProgressIndicator());
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserRegis(
                        title: "Register",
                      )),
            );
          });
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  saveValue_str(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("save value str");
  }

  Future<List<User>> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();
    var all = preferences.getInt("all");
    print("allID $all");
    if (all != null) {
      //var user = preferences..getStringList('id$all');

      for (int i = 0; i < all; i++) {
        mList = (preferences.getStringList('id$i') ?? List<String>());
        print("data ${mList.join(",")}");
        User user =
            User(mList[0], mList[1], mList[2], mList[3], mList[4], mList[5]);
        userList.add(user);
      }

      print("user ${userList.length}");
    }
    return userList;
  }
}
