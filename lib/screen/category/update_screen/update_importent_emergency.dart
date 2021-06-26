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

class UpdateImportentEmergencyData extends StatefulWidget {
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
  String? corporateOffice;
  String? headOffice;
  String? position;
  String? businessType;
  String? id;
  String? status;
  String? date;

  UpdateImportentEmergencyData(
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
         this.corporateOffice,
         this.headOffice,
         this.position,
         this.businessType,
         this.id,
         this.status,
         this.date
      });

  @override
  _UpdateImportentEmergencyDataState createState() => _UpdateImportentEmergencyDataState();
}

class _UpdateImportentEmergencyDataState extends State<UpdateImportentEmergencyData> {
  
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
  TextEditingController _corporateOffice = TextEditingController(text:'');
  TextEditingController _headOffice = TextEditingController(text:'');
  TextEditingController _position = TextEditingController(text:'');
  TextEditingController _businessType = TextEditingController(text:'');

  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    _name.text = dataProvider.importentEmergencyModel.name!;
    _address.text = dataProvider.importentEmergencyModel.address!;
    _PABX.text = dataProvider.importentEmergencyModel.pabx!;
    _email.text = dataProvider.importentEmergencyModel.email!;
    _web.text = dataProvider.importentEmergencyModel.web!;
    _fax.text = dataProvider.importentEmergencyModel.fax!;
    _phonet_t.text = dataProvider.importentEmergencyModel.phone!;
    _mobile.text = dataProvider.importentEmergencyModel.mobile!;
    _contact.text = dataProvider.importentEmergencyModel.contact!;
    _facebook.text = dataProvider.importentEmergencyModel.facebook!;
    _corporateOffice.text = dataProvider.importentEmergencyModel.corporateOffice!;
    _headOffice.text = dataProvider.importentEmergencyModel.headOffice!;
    _position.text = dataProvider.importentEmergencyModel.position!;
    _businessType.text = dataProvider.importentEmergencyModel.businessType!;

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
  String dropdownValue = "Bangladesh : At A Glance";
  List importentEmergency = Variables().getImportentEmergencyList();

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
                                    child: dataProvider.importentEmergencyModel.image!.isEmpty
                                        ? Icon(Icons.photo)
                                        : Image.network(
                                        dataProvider.importentEmergencyModel.image!),
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
                                    icon: Icon(Icons.add_photo_alternate_outlined, color: Colors.black54))
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
                                          items: importentEmergency.map((itemValue) {
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
                          ImportMediaWidget(size),

                          SizedBox(height: size.height*.04,),

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

                          SizedBox(height: size.height*.04,),
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
        'corporateOffice': _corporateOffice.text,
        'headOffice': _headOffice.text,
        'position': _position.text,
        'businessType': _businessType.text,
        'id': dataProvider.importentEmergencyModel.id!,
        'date': dateData,
        'status': statusValue.toLowerCase(),
      };
      setState(()=>_isLoading=true);
      await firebaseProvider.updateImportentEmergencyData(mapData, context).then((value){
        if (value) {
          setState(() => _isLoading = false);
          dataProvider.category=dataProvider.subCategory;
          dataProvider.subCategory = "Important Media Screen";
          showToast('Data updated successful');
        } else {
          setState(() => _isLoading = false);
          dataProvider.category=dataProvider.subCategory;
          dataProvider.subCategory = "Important Media Screen";
          showToast('Data update failed!');
        }
      });
    }else showToast("Select Status");
  }

  Widget ImportMediaWidget(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:  size.width *.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForImport('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('E-mail'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('FAX'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Phone(T&T)'),
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
                      _textFormBuilderForImport('Mobile'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('FaceBook'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Corporate Office'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Head Office'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Position'),
                      SizedBox(height: 20),
                      _textFormBuilderForImport('Business Type'),
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
  Widget _textFormBuilderForImport(String hint) {
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
          : hint == 'Corporate Office'
          ? _corporateOffice
          : hint == 'Head Office'
          ? _headOffice
          : hint == 'Position'
          ? _position
          : _businessType,
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
  Future<void> updateData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    if (data == null) {
      setState(() {
        imageUrl = dataProvider.importentEmergencyModel.image!;
      });
      _submitData(
        dataProvider,
        firebaseProvider,
      );
    } else {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child(dataProvider.subCategory)
          .child(dataProvider.importentEmergencyModel.id!);
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


}

