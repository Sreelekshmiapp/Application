//login page
// setState is called with a callback function that updates the myVariable to newValue.
// After calling setState, the framework knows that the state has changed and schedules a rebuild of the widget.
import 'package:first_app/AllUser.dart';
import 'package:first_app/DB/DatabaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  TextEditingController uemail = TextEditingController();
  TextEditingController upass = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    uemail.addListener(() {
      setState(() {
        _isTextEmpty = uemail.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    uemail.dispose();
    super.dispose();
  }

  void _clearText() {
    setState(() {
      uemail.clear();
      _isTextEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(

            child: Column(

              children: [

                Padding(padding: EdgeInsets.all(10)),
                Image.asset(
                  './assets/images/user.png',
                  height: 100,
                  width: 100,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: uemail,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          suffixIcon: _isTextEmpty
                              ? null
                              : IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: _clearText,
                                ),
                          labelText: "Username",
                          hintText: ".",
                          border: InputBorder.none),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: upass,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: _isTextEmpty
                              ? null
                              : IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: _clearText,
                                ),
                          labelText: "Password",
                          hintText: "...",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 60,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  // margin: EdgeInsets.,
                  child: ElevatedButton(
                    onPressed: () async {
                      String n = uemail.text;
                      String p = upass.text;
                      print("email : $n");
                      final dbHelper = DatabaseHelper();
                      int result = await dbHelper
                          .insertUser({'email': n, "password": p});
                      print("SAVED AFTER : $n and $p");

                      if (result > 0) {
                        Fluttertoast.showToast(
                            msg: "Data Added", gravity: ToastGravity.TOP);
                        // DatabaseHelper a=new DatabaseHelper();
                        // a.displayUsers();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Added Failed", gravity: ToastGravity.TOP);
                      }
                    },
                    child: Text(
                      "Insert",
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllUser()));
                  },
                  child: Text(
                    "All User List",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
