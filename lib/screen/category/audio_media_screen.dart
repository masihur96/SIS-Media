import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/managment/audio_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/audio_managment_insert.dart';
import 'package:media_directory_admin/screen/category/rate_chart/audio_rate_chart_alldata.dart';
import 'package:media_directory_admin/screen/category/rate_chart/audio_rate_chart_insert.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

class AudioMediaScreen extends StatefulWidget {
  @override
  _AudioMediaScreenState createState() => _AudioMediaScreenState();
}

class _AudioMediaScreenState extends State<AudioMediaScreen> {
  bool _isLoading = false;
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _PABX = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _web = TextEditingController(text: '');
  TextEditingController _fax = TextEditingController(text: '');
  TextEditingController _phonet_t = TextEditingController(text: '');
  TextEditingController _mobile = TextEditingController(text: '');
  TextEditingController _contact = TextEditingController(text: '');
  TextEditingController _facebook = TextEditingController(text: '');
  TextEditingController _chief_enginear = TextEditingController();
  TextEditingController _director = TextEditingController();
  TextEditingController _regional_station = TextEditingController();
  TextEditingController _sales_contact = TextEditingController();
  TextEditingController _whats_app = TextEditingController();
  TextEditingController _hotline_number = TextEditingController();
  TextEditingController _business_type = TextEditingController();
  TextEditingController _channelName = TextEditingController();
  TextEditingController _ddgProgram = TextEditingController();
  TextEditingController _ddgNews = TextEditingController();
  TextEditingController _statusData = TextEditingController();

  String dropdownValue = "";
  String channelValue = 'Bangladesh Betar';
  List staatus = ['Public', 'Private'];
  String statusValue = "Public";
  String? uuid;
  String name = '';
  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;

  final _ktabs = <Tab>[
    const Tab(
      text: 'All Data',
    ),
    const Tab(
      text: 'Insert Data',
    ),
  ];
  final _formKey = GlobalKey<FormState>();

  List Channels = Variables().getaudioChannelList();

  int counter = 0;
  List<AudioMediaModel> _subList = [];
  List<AudioMediaModel> _filteredList = [];
  List<AudioMediaModel> _filteredListForSearch = [];

