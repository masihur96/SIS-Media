import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/index_banner_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:html' as html;
import 'package:uuid/uuid.dart';

class ContentBannerScreen extends StatefulWidget {
  const ContentBannerScreen({Key? key}) : super(key: key);

  @override
  _ContentBannerScreenState createState() => _ContentBannerScreenState();
}

class _ContentBannerScreenState extends State<ContentBannerScreen> {
  bool _isLoading = false;

  List staatus = ['Public', 'Private'];
  String statusValue = "Public";

  List categorys = [
    'Film Media',
    'Television Media',
    'Audio Media',
    'Print Media',
    'New Media',
    'Importent & Emergency'
  ];
  String categoryValue = 'Film Media';

  List places = ['Top Banner', 'Bottom Banner'];
  String placesValue = 'Top Banner';

  final _ktabs = <Tab>[
    const Tab(
      text: 'All Banner',
    ),
    const Tab(
      text: 'Insert Banner',
    ),
  ];

  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;
  String name = '';

  List<IndexBannerModel> _subList = [];
  List<IndexBannerModel> _filteredCategoryList = [];
  List<IndexBannerModel> _filteredPlaceList = [];

  _filterCategoryList(String searchItem) {
    setState(() {
      _filteredCategoryList = _subList
          .where((element) => (element.category!
              .toLowerCase()
              .contains(searchItem == 'Film Media'
                  ? 'contentfilm'
                  : searchItem == 'Television Media'
                      ? 'contenttelevision'
                      : searchItem == 'Audio Media'
                          ? 'contentaudio'
                          : searchItem == 'Print Media'
                              ? 'contentprint'
                              : searchItem == 'New Media'
                                  ? 'contentnew'
                                  : 'contentimportent')))
          .toList();

      _filteredPlaceList = _filteredCategoryList;
    });
  }

