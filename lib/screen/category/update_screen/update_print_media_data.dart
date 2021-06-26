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

class UpdatePrintMedia extends StatefulWidget {

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
  String? editor;
  String? businessType;
  String? director;
  String? position;
  String? id;
  String? status;
  String? date;

  UpdatePrintMedia(
      {
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
         this.image,
         this.editor,
         this.businessType,
         this.director,
         this.position,
         this.id,
         this.status,
         this.date
      }

      );

  @override
  _UpdatePrintMediaState createState() => _UpdatePrintMediaState();
}

class _UpdatePrintMediaState extends State<UpdatePrintMedia> {
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
  TextEditingController _business_type = TextEditingController();
  TextEditingController _director = TextEditingController();
  TextEditingController _position = TextEditingController();



  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });
    _name.text = dataProvider.printMediaModel.name!;
    _address.text = dataProvider.printMediaModel.address!;
    _PABX.text = dataProvider.printMediaModel.pabx!;
    _email.text = dataProvider.printMediaModel.email!;
    _web.text = dataProvider.printMediaModel.web!;
    _fax.text = dataProvider.printMediaModel.fax!;
    _phonet_t.text = dataProvider.printMediaModel.phone!;
    _mobile.text = dataProvider.printMediaModel.mobile!;
    _contact.text = dataProvider.printMediaModel.contact!;
    _facebook.text = dataProvider.printMediaModel.facebook!;
    _editor.text = dataProvider.printMediaModel.editor!;
    _business_type.text = dataProvider.printMediaModel.businessType!;
    _director.text = dataProvider.printMediaModel.director!;
    _position.text = dataProvider.printMediaModel.position!;

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
  FatchDataHelper _fatchDataHelper = new FatchDataHelper();
  List prints = Variables().getPrintingMediaList();
  String dropdownValue = "Daily News Paper";

  @override
  Widget build(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
    Size size = MediaQuery.of(context).size;
    if (counter == 0) {
      customInit(dataProvider);
    }
    return Container(
      height: size.height,
      width: size.width * .8,
      color: Colors.blueGrey,
          child: Column(
            children: [
              SizedBox(height: 3,),
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
                                  child: CircleAvatar(
                                    radius: size.height * .085,
                                    backgroundColor: Colors.white,
                                    child: dataProvider.printMediaModel.image!.isEmpty
                                        ? Icon(Icons.photo)
                                        : Image.network(
                                        dataProvider.printMediaModel.image!),
                                  ),
                                )
                                    : CircleAvatar(
                                  radius: size.height * .09,
                                  child: Image.memory(
                                    data!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      pickedImage(dataProvider);
                                    },
                                    icon: Icon(Icons.add_photo_alternate_rounded, color: Colors.black54))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.blueGrey),
                                ),
                                // width: size.width * .4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Please Select Your Sub-Category :",style: TextStyle(fontSize: size.height*.025),),
                                      SizedBox(
                                        width: size.height*.04,
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: dropdownValue,
                                          elevation: 0,
                                          dropdownColor: Colors.white,
                                          style: TextStyle(color: Colors.black),
                                          items: prints.map((itemValue) {
                                            return DropdownMenuItem<String>(
                                              value: itemValue,
                                              child: Text(itemValue),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.blueGrey),
                                ),
                                // width: size.width * .2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Status : ",style: TextStyle(fontSize: size.height*.025),),
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
                          printMediaWidget(size),
                          SizedBox(
                            height: size.height * .04,
                          ),

                          _isLoading?
                          Container(height: size.height * .06, child: fadingCircle):
                          ElevatedButton(
                            onPressed: () {


                              updateData(dataProvider, firebaseProvider);


                              //  Navigator.pop(context,true);

                              // showToast(imageUrl);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * .04,
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
  Widget printMediaWidget(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width *.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForPrintMedia('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('E-mail'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('FAX'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Phone(T&T)'),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width *.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForPrintMedia('Mobile'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('FaceBook'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Editor'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Business Type'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Director'),
                      SizedBox(height: 20),
                      _textFormBuilderForPrintMedia('Position'),
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
  Widget _textFormBuilderForPrintMedia(String hint) {
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
          : hint == 'Editor'
          ? _editor
          : hint == 'Business Type'
          ? _business_type
          : hint == 'Director'
          ? _director
          : _position,
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
  pickedImage(DataProvider dataProvider) async {
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
        'contact': _contact.text,
        'facebook': _facebook.text,
        'image': imageUrl,
        'editor':_editor.text,
        'businessType': _business_type.text,
        'director':_director.text,
        'position':_position.text,
        'id': dataProvider.printMediaModel.id!,
        'status': statusValue.toLowerCase(),
        'date': dateData,
        'sub-category':dropdownValue,
      };
      setState(()=>_isLoading=true);
      await firebaseProvider.updatePrintMediaData(mapData, context).then((value){
        if (value) {
          setState(() => _isLoading = false);
          dataProvider.category=dataProvider.subCategory;
          dataProvider.subCategory = "Print Media Screen";
          showToast('Data updated successful');
        } else {
          setState(() => _isLoading = false);
          dataProvider.category=dataProvider.subCategory;
          dataProvider.subCategory = "Print Media Screen";
          showToast('Data update failed!');
        }
      });
    }else showToast("Select Status");
  }
  Future<void> updateData(DataProvider dataProvider ,FirebaseProvider firebaseProvider)async{
    if(data==null){
      setState(() {
        imageUrl = dataProvider.printMediaModel.image!;
      });
      _submitData(dataProvider,firebaseProvider,);
    }else{
      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(dataProvider.subCategory).child(dataProvider.printMediaModel.id!);
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
