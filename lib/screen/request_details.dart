import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/user_request_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  bool _isLoading = false;
  List<UserRequestModel> _subList = [];
  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });
    if (fatchDataHelper.userRequestdataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchRequestData().then((value) {
        setState(() {
          _subList = fatchDataHelper.userRequestdataList;

          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.userRequestdataList;
      });
    }
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchRequestData().then((value) {
      setState(() {
        _subList = fatchDataHelper.userRequestdataList;

        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    final FatchDataHelper fatchDataHelper =
        Provider.of<FatchDataHelper>(context);

    if (counter == 0) {
      customInit(fatchDataHelper);
    }
    return Expanded(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: 2,
              color: Colors.blueGrey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(width: 30),
                // Text(
                //   "Request Details List",
                //   style: TextStyle(fontSize: 20),
                // ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Refresh '),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            GestureDetector(
                                onTap: () {
                                  getData(fatchDataHelper);
                                },
                                child: Icon(Icons.refresh_outlined)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _isLoading
                ? Container(
                    child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .4,
                      ),
                      fadingCircle,
                    ],
                  ))
                : Expanded(
                    child: SizedBox(
                      height: 500.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _subList.length,
                        itemBuilder: (context, index) {
                          return _listItem(index, size, firebaseProvider,
                              fatchDataHelper, dataProvider);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _listItem(index, Size size, FirebaseProvider firebaseProvider,
      FatchDataHelper fatchDataHelper, DataProvider dataProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subList[index].name!.isEmpty
                      ? Container()
                      : Text(
                          'Name: ${_subList[index].name}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                  _subList[index].category!.isEmpty
                      ? Container()
                      : Text(
                          'Category: ${_subList[index].category}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                  _subList[index].request_date!.isEmpty
                      ? Container()
                      : Text(
                          'Request Date: ${_subList[index].request_date}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _subList[index].sub_category!.isEmpty
                      ? Container()
                      : Text('Sub-Category: ${_subList[index].sub_category}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _subList[index].user_address!.isEmpty
                      ? Container()
                      : Text('Address: ${_subList[index].user_address}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _subList[index].user_email!.isEmpty
                      ? Container()
                      : Text('E-mail: ${_subList[index].user_email}',
                          style: TextStyle(fontSize: 12)),
                  _subList[index].user_name!.isEmpty
                      ? Container()
                      : Text(
                          'User Name: ${_subList[index].user_name}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _subList[index].user_phone!.isEmpty
                      ? Container()
                      : Text(
                          'User Phone: ${_subList[index].user_phone}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
            Container(
              width: size.width * .1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Confirmation Alert",
                        desc: "Are you confirm to delete this item ?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          DialogButton(
                            child: Text(
                              "OK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() => _isLoading = true);
                              firebaseProvider
                                  .deleteRequestData(
                                      _subList[index].id!, context)
                                  .then((value) async {
                                if (value == true) {
                                  setState(() => _isLoading = false);
                                  getData(fatchDataHelper);

                                  showToast('Data deleted successful');
                                } else {
                                  setState(() => _isLoading = false);

                                  showToast('Data delete unsuccessful');
                                }
                              });
                            },
                          )
                        ],
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
