import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/screen/main_page.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _password = TextEditingController(text: '');

  String? uuid;

  bool _isLoading = false;
  String error = 'Welcome to SIS Media Admin Panel';
  bool? _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height * .5,
          width: size.width * .35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  error,
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: size.height * .02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(fontSize: size.height * .04),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .02),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(width: 1),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: _passwordVisible!,
                    decoration: InputDecoration(
                      labelText: 'User Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible!;
                          });
                        },
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(width: 1),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: size.height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _isLoading
                        ? Container(
                            child: Column(
                            children: [
                              fadingCircle,
                            ],
                          ))
                        : ElevatedButton(
                            onPressed: () {
                              _isLoading = true;

                              fatchAdminData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * .04,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fatchAdminData() async {
    setState(() => _isLoading = true);
    var Passseord = await FirebaseFirestore.instance
        .collection('AdminPanel')
        .doc('12345')
        .get();

    if (Passseord['Name'] == _name.text &&
        Passseord['Password'] == _password.text) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

      _name.clear();
      _password.clear();

      setState(() {
        _isLoading = false;
      });
    } else {
      error = 'Invalid Name or Password';
    }
    setState(() {
      _isLoading = false;
    });
  }
}
