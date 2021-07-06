import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isLoading = false;
  TextEditingController _oldPassword = TextEditingController(text: '');
  TextEditingController _newPassword = TextEditingController(text: '');
  TextEditingController _reNewPassword = TextEditingController(text: '');

  String error = 'Put a Strong Password';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
        color: Color(0xffedf7fd),
        width: dataProvider.pageWidth(size),
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  error,
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: size.height * .04),
                ),
              ),
              Container(
                height: size.height * .55,
                width: size.width * .35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: <Widget>[
                    SizedBox(height: size.height * .04),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _oldPassword,
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(width: 1),
                          ),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _newPassword,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(width: 1),
                          ),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _reNewPassword,
                        decoration: InputDecoration(
                          labelText: 'Re-Enter New Password',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(width: 1),
                          ),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 10),
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
                                  horizontal: 10, vertical: 0.0),
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * .03,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                          )
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  void fatchAdminData() async {
    setState(() => _isLoading = true);
    var passseord = await FirebaseFirestore.instance
        .collection('AdminPanel')
        .doc('12345')
        .get();

    if (passseord['Password'] != _oldPassword.text) {
      setState(() {
        error = 'Old Password is Wrong!';
      });
    } else {
      error = 'Correct Old Password';
      if (_newPassword.text == _reNewPassword.text) {
        if (_newPassword.text.length > 6) {
          await FirebaseFirestore.instance
              .collection('AdminPanel')
              .doc('12345')
              .update({'Password': _reNewPassword.text});

          setState(() {
            _isLoading = false;
            _oldPassword.clear();
            _newPassword.clear();
            _reNewPassword.clear();
          });
        } else {
          setState(() {
            error = 'Minimum 6 charecter required';
            _isLoading = true;
          });
        }
      } else {
        setState(() {
          error = 'Password Does Not Match';
          _isLoading = true;
        });
      }
    }
    _isLoading = false;
  }
}
