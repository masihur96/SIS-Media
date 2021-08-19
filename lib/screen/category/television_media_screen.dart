import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/managment/television_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/television_managment_insert.dart';
import 'package:media_directory_admin/screen/category/rate_chart/television_rate_chart_insert.dart';
import 'package:media_directory_admin/screen/category/rate_chart/television_rate_chart_alldata.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/painting.dart';

class TelevisionMediaScreen extends StatefulWidget {
  @override
  _TelevisionMediaScreenState createState() => _TelevisionMediaScreenState();
}

class _TelevisionMediaScreenState extends State<TelevisionMediaScreen> {
  bool _isLoading = false;
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _PABX = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _web = TextEditingController(text: '');
  TextEditingController _fax = TextEditingController(text: '');
  TextEditingController _phonet_t = TextEditingController(text: '');
  TextEditingController _mobile = TextEditingController(text: '');
  TextEditingController _caontact = TextEditingController(text: '');
  TextEditingController _facebook = TextEditingController(text: '');
  TextEditingController _business_type = TextEditingController(text: '');
  TextEditingController _camera = TextEditingController(text: '');
  TextEditingController _unit1 = TextEditingController(text: '');
  TextEditingController _unit2 = TextEditingController(text: '');
  TextEditingController _unit3 = TextEditingController(text: '');
  TextEditingController _unit4 = TextEditingController(text: '');
  TextEditingController _mac_pro = TextEditingController(text: '');
  TextEditingController _branch_office = TextEditingController(text: '');
  TextEditingController _programs = TextEditingController(text: '');
  TextEditingController _training = TextEditingController(text: '');
  TextEditingController _shooting = TextEditingController(text: '');
  TextEditingController _location = TextEditingController(text: '');
  TextEditingController _artist_type = TextEditingController(text: '');
  TextEditingController _representative = TextEditingController(text: '');
  TextEditingController _designation = TextEditingController(text: '');
  TextEditingController _company_name = TextEditingController(text: '');
  TextEditingController _regionalSalesOffice = TextEditingController(text: '');
  TextEditingController _channelName = TextEditingController(text: '');
  TextEditingController _houseName = TextEditingController(text: '');

  final _ktabs = <Tab>[
    const Tab(
      text: 'All Data',
    ),
    const Tab(
      text: 'Insert Data',
    ),
  ];
  List staatus = ['Public', 'Private'];
  String statusValue = "Public";

  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Television Channel';

  List channels = Variables().getTVChannelList();
  String channelValue = 'Bangladesh Television';

  List televisions = Variables().getTelevisionList();
  String name = '';
  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;

  List<TelevisionMediaModel> _subList = [];
  List<TelevisionMediaModel> _filteredList = [];
  List<TelevisionMediaModel> _filteredListForSearch = [];

