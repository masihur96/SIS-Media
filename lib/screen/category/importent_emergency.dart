import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/managment/important_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/importent_management_insertData.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:html' as html;
import 'package:uuid/uuid.dart';

class ImportentEmergency extends StatefulWidget {
  @override
  _ImportentEmergencyState createState() => _ImportentEmergencyState();
}

class _ImportentEmergencyState extends State<ImportentEmergency> {
  bool _isLoading = false;

  TextEditingController _name = TextEditingController(
    text: '',
  );
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _PABX = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _web = TextEditingController(text: '');
  TextEditingController _fax = TextEditingController(text: '');
  TextEditingController _phonet_t = TextEditingController(text: '');
  TextEditingController _mobile = TextEditingController(text: '');
  TextEditingController _contact = TextEditingController(text: '');
  TextEditingController _facebook = TextEditingController(text: '');
  TextEditingController _corporateOffice = TextEditingController(text: '');
  TextEditingController _headOffice = TextEditingController(text: '');
  TextEditingController _position = TextEditingController(text: '');
  TextEditingController _businessType = TextEditingController(text: '');
  TextEditingController _companyName = TextEditingController(text: '');
  TextEditingController _branch = TextEditingController(text: '');
  TextEditingController _reservationExt = TextEditingController(text: '');
  TextEditingController _marketingSales = TextEditingController(text: '');
  TextEditingController _serviceName = TextEditingController(text: '');
  TextEditingController _mainCampus = TextEditingController(text: '');
  TextEditingController _showroomShop = TextEditingController(text: '');
  TextEditingController _hotline = TextEditingController(text: '');
  TextEditingController _customerCare = TextEditingController(text: '');

  List staatus = ['Public', 'Private'];
  String statusValue = "Public";
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

  List<ImportentEmergencyModel> _subList = [];
  List<ImportentEmergencyModel> _filteredList = [];
  List<ImportentEmergencyModel> _filteredListForSearch = [];

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

  List importentEmergency = [];

