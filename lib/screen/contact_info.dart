import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  bool _isLoading = false;

  TextEditingController _contactFildController = TextEditingController();

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });

    var infoData = await FirebaseFirestore.instance
        .collection('ContactInfo')
        .doc('123456789')
        .get();

    setState(() {
      _contactFildController.text = infoData['info'];
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
      child: Center(
          child: Container(
        height: size.height * .55,
        width: size.height * .6,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _contactFildController,
                decoration: InputDecoration(
                  labelText: 'Information & Contact',
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueGrey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _submitData(firebaseProvider);
                },
                child: Text('SUBMIT'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> _submitData(FirebaseProvider firebaseProvider) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    setState(() => _isLoading = true);
    Map<String, String> map = {
      'info': _contactFildController.text,
      'date': dateData,
      'id': '123456789',
    };
    await firebaseProvider.addInfoData(map).then((value) {
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
