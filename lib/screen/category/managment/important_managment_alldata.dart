import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/management_data_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImportantManagementAllData extends StatefulWidget {
  const ImportantManagementAllData({Key? key}) : super(key: key);

  @override
  _ImportantManagementAllDataState createState() =>
      _ImportantManagementAllDataState();
}

class _ImportantManagementAllDataState
    extends State<ImportantManagementAllData> {
  bool _isLoading = false;
  List channels = Variables().getImportantManagmentList();
  String channelValue = 'BSB-CAMBRIAN EDUCATION GROUP';

  List<ManagementDataModel> _subList = [];
  List<ManagementDataModel> _filteredList = [];

  _filterChannelList(String searchItem) {
    setState(() {
      _filteredList = _subList
          .where((element) => (element.sectionName!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });
    if (fatchDataHelper.managementDataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchManagementData().then((value) {
        setState(() {
          _subList = fatchDataHelper.managementDataList;
          _filteredList = _subList;
          _filterChannelList(channelValue);
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.managementDataList;
        _filteredList = _subList;
        _filterChannelList(channelValue);
        _isLoading = false;
      });
    }

    getData(fatchDataHelper);
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchManagementData().then((value) {
      setState(() {
        _subList = fatchDataHelper.managementDataList;
        _filteredList = _subList;
        _filterChannelList(channelValue);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = size.height * .15;
    final double itemWidth = size.height * .2;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    final FatchDataHelper fatchDataHelper =
        Provider.of<FatchDataHelper>(context);

    if (counter == 0) {
      customInit(fatchDataHelper);
    }
    return Container(
        color: Color(0xffedf7fd),
        width: dataProvider.pageWidth(size),
        height: size.height * .73,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              height: size.height * .73,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(size.height * .01),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.blueGrey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          // width: size.width * .2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * .01, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Section Name : ",
                                  style:
                                      TextStyle(fontSize: size.height * .025),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: channelValue,
                                    elevation: 0,
                                    dropdownColor: Colors.white,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    items: channels.map((itemValue) {
                                      return DropdownMenuItem<String>(
                                        value: itemValue,
                                        child: Text(itemValue),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        channelValue = newValue!;
                                      });

                                      _filterChannelList(channelValue);
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
                          padding: EdgeInsets.all(
                            size.height * .01,
                          ),
                          child: InkWell(
                            onTap: () {
                              getData(fatchDataHelper);
                            },
                            child: Container(
                              width: size.height * .3,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.blueGrey)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  size.height * .01,
                                ),
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
                  Container(
                    child: _isLoading
                        ? Container(
                            child: Column(
                            children: [
                              SizedBox(
                                height: size.height * .4,
                              ),
                              fadingCircle,
                              Text(
                                'Please Wait ..........',
                                style: TextStyle(
                                    fontSize: size.height * .03,
                                    color: Colors.black),
                              ),
                            ],
                          ))
                        : Expanded(
                            child: SizedBox(
                              child: new GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: _filteredList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: size.width < 800
                                      ? 1
                                      : size.width < 1200
                                          ? 2
                                          : 3,
                                  childAspectRatio: (itemHeight / itemWidth),
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                ),
                                itemBuilder: (context, index) {
                                  return _listItem(
                                      index,
                                      size,
                                      firebaseProvider,
                                      dataProvider,
                                      fatchDataHelper);
                                },
                              ),
                            ),
                          ),
                  ),
                ],
              )),
        ));
  }

  _listItem(index, Size size, FirebaseProvider firebaseProvider,
      DataProvider dataProvider, FatchDataHelper fatchDataHelper) {
    return Padding(
      padding: EdgeInsets.all(size.height * .02),
      child: Container(
        padding: EdgeInsets.all(size.height * .01),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: size.height * .5,
                width: size.width * .7,
                child: _filteredList[index].image!.isEmpty
                    ? Icon(
                        Icons.photo,
                        size: size.height * .16,
                        color: Colors.grey,
                      )
                    : Image.network(_filteredList[index].image!,
                        fit: BoxFit.fill)),
            SizedBox(height: size.height * .03),
            Expanded(
              child: Container(
                width: size.height * .8,
                height: size.height * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(height: 2, width: size.width, color: Colors.grey),
                    _filteredList[index].status!.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                                'Status: ${_filteredList[index].status}',
                                style: TextStyle(
                                    fontSize: size.height * .025,
                                    fontWeight: FontWeight.w700)),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: size.height * .1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('Update'),
                      onPressed: () {
                        dataProvider.category = dataProvider.subCategory;
                        dataProvider.subCategory =
                            "Update Television Management";
                        dataProvider.managementDataModel.image =
                            _filteredList[index].image;
                        dataProvider.managementDataModel.id =
                            _filteredList[index].id;
                        dataProvider.managementDataModel.status =
                            _filteredList[index].status;
                        dataProvider.managementDataModel.category =
                            _filteredList[index].category;
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * .03),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Color.fromRGBO(0, 179, 134, 1.0),
                            ),
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * .03),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() => _isLoading = true);
                                firebaseProvider
                                    .deleteManagementData(
                                        _filteredList[index].id!, context)
                                    .then((value) {
                                  if (value == true) {
                                    firebase_storage.FirebaseStorage.instance
                                        .ref()
                                        .child('ManagementData')
                                        .child(_filteredList[index].id!)
                                        .delete();
                                    setState(() => _isLoading = false);
                                    getData(fatchDataHelper);

                                    showToast('Data deleted successful');
                                  } else {
                                    Navigator.pop(context);
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
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