  String dropdownValue = 'Bangladesh : At A Glance';

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper, DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    if (dataProvider.importantSubCategoryList.isEmpty) {
      await dataProvider.fetchSubCategoryData().then((value) {
        setState(() {
          importentEmergency = dataProvider.importantSubCategoryList;
          dropdownValue = importentEmergency[0];
        });
      });
    } else {
      setState(() {
        importentEmergency = dataProvider.importantSubCategoryList;

        dropdownValue = importentEmergency[0];
      });
    }
    if (fatchDataHelper.importentMediadataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchImportentEmergencyData().then((value) {
        setState(() {
          _subList = fatchDataHelper.importentMediadataList;
          _filteredList.addAll(_subList);
          _isLoading = false;
          _filterSubCategoryList(importentEmergency[0]);
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.importentMediadataList;
        _filteredList.addAll(_subList);

        _filterSubCategoryList(importentEmergency[0]);
        _isLoading = false;
      });
    }
  }

  getData(FatchDataHelper fatchDataHelper, DataProvider dataProvider) async {
    setState(() {
      _isLoading = true;
    });

    await dataProvider.fetchSubCategoryData().then((value) {
      setState(() {
        importentEmergency = dataProvider.importantSubCategoryList;
        dropdownValue = dataProvider.importantSubCategoryList[0];
      });
    });

    await fatchDataHelper.fetchImportentEmergencyData().then((value) {
      _subList = fatchDataHelper.importentMediadataList;
      _filteredList.addAll(_subList);

      _filterSubCategoryList(dataProvider.importantSubCategoryList[0]);
      _isLoading = false;
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
                          labelColor: Colors.grey,
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      _allImpoortteentUI(size, dataProvider, context,
                          firebaseProvider, fatchDataHelper),
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

  Widget _allImpoortteentUI(
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
                                items: importentEmergency.map((itemValue) {
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
                    visible: dropdownValue !=
                        "Management Information (Education Service Company)",
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
                    visible: dropdownValue !=
                        "Management Information (Education Service Company)",
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
            dropdownValue ==
                    'Management Information (Education Service Company)'
                ? ImportantManagementAllData()
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
                            style: TextStyle(fontSize: 15, color: Colors.black),
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
                width: size.height * .15,
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
                  _filteredList[index].fax!.isEmpty
                      ? Container()
                      : Text('Fax: ${_filteredList[index].fax}',
                          style: TextStyle(fontSize: 12)),
                  _filteredList[index].pabx!.isEmpty
                      ? Container()
                      : Text(
                          'PABX: ${_filteredList[index].pabx}',
                          style: TextStyle(fontSize: 12),
                        ),
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
                  _filteredList[index].corporateOffice!.isEmpty
                      ? Container()
                      : Text(
                          'Corporate Office: ${_filteredList[index].corporateOffice}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].headOffice!.isEmpty
                      ? Container()
                      : Text(
                          'Head Office: ${_filteredList[index].headOffice}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].position!.isEmpty
                      ? Container()
                      : Text(
                          'Position: ${_filteredList[index].position}',
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
                  _filteredList[index].companyName!.isEmpty
                      ? Container()
                      : Text(
                          'Company: ${_filteredList[index].companyName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].branch!.isEmpty
                      ? Container()
                      : Text(
                          'Branch: ${_filteredList[index].branch}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].reservation!.isEmpty
                      ? Container()
                      : Text(
                          'Reservation: ${_filteredList[index].reservation}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].marketingSales!.isEmpty
                      ? Container()
                      : Text(
                          'Marketing & Sales: ${_filteredList[index].marketingSales}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].serviceName!.isEmpty
                      ? Container()
                      : Text(
                          'Service: ${_filteredList[index].serviceName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].mainCampus!.isEmpty
                      ? Container()
                      : Text(
                          'Main Campus: ${_filteredList[index].mainCampus}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].showroom!.isEmpty
                      ? Container()
                      : Text(
                          'Show Room: ${_filteredList[index].showroom}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].hotline!.isEmpty
                      ? Container()
                      : Text(
                          'Hotline: ${_filteredList[index].hotline}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].customerCare!.isEmpty
                      ? Container()
                      : Text(
                          'Customer Care: ${_filteredList[index].customerCare}',
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
                      dataProvider.subCategory = "Update Importent Media";

                      dataProvider.importentEmergencyModel.id =
                          _filteredList[index].id;
                      dataProvider.importentEmergencyModel.name =
                          _filteredList[index].name;
                      dataProvider.importentEmergencyModel.address =
                          _filteredList[index].address;
                      dataProvider.importentEmergencyModel.pabx =
                          _filteredList[index].pabx;
                      dataProvider.importentEmergencyModel.email =
                          _filteredList[index].email;
                      dataProvider.importentEmergencyModel.web =
                          _filteredList[index].web;
                      dataProvider.importentEmergencyModel.fax =
                          _filteredList[index].fax;
                      dataProvider.importentEmergencyModel.phone =
                          _filteredList[index].phone;
                      dataProvider.importentEmergencyModel.mobile =
                          _filteredList[index].mobile;
                      dataProvider.importentEmergencyModel.contact =
                          _filteredList[index].contact;
                      dataProvider.importentEmergencyModel.facebook =
                          _filteredList[index].facebook;
                      dataProvider.importentEmergencyModel.image =
                          _filteredList[index].image;
                      dataProvider.importentEmergencyModel.corporateOffice =
                          _filteredList[index].corporateOffice;
                      dataProvider.importentEmergencyModel.headOffice =
                          _filteredList[index].headOffice;
                      dataProvider.importentEmergencyModel.position =
                          _filteredList[index].position;
                      dataProvider.importentEmergencyModel.businessType =
                          _filteredList[index].businessType;
                      dataProvider.importentEmergencyModel.companyName =
                          _filteredList[index].companyName;
                      dataProvider.importentEmergencyModel.branch =
                          _filteredList[index].branch;
                      dataProvider.importentEmergencyModel.reservation =
                          _filteredList[index].reservation;
                      dataProvider.importentEmergencyModel.marketingSales =
                          _filteredList[index].marketingSales;
                      dataProvider.importentEmergencyModel.serviceName =
                          _filteredList[index].serviceName;
                      dataProvider.importentEmergencyModel.mainCampus =
                          _filteredList[index].mainCampus;
                      dataProvider.importentEmergencyModel.showroom =
                          _filteredList[index].showroom;
                      dataProvider.importentEmergencyModel.hotline =
                          _filteredList[index].hotline;
                      dataProvider.importentEmergencyModel.customerCare =
                          _filteredList[index].customerCare;

                      dataProvider.importentEmergencyModel.status =
                          _filteredList[index].status;
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
                              fatchDataHelper
                                  .deleteImportentEmergencyData(
                                      _filteredList[index].id!, context)
                                  .then((value) {
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
        padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                        visible: dropdownValue !=
                            "Management Information (Education Service Company)",
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
                                  items: importentEmergency.map((itemValue) {
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
                        visible: dropdownValue !=
                            "Management Information (Education Service Company)",
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
                  visible: dropdownValue ==
                      "Management Information (Education Service Company)",
                  child: ImportantManagementInsertData(),
                ),
                Visibility(
                  visible: dropdownValue !=
                      "Management Information (Education Service Company)",
                  child: ImportMediaWidget(size),
                ),
                Visibility(
                  visible: dropdownValue !=
                      "Management Information (Education Service Company)",
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
        'contact': _contact.text,
        'facebook': _facebook.text,
        'image': imageUrl,
        'corporateOffice': _corporateOffice.text,
        'headOffice': _headOffice.text,
        'position': _position.text,
        'businessType': _businessType.text,
        'companyName': _companyName.text,
        'branch': _branch.text,
        'reservation': _reservationExt.text,
        'marketingSales': _marketingSales.text,
        'serviceName': _serviceName.text,
        'mainCampus': _mainCampus.text,
        'showroom': _showroomShop.text,
        'hotline': _hotline.text,
        'customerCare': _customerCare.text,
        'id': uuid,
        'category': dataProvider.subCategory,
        'subCategory': dropdownValue,
        'date': dateData,
        'status': statusValue.toLowerCase(),
      };
      await firebaseProvider.addImportentEmergencyData(map).then((value) {
        if (value) {
          setState(() => _isLoading = false);
          showToast('Success');
          _emptyFieldCreator();
        } else {
          setState(() => _isLoading = false);
          showToast('Failed');
        }
      });
    } else
      showToast("Select Status");
  }

  _emptyFieldCreator() {
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
    _corporateOffice.clear();
    _headOffice.clear();
    _position.clear();
    _businessType.clear();
    _companyName.clear();
    _branch.clear();
    _reservationExt.clear();
    _marketingSales.clear();
    _serviceName.clear();
    _mainCampus.clear();
    _showroomShop.clear();
    _hotline.clear();
    _customerCare.clear();
  }

  Widget ImportMediaWidget(Size size) {
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
                      _textFormBuilderForImport('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('E-mail'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('FAX'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Company Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Branch'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Reservation'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Marketing & Sales'),
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
                      _textFormBuilderForImport('Mobile'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Phone(T&T)'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('FaceBook'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Corporate Office'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Head Office'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Position'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Business Type'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Service Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Main Campus'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Showroom or Shop'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Hotline'),
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
                  _textFormBuilderForImport('Customer Care'),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _textFormBuilderForImport(String hint) {
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
                                              : hint == 'Corporate Office'
                                                  ? _corporateOffice
                                                  : hint == 'Head Office'
                                                      ? _headOffice
                                                      : hint == 'Company Name'
                                                          ? _companyName
                                                          : hint == 'Branch'
                                                              ? _branch
                                                              : hint ==
                                                                      'Reservation'
                                                                  ? _reservationExt
                                                                  : hint ==
                                                                          'Marketing & Sales'
                                                                      ? _marketingSales
                                                                      : hint ==
                                                                              'Service Name'
                                                                          ? _serviceName
                                                                          : hint == 'Main Campus'
                                                                              ? _mainCampus
                                                                              : hint == 'Showroom or Shop'
                                                                                  ? _showroomShop
                                                                                  : hint == 'Hotline'
                                                                                      ? _hotline
                                                                                      : hint == 'Customer Care'
                                                                                          ? _customerCare
                                                                                          : hint == 'Position'
                                                                                              ? _position
                                                                                              : _businessType,
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

  Future<void> uploadData(DataProvider dataProvider,
      FirebaseProvider firebaseProvider, String uuid) async {
    if (data == null) {
      _submitData(
        dataProvider,
        firebaseProvider,
        uuid,
      );
    } else {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('ImportentEmergency')
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
          _submitData(
            dataProvider,
            firebaseProvider,
            uuid,
          );
        });
      });
    }
  }
}
