import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateTelevisionData extends StatefulWidget {
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
  String? image;
  String? businessType;
  String? camera;
  String? unit1;
  String? unit2;
  String? unit3;
  String? unit4;
  String? macPro;
  String? brunchOffice;
  String? programs;
  String? training;
  String? shooting;
  String? location;
  String? artist;
  String? representative;
  String? designation;
  String? companyName;
  String? regionalOffice;
  String? channelName;
  String? houseName;
  String? id;
  String? status;
  String? date;

  UpdateTelevisionData(
      {this.name,
      this.address,
      this.pabx,
      this.email,
      this.web,
      this.fax,
      this.phone,
      this.mobile,
      this.contact,
      this.facebook,
      this.image,
      this.businessType,
      this.camera,
      this.unit1,
      this.unit2,
      this.unit3,
      this.unit4,
      this.macPro,
      this.brunchOffice,
      this.programs,
      this.training,
      this.shooting,
      this.location,
      this.artist,
      this.representative,
      this.designation,
      this.companyName,
      this.regionalOffice,
      this.channelName,
      this.houseName,
      this.id,
      this.status,
      this.date});

  @override
  _UpdateTelevisionDataState createState() => _UpdateTelevisionDataState();
}

class _UpdateTelevisionDataState extends State<UpdateTelevisionData> {
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

  List staatus = ['public', 'private'];
  String statusValue = '';

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Uint8List? data;
  var file;
  String imageUrl = '';
  String? error;
  String name = '';

  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    _name.text = dataProvider.televisionMediaModel.name!;
    _address.text = dataProvider.televisionMediaModel.address!;
    _PABX.text = dataProvider.televisionMediaModel.pabx!;
    _email.text = dataProvider.televisionMediaModel.email!;
    _web.text = dataProvider.televisionMediaModel.web!;
    _fax.text = dataProvider.televisionMediaModel.fax!;
    _phonet_t.text = dataProvider.televisionMediaModel.phone!;
    _mobile.text = dataProvider.televisionMediaModel.mobile!;
    _caontact.text = dataProvider.televisionMediaModel.contact!;
    _facebook.text = dataProvider.televisionMediaModel.facebook!;
    _business_type.text = dataProvider.televisionMediaModel.businessType!;
    _camera.text = dataProvider.televisionMediaModel.camera!;
    _unit1.text = dataProvider.televisionMediaModel.unit1!;
    _unit2.text = dataProvider.televisionMediaModel.unit2!;
    _unit3.text = dataProvider.televisionMediaModel.unit3!;
    _unit4.text = dataProvider.televisionMediaModel.unit4!;
    _mac_pro.text = dataProvider.televisionMediaModel.macPro!;
    _branch_office.text = dataProvider.televisionMediaModel.brunchOffice!;
    _programs.text = dataProvider.televisionMediaModel.programs!;
    _training.text = dataProvider.televisionMediaModel.training!;
    _shooting.text = dataProvider.televisionMediaModel.shooting!;
    _location.text = dataProvider.televisionMediaModel.location!;
    _artist_type.text = dataProvider.televisionMediaModel.artist!;
    _representative.text = dataProvider.televisionMediaModel.representative!;
    _designation.text = dataProvider.televisionMediaModel.designation!;
    _company_name.text = dataProvider.televisionMediaModel.companyName!;
    _regionalSalesOffice.text =
        dataProvider.televisionMediaModel.regionalOffice!;
    _channelName.text = dataProvider.televisionMediaModel.channelName!;
    _houseName.text = dataProvider.televisionMediaModel.houseName!;
    statusValue = dataProvider.televisionMediaModel.status.toString();
  }

  String dropdownValue = 'Television Channel';
  List televisions = Variables().getTelevisionList();

  @override
  Widget build(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    final FatchDataHelper fatchDataHelper =
        Provider.of<FatchDataHelper>(context);
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
                                            .televisionMediaModel.image!.isEmpty
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
                                                    .televisionMediaModel
                                                    .image!),
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
                                icon: Icon(Icons.camera_alt,
                                    color: Colors.black54))
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * .13,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.blueGrey),
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
                      TelevisionMediaFild(size),
                      SizedBox(
                        height: size.height * .04,
                      ),
                      _isLoading
                          ? Container(
                              height: size.height * .06, child: fadingCircle)
                          : ElevatedButton(
                              onPressed: () {
                                updateData(dataProvider, firebaseProvider,
                                    fatchDataHelper);
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
      DataProvider dataProvider,
      FirebaseProvider firebaseProvider,
      FatchDataHelper fatchDataHelper) async {
    if (data == null) {
      setState(() {
        imageUrl = dataProvider.televisionMediaModel.image!;
      });
      _submitData(dataProvider, firebaseProvider, fatchDataHelper);
    } else {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('TelevisionMediaData')
          .child(dataProvider.televisionMediaModel.id!);
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
          _submitData(dataProvider, firebaseProvider, fatchDataHelper);
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
      FatchDataHelper fatchDataHelper) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if (statusValue.isNotEmpty) {
      setState(() => _isLoading = true);
      Map<String, String> mapData = {
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
        'id': dataProvider.televisionMediaModel.id!,
        'status': statusValue.toLowerCase(),
        'date': dateData,
      };
      setState(() => _isLoading = true);
      await fatchDataHelper
          .updateTelevisionMediaData(mapData, context)
          .then((value) {
        if (value) {
          setState(() => _isLoading = false);
          dataProvider.category = dataProvider.subCategory;
          dataProvider.subCategory = "Television Media";
          showToast('Data updated successful');
        } else {
          setState(() => _isLoading = false);
          dataProvider.category = dataProvider.subCategory;
          dataProvider.subCategory = "Television Media";
          showToast('Data update failed!');
        }
      });
    } else
      showToast("Select Status");
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
                      _textFormBuilderForTelevision('Contact'),
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
                      _textFormBuilderForTelevision('Camera'),
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
                _textFormBuilderForTelevision('House Name'),
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
