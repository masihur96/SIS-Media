import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UpdateTelevisionData extends StatefulWidget {
  String name;
  String address;
  String pabx;
  String email;
  String web;
  String fax;
  String phone;
  String mobile;
  String contact;
  String facebook;
  String image;
  String businessType;
  String camera;
  String unit1;
  String unit2;
  String unit3;
  String unit4;
  String macPro;
  String brunchOffice;
  String programs;
  String training;
  String shooting;
  String location;
  String artist;
  String representative;
  String designation;
  String companyName;
  String regionalOffice;
  String channelName;
  String houseName;
  String id;
  String status;
  String date;

  UpdateTelevisionData(
      {
        required this.name,
        required this.address,
        required this.pabx,
        required this.email,
        required this.web,
        required this.fax,
        required this.phone,
        required this.mobile,
        required this.contact,
        required this.facebook,
        required this.image,
        required this.businessType,
        required this.camera,
        required this.unit1,
        required this.unit2,
        required this.unit3,
        required this.unit4,
        required this.macPro,
        required this.brunchOffice,
        required this.programs,
        required this.training,
        required this.shooting,
        required this.location,
        required this.artist,
        required this.representative,
        required this.designation,
        required this.companyName,
        required this.regionalOffice,
        required this.channelName,
        required this.houseName,
        required this.id,
        required this.status,
        required this.date
      }
      );


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
  List staatus=[
    'Public',
    'Private'
  ];

  bool _isLoading=false;
  final _formKey = GlobalKey<FormState>();
  Uint8List? data;
  var file;
  String imageUrl = '';
  String? error;
  String name='';
  String statusValue='Public';
  //FatchDataHelper _fatchDataHelper = new FatchDataHelper();
  @override
  void initState() {
    super.initState();
    // statusValue = widget.status;
    _name.text = widget.name;
    _address.text = widget.address;
    _PABX.text = widget.pabx;
    _email.text = widget.email;
    _web.text = widget.web;
    _fax.text = widget.fax;
    _phonet_t.text = widget.phone;
    _mobile.text = widget.mobile;
    _caontact.text = widget.contact;
    _facebook.text = widget.facebook;
    _business_type.text = widget.businessType;
    _camera.text = widget.camera;
    _unit1.text = widget.unit1;
    _unit2.text = widget.unit2;
    _unit3.text = widget.unit3;
    _unit4.text = widget.unit4;
    _mac_pro.text = widget.macPro;
    _branch_office.text = widget.brunchOffice;
    _programs.text = widget.programs;
    _training.text = widget.training;
    _shooting.text = widget.shooting;
    _location.text = widget.location;
    _artist_type.text = widget.artist;
    _representative.text = widget.representative;
    _designation.text = widget.designation;
    _company_name.text = widget.companyName;
    _regionalSalesOffice.text = widget.regionalOffice;
    _channelName.text = widget.channelName;
    _houseName.text = widget.houseName;
    // print(widget.profileImage);
  }
  @override
  Widget build(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Film Media",
                      style: TextStyle(
                          fontSize: size.height*.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          data==null ? CircleAvatar(
                            radius: size.height*.09,
                            backgroundColor: Colors.white,
                            child: widget.image.isEmpty?Icon(Icons.photo): Image.network(widget.image),
                          ): Container(
                            height: size.height*.1,
                            width: size.height*.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.memory(data!,fit: BoxFit.fill,),
                          ),
                          IconButton(
                              onPressed: () {
                                uploadToStorage(dataProvider);
                              },
                              icon:
                              Icon(Icons.camera_alt, color: Colors.black54))
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Status : ",style: TextStyle(fontSize: size.height*.025),),
                            DropdownButton<String>(
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
                          ],
                        ),
                      )
                    ],
                  ),
                  TelevisionMediaFild(size),

                  SizedBox(height: size.height*.04,),

                  if (_isLoading) Container(
                      height: size.height*.06,
                      child: fadingCircle) else ElevatedButton( onPressed: () {

                    uploadPhoto(dataProvider, firebaseProvider);
                    //  Navigator.pop(context,true);


                    // showToast(imageUrl);
                  },
                      child: Text(
                        'Update Data',
                        style: TextStyle(color: Colors.white, fontSize: size.height*.04,),
                      )
                  ),
                  SizedBox(height: size.height*.04,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> uploadPhoto(DataProvider dataProvider ,FirebaseProvider firebaseProvider)async{
    if(data==null){
      setState(() {
        imageUrl = widget.image;
      });
      _submitData(dataProvider,firebaseProvider,);
    }else{
      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(dataProvider.subCategory).child(widget.id);
      firebase_storage.UploadTask storageUploadTask = storageReference.putBlob(file);
      firebase_storage.TaskSnapshot taskSnapshot;
      storageUploadTask.then((value) {
        taskSnapshot = value;
        taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl){
          final downloadUrl = newImageDownloadUrl;
          showToast(downloadUrl);
          setState(() {
            imageUrl = downloadUrl;
          });
          _submitData(dataProvider,firebaseProvider,);
        });
      });

    }

  }
  uploadToStorage(DataProvider dataProvider) async {
    html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      file = input.files!.first;
      final reader1 =   html.FileReader();
      reader1.readAsDataUrl(input.files![0]);
      reader1.onError.listen((err) => setState((){
        error = err.toString();
      }) );
      reader1.onLoad.first.then((res){
        final encoded = reader1.result as String;
        final stripped = encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        setState(() {
          name = input.files![0].name;
          data  =base64.decode(stripped);
          error = null;
        });
      });
    });
  }
  Future<void> _submitData(DataProvider dataProvider,FirebaseProvider firebaseProvider,) async{
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if(statusValue.isNotEmpty){
      setState(()=> _isLoading=true);
      Map<String,String> mapData ={
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
        'id': widget.id,
        'category': dataProvider.subCategory,
        'status': statusValue.toLowerCase(),
        'date': dateData,
        // 'category': dataProvider.subCategory,

      };
      setState(()=>_isLoading=true);
      await firebaseProvider.updateTelevisionMediaData(mapData, context).then((value){
        if(value){
          setState(()=>_isLoading=false);
          Navigator.pop(context,true);
          showToast('Data updated successful');
        }
        else{
          setState(()=>_isLoading=false);
          showToast('Data update failed!');

        }
      });
    }else showToast("Select Status");
  }
  Widget TelevisionMediaFild(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:  size.width*.5,
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
                width:  size.width*.5,
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
            width: size.width*.4,
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
          : hint == 'Unit 4'
          ? _unit4
          : hint == 'Mac Pro'
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
      decoration: InputDecoration(hintText: hint),
    );
  }
  }




