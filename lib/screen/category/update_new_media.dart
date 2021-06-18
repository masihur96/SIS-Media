import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class UpdateNewMedia extends StatefulWidget {
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
  String editor;
  String birthDate;
  String deathDate;
  String designation;
  String deathList;
  String youtubeChannel;
  String id;
  String status;
  String date;

  UpdateNewMedia(
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
        required this.editor,
        required this.birthDate,
        required this.deathDate,
        required this.designation,
        required this.deathList,
        required this.youtubeChannel,
        required this.id,
        required this.status,
        required this.date
      }
      );
  @override
  _UpdateNewMediaState createState() => _UpdateNewMediaState();
}

class _UpdateNewMediaState extends State<UpdateNewMedia> {
  bool _isLoading=false;

  TextEditingController _name = TextEditingController(text:'');
  TextEditingController _address = TextEditingController(text:'');
  TextEditingController _PABX = TextEditingController(text:'');
  TextEditingController _email = TextEditingController(text:'');
  TextEditingController _web = TextEditingController(text:'');
  TextEditingController _fax = TextEditingController(text:'');
  TextEditingController _phonet_t = TextEditingController(text:'');
  TextEditingController _mobile = TextEditingController(text:'');
  TextEditingController _contact = TextEditingController(text:'');
  TextEditingController _facebook = TextEditingController(text:'');
  TextEditingController _editor = TextEditingController();
  TextEditingController _birthDate = TextEditingController();
  TextEditingController _deathDate = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _deathList = TextEditingController();
  TextEditingController _youtubeChannel = TextEditingController();
  void initState() {
    super.initState();
    _name.text = widget.name;
    _address.text = widget.address;
    _PABX.text = widget.pabx;
    _email.text = widget.email;
    _web.text = widget.web;
    _fax.text = widget.fax;
    _phonet_t.text = widget.phone;
    _mobile.text = widget.mobile;
    _contact.text = widget.contact;
    _facebook.text = widget.facebook;
    _editor.text = widget.editor;
    _birthDate.text = widget.birthDate;
    _deathDate.text = widget.deathDate;
    _designation.text = widget.designation;
    _deathList.text = widget.deathList;
    _youtubeChannel.text = widget.youtubeChannel;
  }

  final _formKey = GlobalKey<FormState>();
  Uint8List? data;
  var file;
  String imageUrl = '';
  String? error;
  String name='';
  List staatus=[
    'Public',
    'Private'
  ];
  String statusValue='Public';

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
                            child: Image.network(widget.image),
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
                  NewMediaWidget(size),

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
  Widget NewMediaWidget(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:  size.width *.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForNewMedia('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('E-mail'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('FAX'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Phone(T&T)'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Mobile'),

                    ],
                  ),
                ),
              ),
              Container(
                width: size.width *.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForNewMedia('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('FaceBook'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Editor'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Birth Date'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Death Date'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Designation'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Death List'),
                      SizedBox(height: 20),
                      _textFormBuilderForNewMedia('Youtube Channel'),
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
  Widget _textFormBuilderForNewMedia(String hint) {
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
          :hint == 'Editor'
          ? _editor
          : hint == 'Birth Date'
          ? _birthDate
          : hint == 'Death Date'
          ? _deathDate
          : hint == 'Designation'
          ? _designation
          : hint == 'Death List'
          ? _deathList
          : _youtubeChannel,
      decoration: InputDecoration(hintText: hint),
    );
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
  Future<void> _submitData(DataProvider dataProvider,FirebaseProvider firebaseProvider) async{
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
        'contact': _contact.text,
        'facebook': _facebook.text,
        'image': imageUrl,
        'editor':_editor.text,
        'dirthDate':_birthDate.text,
        'deathDate':_deathDate.text,
        'designation':_designation.text,
        'deathList':_deathList.text,
        'youtuveChannel':_youtubeChannel.text,
        'id': widget.id,
        'date': dateData,
        'status': statusValue.toLowerCase(),
      };
      setState(()=>_isLoading=true);
      await firebaseProvider.updateNewMediaData(mapData, context).then((value){
        if(value){
          setState(()=>_isLoading=false);
          Navigator.pop(context,true);
          showToast('Data updated successful');
        }
        else{
          setState(()=>_isLoading=false);
          showToast('Data update failed!');

        }
      }
      );
    }else showToast("Select Status");


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
}