  _filterPlaceList(String searchItem) {
    setState(() {
      _filteredCategoryList = _filteredPlaceList
          .where((element) => (element.place!.toLowerCase().contains(
              searchItem == 'Top Banner' ? 'contenttop' : 'contentbottom')))
          .toList();
    });
  }

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });

    if (fatchDataHelper.indexdataList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchBannerData().then((value) {
        setState(() {
          _subList = fatchDataHelper.indexdataList;
          _filteredCategoryList = _subList;
          _filterPlaceList(placesValue);
          _filterCategoryList(categoryValue);
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.indexdataList;
        _filteredCategoryList = _subList;
        _filterPlaceList(placesValue);
        _filterCategoryList(categoryValue);
      });
    }
    getData(fatchDataHelper);
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchBannerData().then((value) {
      setState(() {
        _subList = fatchDataHelper.indexdataList;
        _filteredCategoryList = _subList
            .where((element) =>
                (element.place!.toLowerCase().contains('contenttop') ||
                    element.place!.toLowerCase().contains('contentbottom')))
            .toList();

        _filterPlaceList(placesValue);
        _filterCategoryList(categoryValue);
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
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      showImageUI(size, firebaseProvider, dataProvider,
                          fatchDataHelper),
                      addImageUI(size, firebaseProvider),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showImageUI(Size size, FirebaseProvider firebaseProvider,
      DataProvider dataProvider, FatchDataHelper fatchDataHelper) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(size.height * .01),
              child: Container(
                width: size.height * .5,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // width: size.width * .2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * .01, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Category : ",
                        style: TextStyle(fontSize: size.height * .025),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: categoryValue,
                          elevation: 0,
                          dropdownColor: Colors.white,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * .025),
                          items: categorys.map((itemValue) {
                            return DropdownMenuItem<String>(
                              value: itemValue,
                              child: Text(itemValue),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              categoryValue = newValue!;
                            });

                            _filterCategoryList(categoryValue);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * .3,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              // width: size.width * .2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * .01, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Placement : ",
                      style: TextStyle(fontSize: size.height * .025),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: placesValue,
                        elevation: 0,
                        dropdownColor: Colors.white,
                        style: TextStyle(
                            color: Colors.black, fontSize: size.height * .025),
                        items: places.map((itemValue) {
                          return DropdownMenuItem<String>(
                            value: itemValue,
                            child: Text(itemValue),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            placesValue = newValue!;
                          });

                          _filterPlaceList(placesValue);
                        },
                      ),
                    ),
                  ],
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          fontSize: size.height * .03, color: Colors.black),
                    ),
                  ],
                ))
              : Expanded(
                  child: SizedBox(
                    child: new GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _filteredCategoryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width < 800
                            ? 1
                            : size.width < 1200
                                ? 2
                                : 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (context, index) {
                        return _listItem(index, size, firebaseProvider,
                            dataProvider, fatchDataHelper);
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  _listItem(index, Size size, FirebaseProvider firebaseProvider,
      DataProvider dataProvider, FatchDataHelper fatchDataHelper) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: size.height * .35,
                width: size.width * .7,
                child: _filteredCategoryList[index].image!.isEmpty
                    ? Icon(
                        Icons.photo,
                        size: size.height * .16,
                        color: Colors.grey,
                      )
                    : Image.network(_filteredCategoryList[index].image!,
                        fit: BoxFit.fill)),
            Container(
              width: size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 2, width: size.width, color: Colors.grey),
                  ),
                  _filteredCategoryList[index].status!.isEmpty
                      ? Container()
                      : Text(
                          'Status: ${_filteredCategoryList[index].status}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                  _filteredCategoryList[index].date!.isEmpty
                      ? Container()
                      : Text('Date: ${_filteredCategoryList[index].date}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                ],
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Update Content Data";
                      dataProvider.indexBannerModel.image =
                          _filteredCategoryList[index].image;
                      dataProvider.indexBannerModel.id =
                          _filteredCategoryList[index].id;
                      dataProvider.indexBannerModel.status =
                          _filteredCategoryList[index].status;
                      dataProvider.indexBannerModel.date =
                          _filteredCategoryList[index].date;
                      dataProvider.indexBannerModel.category =
                          _filteredCategoryList[index].category;
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
                                  .deleteBannerData(
                                      _filteredCategoryList[index].id!, context)
                                  .then((value) {
                                if (value == true) {
                                  firebase_storage.FirebaseStorage.instance
                                      .ref()
                                      .child('Banner')
                                      .child(_filteredCategoryList[index].id!)
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

  addImageUI(Size size, FirebaseProvider firebaseProvider) {
    return Center(
      child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(placesValue == 'ContentTop'
                    ? 'Please Upload Top Banner Size: 85*360'
                    : 'Please Upload Bottom Banner Size: 55*360'),
              ),
              data != null
                  ? Container(
                      height: size.height * .35,
                      width: size.width * .35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1),
                        image: DecorationImage(
                          image: MemoryImage(
                            data!,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(
                      height: size.height * .35,
                      width: size.width * .35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Icon(
                        Icons.branding_watermark_outlined,
                        color: Colors.grey,
                        size: 200,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: size.height * .3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    // width: size.width * .2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Status : ",
                            style: TextStyle(fontSize: size.height * .025),
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
                  SizedBox(
                    width: size.width * .04,
                  ),
                  Container(
                    width: size.height * .5,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    // width: size.width * .2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Category : ",
                            style: TextStyle(fontSize: size.height * .025),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: categoryValue,
                              elevation: 0,
                              dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              items: categorys.map((itemValue) {
                                return DropdownMenuItem<String>(
                                  value: itemValue,
                                  child: Text(itemValue),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  categoryValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .04,
                  ),
                  Container(
                    width: size.width * .15,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    // width: size.width * .2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Placement : ",
                            style: TextStyle(fontSize: size.height * .025),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: placesValue,
                              elevation: 0,
                              dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              items: places.map((itemValue) {
                                return DropdownMenuItem<String>(
                                  value: itemValue,
                                  child: Text(itemValue),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  placesValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        html.FileUploadInputElement input =
                            html.FileUploadInputElement()..accept = 'image/*';

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
                            final stripped = encoded.replaceFirst(
                                RegExp(r'data:image/[^;]+;base64,'), '');
                            setState(() {
                              name = input.files![0].name;
                              data = base64.decode(stripped);
                              error = null;
                            });
                          });
                        });
                      },
                      child: Text('PICK BANNER'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: size.width * .05,
                    ),
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
                              final String uuid = Uuid().v1();
                              uploadData(firebaseProvider, uuid);
                            },
                            child: Text(
                              'UPLOAD BANNER',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<void> uploadData(
      FirebaseProvider firebaseProvider, String uuid) async {
    if (data != null) {
      setState(() => _isLoading = true);
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Banner')
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
          _submitData(firebaseProvider, uuid);
        });
      });
    } else {
      showToast('You have no Selected Image');
    }
  }

  Future<void> _submitData(
      FirebaseProvider firebaseProvider, String uuid) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if (statusValue.isNotEmpty) {
      Map<String, String> map = {
        'image': imageUrl,
        'id': uuid,
        'date': dateData,
        'place': placesValue == 'Top Banner' ? 'contenttop' : 'contentbottom',
        'category': categoryValue == 'Film Media'
            ? 'contentfilm'
            : categoryValue == 'Television Media'
                ? 'contenttelevision'
                : categoryValue == 'Audio Media'
                    ? 'contentaudio'
                    : categoryValue == 'Print Media'
                        ? 'contentprint'
                        : categoryValue == 'New Media'
                            ? 'contentnew'
                            : 'contentimportent',
        'status': statusValue.toLowerCase(),
      };
      await firebaseProvider.addBannerData(map).then((value) {
        if (value) {
          setState(() {
            data = null;
          });
          setState(() => _isLoading = false);
          showToast('Success');
        } else {
          setState(() => _isLoading = false);
          showToast('Failed');
        }
      });
    } else
      showToast("Select Status");
  }
}
