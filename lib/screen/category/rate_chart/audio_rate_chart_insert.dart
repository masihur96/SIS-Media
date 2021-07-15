import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AudioRateChartInsert extends StatefulWidget {
  const AudioRateChartInsert({Key? key}) : super(key: key);

  @override
  _AudioRateChartInsertState createState() => _AudioRateChartInsertState();
}

class _AudioRateChartInsertState extends State<AudioRateChartInsert> {
  List staatus = ['Public', 'Private'];
  String statusValue = "Public";

  List channels = Variables().getaudioChannelList();
  String channelValue = 'Bangladesh Betar';

  bool _isLoading = false;

  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;
  String name = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    return Container(
      width: dataProvider.pageWidth(size),
      height: size.height,
      child: Column(
        children: [
          addImageUI(size, firebaseProvider),
        ],
      ),
    );
  }

  addImageUI(Size size, FirebaseProvider firebaseProvider) {
    return Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      size: size.height * .3,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                      ),
                      // width: size.width * .2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Channel Name : ",
                              style: TextStyle(fontSize: size.height * .025),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: channelValue,
                                elevation: 0,
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.black),
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
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.height * .01),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                      ),
                      // width: size.width * .2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0.0),
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
                    child: Text('PICK CHART'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                            final String uuid = Uuid().v1();
                            uploadData(firebaseProvider, uuid);
                            setState(() {
                              data = null;
                            });
                          },
                          child: Text(
                            'UPLOAD CHART',
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
        ));
  }

  Future<void> uploadData(
      FirebaseProvider firebaseProvider, String uuid) async {
    if (data != null) {
      _isLoading = true;
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('RateChartData')
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
    }
  }

  Future<void> _submitData(
      FirebaseProvider firebaseProvider, String uuid) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    setState(() => _isLoading = true);
    Map<String, String> map = {
      'image': imageUrl,
      'category': 'Audio Media',
      'subCategory': 'Rate Chart',
      'channelName': channelValue,
      'status': statusValue.toLowerCase(),
      'date': dateData,
      'id': uuid,
    };
    await firebaseProvider.addRateChartData(map).then((value) {
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
