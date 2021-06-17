import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateDataPage extends StatefulWidget {
  String id;
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
  String designation;
  String hallname;
  String image;
  String status;


  UpdateDataPage(
  {
   required this.id,
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
    required this.designation,
    required this.hallname,
    required this.image,
    required this.status,
}
      );

  @override
  _UpdateDataPageState createState() => _UpdateDataPageState();
}
class _UpdateDataPageState extends State<UpdateDataPage> {
  TextEditingController _name = TextEditingController(text:'');
  TextEditingController _address = TextEditingController(text:'');
  TextEditingController _pabx = TextEditingController(text:'');
  TextEditingController _email = TextEditingController(text:'');
  TextEditingController _web = TextEditingController(text:'');
  TextEditingController _fax = TextEditingController(text:'');
  TextEditingController _phonet_t = TextEditingController(text:'');
  TextEditingController _mobile = TextEditingController(text:'');
  TextEditingController _contact = TextEditingController(text:'');
  TextEditingController _facebook = TextEditingController(text:'');
  TextEditingController _designation = TextEditingController(text:'');
  TextEditingController _hallname = TextEditingController(text:'');

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
  FatchDataHelper _fatchDataHelper = new FatchDataHelper();
  @override
  void initState() {
    super.initState();
    // statusValue = widget.status;
    _name.text = widget.name;
    _address.text = widget.address;
    _pabx.text = widget.pabx;
    _email.text = widget.email;
    _web.text = widget.web;
    _fax.text = widget.fax;
    _phonet_t.text = widget.phone;
    _mobile.text = widget.mobile;
    _contact.text = widget.contact;
    _facebook.text = widget.facebook;
    _designation.text = widget.designation;
    _hallname.text = widget.hallname;
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
                  commonCategoryFild(size),

                  SizedBox(height: size.height*.04,),

                  if (_isLoading) Container(
                      height: size.height*.06,
                      child: fadingCircle) else ElevatedButton( onPressed: () {

                     uploadPhoto(dataProvider, firebaseProvider);
                     Navigator.pop(context,true);


                     showToast(imageUrl);
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

  Widget commonCategoryFild(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width*.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Name'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Address'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('PABX'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('E-mail'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Web'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('FAX'),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width*.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Phone(T&T)'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Mobile'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Contact'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('FaceBook'),
                      SizedBox(height: size.height*.04),
                      _textFormBuilder('Designation'),
                      SizedBox(height: size.height*.04),
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

      decoration: InputDecoration(hintText: hint),
    );
  }

  Future<void> _submitData(DataProvider dataProvider,FirebaseProvider firebaseProvider,) async{
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if(statusValue.isNotEmpty){
      setState(()=> _isLoading=true);
      Map<String,String> mapData ={
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
        'id': widget.id,
        'image': imageUrl,
        'status': statusValue.toLowerCase(),
        // 'category': dataProvider.subCategory,

      };
      setState(()=>_isLoading=true);
      await firebaseProvider.updateData(mapData, context).then((value){
        if(value){
          setState(()=>_isLoading=false);
          showToast('Data updated successful');

        }
        else{
          setState(()=>_isLoading=false);
          showToast('Data update failed!');

        }
      });

      // await firebaseProvider.addFilmMediaData(map).then((value){
      //   if(value){
      //     setState(()=> _isLoading=false);
      //     showToast('Successfylly Updated');
      //   } else {
      //     setState(()=> _isLoading=false);
      //     showToast('Failed');
      //   }
      // });
    }else showToast("Select Status");
  }


}
