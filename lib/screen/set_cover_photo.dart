import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CoverBanner extends StatefulWidget {
  @override
  _CoverBannerState createState() => _CoverBannerState();
}

class _CoverBannerState extends State<CoverBanner> {
  bool _isLoading = false;

  final _ktabs = <Tab>[
    const Tab(
      text: 'Cover Image',
    ),
    const Tab(
      text: 'Insert Cover Image',
    ),
  ];

  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;
  String name = '';

  var editorsUrl = '';

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });

    var editorsImage = await FirebaseFirestore.instance
        .collection('SingleBanner')
        .doc('1234567')
        .get();

    setState(() {
      editorsUrl = editorsImage['image'];
      _isLoading = false;
    });
  }

  void fatchEditorsData() async {
    var editorsImage = await FirebaseFirestore.instance
        .collection('SingleBanner')
        .doc('1234567')
        .get();

    setState(() {
      editorsUrl = editorsImage['image'];
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
                      showImageUI(size, firebaseProvider),
                      addImageUI(size, firebaseProvider),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showImageUI(Size size, FirebaseProvider firebaseProvider) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(
                      size.height * .01,
                    ),
                    child: InkWell(
                      onTap: () {
                        fatchEditorsData();
                      },
                      child: Container(
                        width: size.height * .2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.blueGrey)),
                        child: Padding(
                          padding: EdgeInsets.all(size.height * .01),
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
                height: size.height * .64,
                width: size.height * .45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.blueGrey),
                ),
                child: editorsUrl == ''
                    ? Center(child: Text('You have no Editors Banner'))
                    : Image.network(
                        editorsUrl,
                        fit: BoxFit.fitHeight,
                      )),
            _isLoading
                ? Container(
                    child: Column(
                    children: [
                      fadingCircle,
                    ],
                  ))
                : Padding(
                    padding: EdgeInsets.all(size.height * .03),
                    child: ElevatedButton(
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
                                    .deleteCoverData()
                                    .then((value) async {
                                  if (value == true) {
                                    firebase_storage.FirebaseStorage.instance
                                        .ref()
                                        .child('SingleBanner')
                                        .child('1234567')
                                        .delete();
                                    setState(() {
                                      _isLoading = false;
                                      editorsUrl = '';
                                    });

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
                      child: Text("Delete"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.height * .04,
                              vertical: size.height * .02),
                          textStyle: TextStyle(
                              fontSize: size.height * .03,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
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
                child: Text('Banner Must Be Of : 640*320'),
              ),
              data != null
                  ? Container(
                      height: size.height * .55,
                      width: size.height * .35,
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
                      height: size.height * .55,
                      width: size.height * .35,
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
                              uploadData(firebaseProvider);
                              setState(() {
                                data = null;
                              });
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

  Future<void> uploadData(FirebaseProvider firebaseProvider) async {
    if (data != null) {
      _isLoading = true;
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('SingleBanner')
          .child('1234567');
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
          _submitData(firebaseProvider);
        });
      });
    }
  }

  Future<void> _submitData(FirebaseProvider firebaseProvider) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    setState(() => _isLoading = true);
    Map<String, String> map = {
      'image': imageUrl,
      'category': 'coverbanner',
      'date': dateData,
      'id': '1234567',
    };
    await firebaseProvider.addCoverData(map).then((value) {
      if (value) {
        setState(() => _isLoading = false);
        showToast('Success');
      } else {
        setState(() => _isLoading = false);
        showToast('Failed');
      }
    });
  }
}
