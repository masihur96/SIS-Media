import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';

class UpdateContentData extends StatefulWidget {
  @override
  _UpdateContentDataState createState() => _UpdateContentDataState();
}

class _UpdateContentDataState extends State<UpdateContentData> {
  bool _isLoading = false;
  Uint8List? data;
  var file;
  String imageUrl = '';
  String? error;
  String name = '';
  List categorys = ['Top', 'Bottom'];
  String categoryValue = 'Top';

  List staatus = ['public', 'private'];
  String statusValue = '';

  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    statusValue = dataProvider.indexBannerModel.status.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    if (counter == 0) {
      customInit(dataProvider);
    }
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 2,
              width: size.width,
              color: Colors.grey,
            ),
            Center(
              child: Container(
                  height: size.height * .9,
                  width: size.width * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      data == null
                          ? Container(
                              height: size.height * .35,
                              width: size.width * .35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      dataProvider.indexBannerModel.image!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(
                              height: size.height * .35,
                              width: size.width * .35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                image: DecorationImage(
                                  image: MemoryImage(data!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * .15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.blueGrey),
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
                                        style: TextStyle(
                                            fontSize: size.height * .025),
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
                                    html.FileUploadInputElement()
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
                                    final stripped = encoded.replaceFirst(
                                        RegExp(r'data:image/[^;]+;base64,'),
                                        '');
                                    setState(() {
                                      name = input.files![0].name;
                                      data = base64.decode(stripped);
                                      error = null;
                                    });
                                  });
                                });
                              },
                              child: Text('PIKED BANNER'),
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
                                      updateData(
                                          dataProvider, firebaseProvider);
                                      setState(() {
                                        data = null;
                                      });
                                    },
                                    child: Text(
                                      'UPDATE BANNER',
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    if (data == null) {
      setState(() {
        imageUrl = dataProvider.indexBannerModel.image!;
      });
      _submitData(
        dataProvider,
        firebaseProvider,
      );
    } else {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Banner')
          .child(dataProvider.indexBannerModel.id!);
      firebase_storage.UploadTask storageUploadTask =
          storageReference.putBlob(file);
      firebase_storage.TaskSnapshot taskSnapshot;
      storageUploadTask.then((value) {
        taskSnapshot = value;
        taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
          final downloadUrl = newImageDownloadUrl;
          showToast(downloadUrl);
          setState(() {
            imageUrl = downloadUrl;
          });
          _submitData(
            dataProvider,
            firebaseProvider,
          );
        });
      });
    }
  }

  Future<void> _submitData(
    DataProvider dataProvider,
    FirebaseProvider firebaseProvider,
  ) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if (statusValue.isNotEmpty) {
      setState(() => _isLoading = true);
      Map<String, String> mapData = {
        'image': imageUrl,
        'id': dataProvider.indexBannerModel.id!,
        'date': dateData,
        'status': statusValue.toLowerCase(),
      };
      setState(() => _isLoading = true);
      await firebaseProvider.updateBanerData(mapData, context).then((value) {
        if (value) {
          setState(() => _isLoading = false);
          dataProvider.category = dataProvider.subCategory;
          dataProvider.subCategory = "Content Banner";
          showToast('Data updated successful');
        } else {
          setState(() => _isLoading = false);
          dataProvider.category = dataProvider.subCategory;
          dataProvider.subCategory = "Content Banner";
          showToast('Data update failed!');
        }
      });
    } else
      showToast("Select Status");
  }
}