  _filterList(String searchItem) {
    setState(() {
      _filteredList = _filteredListForSearch
          .where((element) =>
              (element.name!.toLowerCase().contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  _filterSubCategoryList(String searchItem) {
    setState(() {
      _filteredList = _subList
          .where((element) => (element.subCategory!.contains(searchItem)))
          .toList();
      _filteredListForSearch = _filteredList;
    });
  }

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });
    if (fatchDataHelper.televisionMediadataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchTelevisionData().then((value) {
        setState(() {
          _subList = fatchDataHelper.televisionMediadataList;
          _filteredList = _subList;
          _filterSubCategoryList(dropdownValue);
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.televisionMediadataList;
        _filteredList = _subList;
        _filterSubCategoryList(dropdownValue);
      });
    }
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchTelevisionData().then((value) {
      setState(() {
        _subList = fatchDataHelper.televisionMediadataList;
        _filteredList = _subList;
        _filterSubCategoryList(dropdownValue);
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
                      _allDataUI(
                        size,
                        dataProvider,
                        context,
                        firebaseProvider,
                        fatchDataHelper,
                      ),
                      _insetDataUI(
                          size, context, dataProvider, firebaseProvider),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _allDataUI(Size size, DataProvider dataProvider, BuildContext context,
          FirebaseProvider firebaseProvider, FatchDataHelper fatchDataHelper) =>
      Container(
        padding: const EdgeInsets.all(10.0),
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            horizontal: 5, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                items: televisions.map((itemValue) {
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
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                      visible: dropdownValue != 'Rate Chart' &&
                          dropdownValue != 'Management Information',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.blueGrey),
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
                      )),
                  Visibility(
                    visible: dropdownValue != 'Rate Chart' &&
                        dropdownValue != 'Management Information',
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          getData(fatchDataHelper);
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
                  )
                ],
              ),
            ),
            dropdownValue == 'Rate Chart'
                ? AllDataTelevisionRate()
                : dropdownValue == 'Management Information'
                    ? TelevisionManagmentAllData()
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
                                          fatchDataHelper,
                                          dataProvider);
                                    },
                                  ),
                                ),
                              ),
          ],
        ),
      );
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
                  _filteredList[index].address!.isEmpty
                      ? Container()
                      : Text('Address: ${_filteredList[index].address}',
                          style: TextStyle(
                            fontSize: 12,
                          )),

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

                  _filteredList[index].facebook!.isEmpty
                      ? Container()
                      : Text(
                          'Facebook: ${_filteredList[index].facebook}',
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
                  _filteredList[index].camera!.isEmpty
                      ? Container()
                      : Text(
                          'Camera: ${_filteredList[index].camera}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].unit1!.isEmpty
                      ? Container()
                      : Text(
                          'Unit 1: ${_filteredList[index].unit1}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].unit2!.isEmpty
                      ? Container()
                      : Text(
                          'unit 2: ${_filteredList[index].unit2}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].unit3!.isEmpty
                      ? Container()
                      : Text(
                          'Unit 3: ${_filteredList[index].unit3}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].unit4!.isEmpty
                      ? Container()
                      : Text(
                          'Unit 4: ${_filteredList[index].unit4}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].macPro!.isEmpty
                      ? Container()
                      : Text(
                          'Mac Pro: ${_filteredList[index].macPro}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].brunchOffice!.isEmpty
                      ? Container()
                      : Text(
                          'Brunch Office: ${_filteredList[index].brunchOffice}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].programs!.isEmpty
                      ? Container()
                      : Text(
                          'Programs: ${_filteredList[index].programs}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].training!.isEmpty
                      ? Container()
                      : Text(
                          'Training Course : ${_filteredList[index].training}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].shooting!.isEmpty
                      ? Container()
                      : Text(
                          'Shooting Facilities: ${_filteredList[index].shooting}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].location!.isEmpty
                      ? Container()
                      : Text(
                          'location: ${_filteredList[index].location}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].artist!.isEmpty
                      ? Container()
                      : Text(
                          'Artist Type: ${_filteredList[index].artist}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].representative!.isEmpty
                      ? Container()
                      : Text(
                          'Representative: ${_filteredList[index].representative}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _filteredList[index].designation!.isEmpty
                      ? Container()
                      : Text(
                          'Designation: ${_filteredList[index].designation}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].companyName!.isEmpty
                      ? Container()
                      : Text(
                          'Company Name: ${_filteredList[index].companyName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].regionalOffice!.isEmpty
                      ? Container()
                      : Text(
                          'Regional Sales Ofice: ${_filteredList[index].regionalOffice}',
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
                  _filteredList[index].houseName!.isEmpty
                      ? Container()
                      : Text(
                          'House Name: ${_filteredList[index].houseName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  // _dataList[index].id.isEmpty?Container():
                  // Text('id: ${_dataList[index].id}',style: TextStyle(fontSize: 12,),),
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
                      dataProvider.subCategory = "Update Television Media";

                      dataProvider.televisionMediaModel.id =
                          _filteredList[index].id;
                      dataProvider.televisionMediaModel.name =
                          _filteredList[index].name;
                      dataProvider.televisionMediaModel.address =
                          _filteredList[index].address;
                      dataProvider.televisionMediaModel.pabx =
                          _filteredList[index].pabx;
                      dataProvider.televisionMediaModel.email =
                          _filteredList[index].email;
                      dataProvider.televisionMediaModel.web =
                          _filteredList[index].web;
                      dataProvider.televisionMediaModel.fax =
                          _filteredList[index].fax;
                      dataProvider.televisionMediaModel.phone =
                          _filteredList[index].phone;
                      dataProvider.televisionMediaModel.mobile =
                          _filteredList[index].mobile;
                      dataProvider.televisionMediaModel.contact =
                          _filteredList[index].contact;
                      dataProvider.televisionMediaModel.facebook =
                          _filteredList[index].facebook;
                      dataProvider.televisionMediaModel.designation =
                          _filteredList[index].designation;
                      dataProvider.televisionMediaModel.image =
                          _filteredList[index].image;
                      dataProvider.televisionMediaModel.businessType =
                          _filteredList[index].businessType;
                      dataProvider.televisionMediaModel.camera =
                          _filteredList[index].camera;
                      dataProvider.televisionMediaModel.unit1 =
                          _filteredList[index].unit1;
                      dataProvider.televisionMediaModel.unit2 =
                          _filteredList[index].unit2;
                      dataProvider.televisionMediaModel.unit3 =
                          _filteredList[index].unit3;
                      dataProvider.televisionMediaModel.unit4 =
                          _filteredList[index].unit4;
                      dataProvider.televisionMediaModel.macPro =
                          _filteredList[index].macPro;
                      dataProvider.televisionMediaModel.brunchOffice =
                          _filteredList[index].brunchOffice;
                      dataProvider.televisionMediaModel.programs =
                          _filteredList[index].programs;
                      dataProvider.televisionMediaModel.training =
                          _filteredList[index].training;
                      dataProvider.televisionMediaModel.shooting =
                          _filteredList[index].shooting;
                      dataProvider.televisionMediaModel.location =
                          _filteredList[index].location;
                      dataProvider.televisionMediaModel.artist =
                          _filteredList[index].artist;
                      dataProvider.televisionMediaModel.representative =
                          _filteredList[index].representative;
                      dataProvider.televisionMediaModel.designation =
                          _filteredList[index].designation;
                      dataProvider.televisionMediaModel.companyName =
                          _filteredList[index].companyName;
                      dataProvider.televisionMediaModel.regionalOffice =
                          _filteredList[index].regionalOffice;
                      dataProvider.televisionMediaModel.channelName =
                          _filteredList[index].channelName;
                      dataProvider.televisionMediaModel.houseName =
                          _filteredList[index].houseName;
                      dataProvider.televisionMediaModel.status =
                          _filteredList[index].status;
                      dataProvider.televisionMediaModel.date =
                          _filteredList[index].date;
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
                                  .deleteTelevisionData(
                                      _filteredList[index].id!, context)
                                  .then((value) async {
                                if (value == true) {
                                  firebase_storage.FirebaseStorage.instance
                                      .ref()
                                      .child(dataProvider.subCategory)
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
                                icon: Icon(Icons.photo_library_outlined,
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
                                  items: televisions.map((itemValue) {
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
                          )),
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValue == "Rate Chart",
                  child: TelevisionRateChart(),
                ),
                Visibility(
                  visible: dropdownValue == "Management Information",
                  child: TelevisionManagmentInsert(),
                ),
                Visibility(
                  visible: dropdownValue != "Rate Chart" &&
                      dropdownValue != 'Management Information',
                  child: Container(
                    child: Column(
                      children: <Widget>[TelevisionMediaFild(size)],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Visibility(
                  visible: dropdownValue != 'Rate Chart' &&
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
        'contact': _caontact.text,
        'facebook': _facebook.text,
        'image': imageUrl,
        'businessType': _business_type.text,
        'camera': _camera.text,
        'unit1': _unit1.text,
        'unit2': _unit2.text,
        'unit3': _unit3.text,
        'unit4': _unit4.text,
        'macPro': _mac_pro.text,
        'brunchOffice': _branch_office.text,
        'programs': _programs.text,
        'training': _training.text,
        'shooting': _shooting.text,
        'location': _location.text,
        'artist': _artist_type.text,
        'representative': _representative.text,
        'designation': _designation.text,
        'companyName': _company_name.text,
        'regionalOffice': _regionalSalesOffice.text,
        'channelName': _channelName.text,
        'houseName': _houseName.text,
        'id': uuid,
        'category': dataProvider.subCategory,
        'sub-category': dropdownValue,
        'status': statusValue.toLowerCase(),
        'date': dateData,
      };
      await firebaseProvider.addTelevisionMediaData(map).then((value) {
        if (value) {
          setState(() => _isLoading = false);
          showToast('Success');
          _emptyFildCreator();
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
    _caontact.clear();
    _facebook.clear();
    _business_type.clear();
    _camera.clear();
    _unit1.clear();
    _unit2.clear();
    _unit3.clear();
    _unit4.clear();
    _mac_pro.clear();
    _branch_office.clear();
    _programs.clear();
    _training.clear();
    _shooting.clear();
    _location.clear();
    _artist_type.clear();
    _representative.clear();
    _designation.clear();
    _company_name.clear();
    _regionalSalesOffice.clear();
    _channelName.clear();
    _houseName.clear();
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

  Future<void> uploadData(DataProvider dataProvider,
      FirebaseProvider firebaseProvider, String uuid) async {
    if (data == null) {
      _submitData(dataProvider, firebaseProvider, uuid);
    } else {
      setState(() => _isLoading = true);
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('TelevisionMediaData')
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

  Widget TelevisionMediaFild(Size size) {
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
                      _textFormBuilderForTelevision('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('email'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Fax'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Phone(T&T)'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Mobile'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Facebook'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Unit 1'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Unit 2'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Unit 3'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Unit 4'),
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
                      _textFormBuilderForTelevision('Business Type'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('House Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Mac Pro'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Branch Office'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Programs'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Training Course'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Shooting Facilities'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Location'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Artist Type'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Representative'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Designation / Position'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Company Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Regional Sales Office'),
                      SizedBox(height: 20),
                      _textFormBuilderForTelevision('Channel Name'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size.width * .4,
            child: Column(
              children: [
                SizedBox(height: 20),
                _textFormBuilderForTelevision('Camera'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textFormBuilderForTelevision(String hint) {
    return TextFormField(
      controller: hint == 'Name'
          ? _name
          : hint == 'Address'
              ? _address
              : hint == 'PABX'
                  ? _PABX
                  : hint == 'email'
                      ? _email
                      : hint == 'Web'
                          ? _web
                          : hint == 'Fax'
                              ? _fax
                              : hint == 'Phone(T&T)'
                                  ? _phonet_t
                                  : hint == 'Mobile'
                                      ? _mobile
                                      : hint == 'Contact'
                                          ? _caontact
                                          : hint == 'Facebook'
                                              ? _facebook
                                              : hint == 'Business Type'
                                                  ? _business_type
                                                  : hint == 'Camera'
                                                      ? _camera
                                                      : hint == 'Unit 1'
                                                          ? _unit1
                                                          : hint == 'Unit 2'
                                                              ? _unit2
                                                              : hint == 'Unit 3'
                                                                  ? _unit3
                                                                  : hint ==
                                                                          'Unit 4'
                                                                      ? _unit4
                                                                      : hint ==
                                                                              'Mac Pro'
                                                                          ? _mac_pro
                                                                          : hint == 'Branch Office'
                                                                              ? _branch_office
                                                                              : hint == 'Programs'
                                                                                  ? _programs
                                                                                  : hint == 'Training Course'
                                                                                      ? _training
                                                                                      : hint == 'Shooting Facilities'
                                                                                          ? _shooting
                                                                                          : hint == 'Location'
                                                                                              ? _location
                                                                                              : hint == 'Artist Type'
                                                                                                  ? _artist_type
                                                                                                  : hint == 'Representative'
                                                                                                      ? _representative
                                                                                                      : hint == 'Designation / Position'
                                                                                                          ? _designation
                                                                                                          : hint == 'Company Name'
                                                                                                              ? _company_name
                                                                                                              : hint == 'Regional Sales Office'
                                                                                                                  ? _regionalSalesOffice
                                                                                                                  : hint == 'Channel Name'
                                                                                                                      ? _channelName
                                                                                                                      : _houseName,
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
}