  ///SearchList builder
  _filterList(String searchItem) {
    setState(() {
      _filteredList = _filteredListForSearch
          .where((element) =>
              (element.name!.toLowerCase().contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  _filterSubCategoryList(String searchItem) {
    _filteredList.clear();
    for (int i = 0; i < _subList.length; i++) {
      if (_subList[i].subCategory == searchItem) {
        _filteredList.add(_subList[i]);
      }
    }
    _filteredListForSearch = _filteredList;
  }

  List audios = [];
  customInit(FatchDataHelper fatchDataHelper, DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    if (dataProvider.audioSubCategoryList.isEmpty) {
      await dataProvider.fetchSubCategoryData().then((value) {
        setState(() {
          audios = dataProvider.audioSubCategoryList;
          dropdownValue = audios[0];
        });
      });
    } else {
      setState(() {
        audios = dataProvider.audioSubCategoryList;

        dropdownValue = audios[0];
      });
    }
    if (fatchDataHelper.audioMediadataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchAudioData().then((value) {
        _subList = fatchDataHelper.audioMediadataList;
        _filteredList.addAll(_subList);
        _isLoading = false;
        _filterSubCategoryList(audios[0]);
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.audioMediadataList;
        _filteredList.addAll(_subList);
        _isLoading = false;
        _filterSubCategoryList(audios[0]);
      });
    }
  }

  getData(FatchDataHelper fatchDataHelper, DataProvider dataProvider) async {
    setState(() {
      _isLoading = true;
    });

    await dataProvider.fetchSubCategoryData().then((value) {
      setState(() {
        audios = dataProvider.audioSubCategoryList;
        dropdownValue = audios[0];
      });
    });

    await fatchDataHelper.fetchAudioData().then((value) {
      _subList = fatchDataHelper.audioMediadataList;
      _filteredList.addAll(_subList);
      _isLoading = false;
      _filterSubCategoryList(audios[0]);
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
      customInit(fatchDataHelper, dataProvider);
    }

    return Container(
        color: Color(0xffedf7fd),
        width: dataProvider.pageWidth(size),
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * .913,
                child: DefaultTabController(
                  length: _ktabs.length,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: AppBar(
                        elevation: 0.0,
                        backgroundColor: Colors.white54,
                        bottom: TabBar(
                          labelStyle: TextStyle(
                            fontSize: size.height * .03,
                          ),
                          tabs: _ktabs,
                          indicatorColor: Colors.black,
                          unselectedLabelColor: Colors.blueGrey,
                          labelColor: Colors.black,
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      _allDataUI(size, dataProvider, context, firebaseProvider,
                          fatchDataHelper),
                      _insetDataUI(
                        size,
                        context,
                        dataProvider,
                        firebaseProvider,
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _allDataUI(
    Size size,
    DataProvider dataProvider,
    BuildContext context,
    FirebaseProvider firebaseProvider,
    FatchDataHelper fatchDataHelper,
  ) =>
      Container(
        padding: const EdgeInsets.all(10.0),
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    // width: size.width * .5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Sub-Category : ",
                              style: TextStyle(fontSize: size.height * .025),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                elevation: 0,
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.black),
                                items: audios.map((itemValue) {
                                  return DropdownMenuItem<String>(
                                    value: itemValue,
                                    child: Text(itemValue),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                  _filterSubCategoryList(dropdownValue);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: dropdownValue != 'Rate Chart' &&
                        dropdownValue != 'Management Information',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.blueGrey),
                        ),
                        width: size.width * .2,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Please Search your Query",
                              prefixIcon: Icon(Icons.search_outlined),
                              enabledBorder: InputBorder.none),
                          onChanged: _filterList,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: dropdownValue != 'Rate Chart' &&
                        dropdownValue != 'Management Information',
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          getData(fatchDataHelper, dataProvider);
                        },
                        child: Container(
                          // width: size.width * .1,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
            ),
            dropdownValue == 'Rate Chart'
                ? AllDataAudioRateChart()
                : dropdownValue == 'Management Information'
                    ? AudioManagmentAllData()
                    : _isLoading
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
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ))
                        : _filteredList.isEmpty
                            ? Container(
                                child: Column(
                                children: [
                                  SizedBox(height: 200),
                                  Text("Item is Not Found",
                                      style: TextStyle(
                                          fontSize: 25,
                                          letterSpacing: 2,
                                          color: Colors.grey)),
                                ],
                              ))
                            : Expanded(
                                child: SizedBox(
                                  height: 500.0,
                                  child: new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _filteredList.length,
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
          ],
        ),
      );

  _listItem(index, Size size, FirebaseProvider firebaseProvider,
      DataProvider dataProvider, FatchDataHelper fatchDataHelper) {
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
                width: size.height * .13,
                height: size.height * .16,
                child: _filteredList[index].image!.isEmpty
                    ? Icon(
                        Icons.photo,
                        size: size.height * .16,
                        color: Colors.grey,
                      )
                    : Image.network(_filteredList[index].image!,
                        fit: BoxFit.fill)),
            Container(
              width: size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _filteredList[index].name!.isEmpty
                      ? Container()
                      : Text(
                          _filteredList[index].name!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                  _filteredList[index].contact!.isEmpty
                      ? Container()
                      : Text(
                          'Contact: ${_filteredList[index].contact}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].phone!.isEmpty
                      ? Container()
                      : Text(
                          'Phone: ${_filteredList[index].phone}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].mobile!.isEmpty
                      ? Container()
                      : Text(
                          'Mobile: ${_filteredList[index].mobile}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].pabx!.isEmpty
                      ? Container()
                      : Text(
                          'PABX: ${_filteredList[index].pabx}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _filteredList[index].fax!.isEmpty
                      ? Container()
                      : Text('Fax: ${_filteredList[index].fax}',
                          style: TextStyle(fontSize: 12)),
                  _filteredList[index].email!.isEmpty
                      ? Container()
                      : Text('E-mail: ${_filteredList[index].email}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].web!.isEmpty
                      ? Container()
                      : Text('Web: ${_filteredList[index].web}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].address!.isEmpty
                      ? Container()
                      : Text('Address: ${_filteredList[index].address}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].facebook!.isEmpty
                      ? Container()
                      : Text(
                          'Facebook: ${_filteredList[index].facebook}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].chiefEngineer!.isEmpty
                      ? Container()
                      : Text(
                          'Chief Engineer: ${_filteredList[index].chiefEngineer}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].director!.isEmpty
                      ? Container()
                      : Text(
                          'Director: ${_filteredList[index].director}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].regionalStation!.isEmpty
                      ? Container()
                      : Text(
                          'Regional Station: ${_filteredList[index].regionalStation}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].salesContact!.isEmpty
                      ? Container()
                      : Text(
                          'Sales Contact: ${_filteredList[index].salesContact}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].whatApp!.isEmpty
                      ? Container()
                      : Text(
                          'Whats App: ${_filteredList[index].whatApp}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _filteredList[index].hotlineNumber!.isEmpty
                      ? Container()
                      : Text(
                          'Hotline Number: ${_filteredList[index].hotlineNumber}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].businessType!.isEmpty
                      ? Container()
                      : Text(
                          'Business Type: ${_filteredList[index].businessType}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].channelName!.isEmpty
                      ? Container()
                      : Text(
                          'Channel Name: ${_filteredList[index].channelName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].status!.isEmpty
                      ? Container()
                      : Text(
                          'Status: ${_filteredList[index].status}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].date!.isEmpty
                      ? Container()
                      : Text(
                          'Date: ${_filteredList[index].date}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].ddgNews!.isEmpty
                      ? Container()
                      : Text(
                          'DDG News: ${_filteredList[index].ddgNews}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].ddgprogram!.isEmpty
                      ? Container()
                      : Text(
                          'DDG Program: ${_filteredList[index].ddgprogram}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].statusData!.isEmpty
                      ? Container()
                      : Text(
                          'Musician Status: ${_filteredList[index].statusData}',
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
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Update Audio Media";

                      dataProvider.audioMediaModel.id = _filteredList[index].id;
                      dataProvider.audioMediaModel.name =
                          _filteredList[index].name;
                      dataProvider.audioMediaModel.address =
                          _filteredList[index].address;
                      dataProvider.audioMediaModel.pabx =
                          _filteredList[index].pabx;
                      dataProvider.audioMediaModel.email =
                          _filteredList[index].email;
                      dataProvider.audioMediaModel.web =
                          _filteredList[index].web;
                      dataProvider.audioMediaModel.fax =
                          _filteredList[index].fax;
                      dataProvider.audioMediaModel.phone =
                          _filteredList[index].phone;
                      dataProvider.audioMediaModel.mobile =
                          _filteredList[index].mobile;
                      dataProvider.audioMediaModel.contact =
                          _filteredList[index].contact;
                      dataProvider.audioMediaModel.facebook =
                          _filteredList[index].facebook;
                      dataProvider.audioMediaModel.image =
                          _filteredList[index].image;
                      dataProvider.audioMediaModel.chiefEngineer =
                          _filteredList[index].chiefEngineer;
                      dataProvider.audioMediaModel.director =
                          _filteredList[index].director;
                      dataProvider.audioMediaModel.regionalStation =
                          _filteredList[index].regionalStation;
                      dataProvider.audioMediaModel.salesContact =
                          _filteredList[index].salesContact;
                      dataProvider.audioMediaModel.whatApp =
                          _filteredList[index].whatApp;
                      dataProvider.audioMediaModel.hotlineNumber =
                          _filteredList[index].hotlineNumber;
                      dataProvider.audioMediaModel.businessType =
                          _filteredList[index].businessType;
                      dataProvider.audioMediaModel.channelName =
                          _filteredList[index].channelName;
                      dataProvider.audioMediaModel.status =
                          _filteredList[index].status;
                      dataProvider.audioMediaModel.ddgNews =
                          _filteredList[index].ddgNews;
                      dataProvider.audioMediaModel.ddgprogram =
                          _filteredList[index].ddgprogram;
                      dataProvider.audioMediaModel.statusData =
                          _filteredList[index].statusData;
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
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
                            color: Color.fromRGBO(0, 179, 134, 1.0),
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
                                  .deleteAudioData(
                                      _filteredList[index].id!, context)
                                  .then((value) async {
                                if (value == true) {
                                  firebase_storage.FirebaseStorage.instance
                                      .ref()
                                      .child('AudioData')
                                      .child(_filteredList[index].id!)
                                      .delete();

                                  _subList.removeWhere((item) =>
                                      item.id == _filteredList[index].id!);
                                  _filteredList.removeWhere((item) =>
                                      item.id == _filteredList[index].id!);
                                  setState(() => _isLoading = false);

                                  showToast('Data deleted successful');
                                } else {
                                  setState(() => _isLoading = false);

                                  showToast('Data delete unsuccessful');
                                }
                              });
                            },
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
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

  Widget _insetDataUI(
    Size size,
    BuildContext context,
    DataProvider dataProvider,
    FirebaseProvider firebaseProvider,
  ) =>
      Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: dropdownValue != 'Rate Chart' &&
                            dropdownValue != 'Management Information',
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            data == null
                                ? CircleAvatar(
                                    radius: size.height * .09,
                                    backgroundColor: Colors.blueGrey,
                                    child: CircleAvatar(
                                      radius: size.height * .087,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.account_box,
                                        size: size.height * .08,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: size.height * .09,
                                    backgroundColor: Colors.blueGrey,
                                    child: CircleAvatar(
                                      radius: size.height * .087,
                                      backgroundColor: Colors.white,
                                      backgroundImage: MemoryImage(
                                        data!,
                                      ),
                                    ),
                                  ),
                            IconButton(
                                onPressed: () {
                                  pickedImage(dataProvider);
                                },
                                icon: Icon(Icons.add_photo_alternate_rounded,
                                    color: Colors.grey))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.blueGrey),
                        ),
                        // width: size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Please Select Your Sub-Category :",
                                style: TextStyle(fontSize: size.height * .025),
                              ),
                              SizedBox(
                                width: size.height * .04,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  elevation: 0,
                                  dropdownColor: Colors.white,
                                  style: TextStyle(color: Colors.black),
                                  items: audios.map((itemValue) {
                                    return DropdownMenuItem<String>(
                                      value: itemValue,
                                      child: Text(itemValue),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dropdownValue != 'Rate Chart' &&
                            dropdownValue != 'Management Information',
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.blueGrey),
                          ),
                          // width: size.width * .2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Status : ",
                                  style:
                                      TextStyle(fontSize: size.height * .025),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: statusValue,
                                    elevation: 0,
                                    dropdownColor: Colors.white,
                                    style: TextStyle(color: Colors.black),
                                    items: staatus.map((itemValue) {
                                      return DropdownMenuItem<String>(
                                        value: itemValue,
                                        child: Text(itemValue),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        statusValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValue == "Rate Chart",
                  child: AudioRateChartInsert(),
                ),
                Visibility(
                  visible: dropdownValue == "Management Information",
                  child: AudioManagmentInsert(),
                ),
                Visibility(
                  visible: dropdownValue != "Rate Chart" &&
                      dropdownValue != 'Management Information',
                  child: Container(
                    child: Column(
                      children: <Widget>[AudioMediaFild(size)],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Visibility(
                  visible: dropdownValue != "Rate Chart" &&
                      dropdownValue != 'Management Information',
                  child: _isLoading
                      ? Container(
                          child: Column(
                          children: [
                            fadingCircle,
                          ],
                        ))
                      : ElevatedButton(
                          onPressed: () {
                            final String uuid = Uuid().v1();
                            uploadData(dataProvider, firebaseProvider, uuid);
                            setState(() {
                              data = null;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 7),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * .03,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                        ),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> uploadData(DataProvider dataProvider,
      FirebaseProvider firebaseProvider, String uuid) async {
    if (data == null) {
      _submitData(dataProvider, firebaseProvider, uuid);
    } else {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('AudioData')
          .child(uuid);
      firebase_storage.UploadTask storageUploadTask =
          storageReference.putBlob(file);
      firebase_storage.TaskSnapshot taskSnapshot;
      storageUploadTask.then((value) {
        taskSnapshot = value;
        taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
          final downloadUrl = newImageDownloadUrl;
          setState(() {
            imageUrl = downloadUrl;
          });
          _submitData(dataProvider, firebaseProvider, uuid);
        });
      });
    }
  }

  Future<void> _submitData(DataProvider dataProvider,
      FirebaseProvider firebaseProvider, String uuid) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if (statusValue.isNotEmpty) {
      setState(() => _isLoading = true);
      Map<String, String> map = {
        'name': _name.text,
        'address': _address.text,
        'pabx': _PABX.text,
        'email': _email.text,
        'web': _web.text,
        'fax': _fax.text,
        'phone': _phonet_t.text,
        'mobile': _mobile.text,
        'contact': _contact.text,
        'facebook': _facebook.text,
        'image': imageUrl,
        'chiefEngineer': _chief_enginear.text,
        'director': _director.text,
        'regionalStation': _regional_station.text,
        'salesContact': _sales_contact.text,
        'whatsApp': _whats_app.text,
        'hotlineNumber': _hotline_number.text,
        'businessType': _business_type.text,
        'channelName': _channelName.text,
        'id': uuid,
        'category': dataProvider.subCategory,
        'sub-category': dropdownValue,
        'status': statusValue.toLowerCase(),
        'date': dateData,
        'ddgProgram': _ddgProgram.text,
        'ddgNews': _ddgNews.text,
        'statusData': _statusData.text,
      };
      await firebaseProvider.addAudioMediaData(map).then((value) {
        if (value) {
          showToast('Successfully Added');
          _emptyFildCreator();
          setState(() => _isLoading = false);
        } else {
          setState(() => _isLoading = false);
          showToast('Failed');
        }
      });
    } else
      showToast("Select Status");
  }

  _emptyFildCreator() {
    _name.clear();
    _address.clear();
    _PABX.clear();
    _email.clear();
    _web.clear();
    _fax.clear();
    _phonet_t.clear();
    _mobile.clear();
    _contact.clear();
    _facebook.clear();
    _chief_enginear.clear();
    _director.clear();
    _regional_station.clear();
    _sales_contact.clear();
    _whats_app.clear();
    _hotline_number.clear();
    _business_type.clear();
    _channelName.clear();
    _ddgProgram.clear();
    _ddgNews.clear();
    _statusData.clear();
  }

  Widget AudioMediaFild(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width > 1200 ? size.width * .415 : size.width * .5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForAudio('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('E-mail'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('FAX'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Phone(T&T)'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Mobile'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('FaceBook'),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width > 1200 ? size.width * .415 : size.width * .5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForAudio('Chief Enginear'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Director'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Regional Station'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Sales Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Whats App'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Hotline Number'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Business Type'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Channel Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('DDG (Program)'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('DDG (News)'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size.width > 1200 ? size.width * .415 : size.width * .5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _textFormBuilderForAudio('Status'),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFormBuilderForAudio(String hint) {
    return TextFormField(
      controller: hint == 'Name'
          ? _name
          : hint == 'Address'
              ? _address
              : hint == 'PABX'
                  ? _PABX
                  : hint == 'E-mail'
                      ? _email
                      : hint == 'Web'
                          ? _web
                          : hint == 'FAX'
                              ? _fax
                              : hint == 'Phone(T&T)'
                                  ? _phonet_t
                                  : hint == 'Mobile'
                                      ? _mobile
                                      : hint == 'Contact'
                                          ? _contact
                                          : hint == 'FaceBook'
                                              ? _facebook
                                              : hint == 'Chief Enginear'
                                                  ? _chief_enginear
                                                  : hint == 'Director'
                                                      ? _director
                                                      : hint ==
                                                              'Regional Station'
                                                          ? _regional_station
                                                          : hint ==
                                                                  'Sales Contact'
                                                              ? _sales_contact
                                                              : hint ==
                                                                      'Whats App'
                                                                  ? _whats_app
                                                                  : hint ==
                                                                          'Hotline Number'
                                                                      ? _hotline_number
                                                                      : hint ==
                                                                              'Business Type'
                                                                          ? _business_type
                                                                          : hint == 'Channel Name'
                                                                              ? _channelName
                                                                              : hint == 'Status'
                                                                                  ? _statusData
                                                                                  : hint == 'DDG (Program)'
                                                                                      ? _ddgProgram
                                                                                      : _ddgNews,
      decoration: InputDecoration(
        hintText: hint,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide: new BorderSide(width: 1),
        ),
      ),
      maxLines: 2,
    );
  }

  pickedImage(DataProvider dataProvider) async {
    html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      file = input.files!.first;
      final reader1 = html.FileReader();
      reader1.readAsDataUrl(input.files![0]);
      reader1.onError.listen((err) => setState(() {
            error = err.toString();
          }));
      reader1.onLoad.first.then((res) {
        final encoded = reader1.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        setState(() {
          name = input.files![0].name;
          data = base64.decode(stripped);
          error = null;
        });
      });
    });
  }
}
