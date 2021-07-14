import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/celebrity_request_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CelebrityRequest extends StatefulWidget {
  @override
  _CelebrityRequestState createState() => _CelebrityRequestState();
}

class _CelebrityRequestState extends State<CelebrityRequest> {
  bool _isLoading = false;

  List requests = ['All Request', 'Today Request'];
  String requestValue = "All Request";

  List<CelebrityRequestModel> _subList = [];
  List<CelebrityRequestModel> _filteredList = [];

  _filterSubRequestList(String searchItem) {
    DateTime date = DateTime.now();
    String dateData = '${date.day}-${date.month}-${date.year}';
    setState(() {
      if (searchItem == 'All Request') {
        _filteredList = _subList;
      } else {
        _filteredList = _subList
            .where((element) =>
                (element.request_date!.toLowerCase().contains(dateData)))
            .toList();
      }
    });
  }

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });
    if (fatchDataHelper.celebrityRequestdataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchCelebrityRequestData().then((value) {
        setState(() {
          _subList = fatchDataHelper.celebrityRequestdataList;

          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.celebrityRequestdataList;
      });
    }

    _filterSubRequestList('All Request');
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchCelebrityRequestData().then((value) {
      setState(() {
        _subList = fatchDataHelper.celebrityRequestdataList;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // width: size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Requst Type : ",
                            style: TextStyle(fontSize: size.height * .025),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: requestValue,
                              elevation: 0,
                              dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              items: requests.map((itemValue) {
                                return DropdownMenuItem<String>(
                                  value: itemValue,
                                  child: Text(itemValue),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  requestValue = newValue!;
                                });
                                _filterSubRequestList(requestValue);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        getData(fatchDataHelper);
                      },
                      child: Container(
                        width: size.height * .2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.blueGrey)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Refresh'),
                              SizedBox(
                                width: size.width * .02,
                              ),
                              Icon(Icons.refresh_outlined),
                            ],
                          ),
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
                      Text(
                        'Please Wait ..........',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ))
                : Expanded(
                    child: SizedBox(
                      height: 500.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _filteredList.length,
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
                  _filteredList[index].category!.isEmpty
                      ? Container()
                      : Text(
                          'Category: ${_filteredList[index].category}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                  _filteredList[index].sub_category!.isEmpty
                      ? Container()
                      : Text(
                          'Sub-Category: ${_filteredList[index].sub_category}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].details!.isEmpty
                      ? Container()
                      : SelectableText(
                          'Details: ${_filteredList[index].details}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].request_date!.isEmpty
                      ? Container()
                      : Text(
                          'Request Date: ${_filteredList[index].request_date}',
                          style: TextStyle(fontSize: 12),
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
                                  .deleteCelebrityRequestData(
                                      _filteredList[index].id!, context)
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
            ),
          ],
        ),
      ),
    );
  }
}
