import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateFilmMediaDataPage extends StatefulWidget {
  String? id;
  String? name;
  String? address;
  String? pabx;
  String? email;
  String? web;
  String? fax;
  String? phone;
  String? mobile;
  String? contact;
  String? facebook;
  String? designation;
  String? hallname;
  String? image;
  String? status;
  String? subCategory;

  UpdateFilmMediaDataPage({
    this.id,
    this.name,
    this.address,
    this.pabx,
    this.email,
    this.web,
    this.fax,
    this.phone,
    this.mobile,
    this.contact,
    this.facebook,
    this.designation,
    this.hallname,
    this.image,
    this.status,
    this.subCategory,
  });

  @override
  _UpdateFilmMediaDataPageState createState() =>
      _UpdateFilmMediaDataPageState();
}

class _UpdateFilmMediaDataPageState extends State<UpdateFilmMediaDataPage> {
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _pabx = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _web = TextEditingController(text: '');
  TextEditingController _fax = TextEditingController(text: '');
  TextEditingController _phonet_t = TextEditingController(text: '');
  TextEditingController _mobile = TextEditingController(text: '');
  TextEditingController _contact = TextEditingController(text: '');
  TextEditingController _facebook = TextEditingController(text: '');
  TextEditingController _designation = TextEditingController(text: '');
  TextEditingController _hallname = TextEditingController(text: '');

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Uint8List? data;
  var file;
  String imageUrl = '';
  String? error;
  String name = '';

  List staatus = ['public', 'private'];
  String statusValue = '';

  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    _name.text = dataProvider.filmMediaModel.name!;
    _address.text = dataProvider.filmMediaModel.address!;
    _pabx.text = dataProvider.filmMediaModel.pabx!;
    _email.text = dataProvider.filmMediaModel.email!;
    _web.text = dataProvider.filmMediaModel.web!;
    _fax.text = dataProvider.filmMediaModel.fax!;
    _phonet_t.text = dataProvider.filmMediaModel.phone!;
    _mobile.text = dataProvider.filmMediaModel.mobile!;
    _contact.text = dataProvider.filmMediaModel.contact!;
    _facebook.text = dataProvider.filmMediaModel.facebook!;
    _designation.text = dataProvider.filmMediaModel.designation!;
    _hallname.text = dataProvider.filmMediaModel.hallname!;
    statusValue = dataProvider.filmMediaModel.status.toString();
  }

  @override
  Widget build(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    Size size = MediaQuery.of(context).size;

    if (counter == 0) {
      customInit(dataProvider);
    }
    return Container(
      width: dataProvider.pageWidth(size),
      height: size.height,
      color: Colors.blueGrey,
      child: Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Expanded(
            child: Container(
              color: Color(0xffedf7fd),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            data == null
                                ? CircleAvatar(
                                    radius: size.height * .09,
                                    backgroundColor: Colors.grey,
                                    child: dataProvider
                                            .filmMediaModel.image!.isEmpty
                                        ? CircleAvatar(
                                            radius: size.height * .085,
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                                'images/insert_image_icon.png'))
                                        : CircleAvatar(
                                            radius: size.height * .085,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                dataProvider
                                                    .filmMediaModel.image!),
                                          ),
                                  )
                                : CircleAvatar(
                                    radius: size.height * .09,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: size.height * .085,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.memory(
                                          data!,
                                          width: size.height * .17,
                                          height: size.height * .17,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                            IconButton(
                                onPressed: () {
                                  pickedImage(dataProvider);
                                },
                                icon: Icon(Icons.add_photo_alternate_rounded,
                                    color: Colors.black54))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
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
                          )
                        ],
                      ),
                      filmMediaFild(size),
                      SizedBox(
                        height: size.height * .04,
                      ),
                      _isLoading
                          ? Container(
                              height: size.height * .06, child: fadingCircle)
                          : ElevatedButton(
                              onPressed: () {
                                updateData(dataProvider, firebaseProvider);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 7),
                                child: Text(
                                  'UPDATE',
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
                      SizedBox(
                        height: size.height * .04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    if (data == null) {
      setState(() {
        imageUrl = dataProvider.filmMediaModel.image!;
      });
      _submitData(
        dataProvider,
        firebaseProvider,
      );
    } else {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('FilmMediaData')
          .child(dataProvider.filmMediaModel.id!);
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
          );
        });
      });
    }
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

  Future<void> _submitData(
    DataProvider dataProvider,
    FirebaseProvider firebaseProvider,
  ) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if (statusValue.isNotEmpty) {
      setState(() => _isLoading = true);
      Map<String, String> mapData = {
        'name': _name.text,
        'phone': _phonet_t.text,
        'address': _address.text,
        'pabx': _pabx.text,
        'email': _email.text,
        'web': _web.text,
        'fax': _fax.text,
        'mobile': _mobile.text,
        'contact': _contact.text,
        'facebook': _facebook.text,
        'designation': _designation.text,
        'hallname': _hallname.text,
        'date': dateData,
        'id': dataProvider.filmMediaModel.id!,
        'image': imageUrl,
        'status': statusValue.toLowerCase(),
      };
      setState(() => _isLoading = true);
      await firebaseProvider.updateData(mapData, context).then((value) {
        if (value) {
          setState(() => _isLoading = false);
          dataProvider.category = dataProvider.subCategory;
          dataProvider.subCategory = "Film Media";
          showToast('Data updated successful');
        } else {
          setState(() => _isLoading = false);
          dataProvider.category = dataProvider.subCategory;
          dataProvider.subCategory = "Film Media";
          showToast('Data update failed!');
        }
      });
    } else
      showToast("Select Status");
  }

  Widget filmMediaFild(Size size) {
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
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Name'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Address'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('PABX'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('E-mail'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Web'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('FAX'),
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
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Phone(T&T)'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Mobile'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Contact'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('FaceBook'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Designation'),
                      SizedBox(height: size.height * .04),
                      _textFormBuilder('Hall Name'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textFormBuilder(String hint) {
    return TextFormField(
      controller: hint == 'Name'
          ? _name
          : hint == 'Address'
              ? _address
              : hint == 'PABX'
                  ? _pabx
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
                                              : hint == 'Designation'
                                                  ? _designation
                                                  : _hallname,
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
