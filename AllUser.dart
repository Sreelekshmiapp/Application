import 'package:flutter/material.dart';
import 'package:first_app/DB/DatabaseHelper.dart';
import 'package:first_app/DB/User.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AllUser extends StatefulWidget {
  @override
  _AllUserState createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  final dbHelper = DatabaseHelper();
  List<User> users = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    fetchUsersFromDatabase();
  }

  Future<void> fetchUsersFromDatabase() async {
    final Database database = await dbHelper.database;
    final retrievedUsers = await dbHelper.getUsersFromDatabase(database);

    setState(() {
      users = retrievedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final TextEditingController emailController =
              TextEditingController(text: user.email);
          final TextEditingController passwordController =
              TextEditingController(text: user.password);

          return Dismissible(
            key: Key(user.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              await dbHelper.deleteUser(user.id);
              setState(() {
                users.removeAt(index);
              });
            },
            background: Container(
              color: Colors.pink,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: isEditing
                ? ListTile(
                    title: TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    subtitle: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async {
                        // Implement the logic to update user data
                        user.email = emailController.text;
                        user.password = passwordController.text;
                        await dbHelper.updateUser(
                            user); // Update the user in the database
                        setState(() {
                          isEditing = false;
                        });
                      },
                    ),
                  )
                : Card(
                    elevation: 22,
                    shadowColor: Colors.lightBlue,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 13,
                    ),
                    color: Colors.white70,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            './assets/images/user.png',
                            height: 50,
                            width: 50,
                          ),
                          Padding(padding: EdgeInsets.all(4)),
                          Text("UID ${user.id}"),
                        ],
                      ),
                      subtitle: Wrap(
                        children: [
                          Text("Name : ${user.email}"),
                          Padding(padding: EdgeInsets.all(10)),
                          Text("Pass : ${user.password}")
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            // Populate the text fields with the current user data when entering edit mode
                            emailController.text = user.email;
                            passwordController.text = user.password;
                            isEditing = true;
                          });
                        },
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
