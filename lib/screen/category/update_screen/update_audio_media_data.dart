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

class UpdateAdioData extends StatefulWidget {

  String? id;
  String? name;
  String? address;
  String? pabx;
  String? email;
  String? web;
  String? fax;
  String? phone;
  String? mobile;
  String?contact;
  String? facebook;
  String? image;
  String? chiefEngineer;
  String? director;
  String? regionalStation;
  String? salesContact;
  String? whatApp;
  String? hotlineNumber;
  String? businessType;
  String? channelName;
  String? status;
  String? date;
  String? ddgNews;
  String? ddgprogram;

  UpdateAdioData(
      {
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
         this.image,
         this.chiefEngineer,
         this.director,
         this.regionalStation,
         this.salesContact,
         this.whatApp,
         this.hotlineNumber,
         this.businessType,
         this.channelName,
         this.status,
         this.date,
         this.ddgNews,
         this.ddgprogram
      }
      );
  @override
  _UpdateAdioDataState createState() => _UpdateAdioDataState();
}

class _UpdateAdioDataState extends State<UpdateAdioData> {

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
  TextEditingController _chief_enginear = TextEditingController();
  TextEditingController _director = TextEditingController();
  TextEditingController _regional_station = TextEditingController();
  TextEditingController _sales_contact = TextEditingController();
  TextEditingController _whats_app = TextEditingController();
  TextEditingController _hotline_number = TextEditingController();
  TextEditingController _business_type = TextEditingController();
  TextEditingController _channelName = TextEditingController();
  TextEditingController _ddgProgram = TextEditingController();
  TextEditingController _ddgNews = TextEditingController();


  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    _name.text = dataProvider.audioMediaModel.name!;
    _address.text = dataProvider.audioMediaModel.address!;
    _PABX.text =dataProvider.audioMediaModel.pabx!;
    _email.text = dataProvider.audioMediaModel.email!;
    _web.text = dataProvider.audioMediaModel.web!;
    _fax.text = dataProvider.audioMediaModel.fax!;
    _phonet_t.text = dataProvider.audioMediaModel.phone!;
    _mobile.text = dataProvider.audioMediaModel.mobile!;
    _contact.text = dataProvider.audioMediaModel.contact!;
    _facebook.text = dataProvider.audioMediaModel.facebook!;;
    _chief_enginear.text = dataProvider.audioMediaModel.chiefEngineer!;
    _director.text = dataProvider.audioMediaModel.director!;
    _regional_station.text = dataProvider.audioMediaModel.regionalStation!;
    _sales_contact.text = dataProvider.audioMediaModel.salesContact!;
    _whats_app.text = dataProvider.audioMediaModel.whatApp!;
    _hotline_number.text = dataProvider.audioMediaModel.hotlineNumber!;
    _business_type.text = dataProvider.audioMediaModel.businessType!;
    _channelName.text = dataProvider.audioMediaModel.channelName!;
    _ddgNews.text = dataProvider.audioMediaModel.ddgNews!;
    _ddgProgram.text = dataProvider.audioMediaModel.ddgprogram!;
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
  String dropdownValue = "FM Radio Channel";
  List audios = Variables().getAudioMediaList();
  FatchDataHelper _fatchDataHelper = new FatchDataHelper();
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
                                    child: dataProvider.audioMediaModel.image!.isEmpty
                                        ? Icon(Icons.photo)
                                        : Image.network(
                                        dataProvider.audioMediaModel.image!),
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
                                          items: audios.map((itemValue) {
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
                          AudioMediaFild(size),
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
        'contact': _contact.text,
        'facebook': _facebook.text,
        'image': imageUrl,
        'chiefEngineer':_chief_enginear.text,
        'director':_director.text,
        'regionalStation':_regional_station.text,
        'salesContact':_sales_contact.text,
        'whatsApp':_whats_app.text,
        'hotlineNumber':_hotline_number.text,
        'businessType': _business_type.text,
        'channelName': _channelName.text,
        'id': dataProvider.audioMediaModel.id!,
        'status': statusValue.toLowerCase(),
        'date': dateData,
        'ddgProgram': _ddgProgram.text,
        'ddgNews': _ddgNews.text,

      };
      setState(()=>_isLoading=true);
      await firebaseProvider.updateAudioMediaData(mapData, context).then((value){
        if(value){
          setState(()=>_isLoading=false);
          dataProvider.category=dataProvider.subCategory;
          dataProvider.subCategory = "Audio Media Screen";
          showToast('Data updated successful');
        }
        else{
          setState(()=>_isLoading=false);
          showToast('Data update failed!');

        }
      });
    }else showToast("Select Status");
  }

  Widget AudioMediaFild(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:  size.width*.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForAudio('Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Address'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('PABX'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('E-mail'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Web'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('FAX'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Phone(T&T)'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Mobile'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('FaceBook'),

                    ],
                  ),
                ),
              ),
              Container(
                width:  size.width*.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _textFormBuilderForAudio('Chief Enginear'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Director'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Regional Station'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Sales Contact'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Whats App'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Hotline Number'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Business Type'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('Channel Name'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('DDG (Program)'),
                      SizedBox(height: 20),
                      _textFormBuilderForAudio('DDG (News)'),
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
  Widget _textFormBuilderForAudio(String hint) {
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
          : hint == 'Chief Enginear'
          ? _chief_enginear
          : hint == 'Director'
          ? _director
          : hint == 'Regional Station'
          ? _regional_station
          : hint == 'Sales Contact'
          ? _sales_contact
          : hint == 'Whats App'
          ? _whats_app
          : hint == 'Hotline Number'
          ? _hotline_number
          : hint == 'Business Type'
          ? _business_type
          : hint == 'Channel Name'
          ? _channelName
          : hint == 'DDG (Program)'
          ? _ddgProgram
          : _ddgNews,

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
  Future<void> uploadPhoto(DataProvider dataProvider ,FirebaseProvider firebaseProvider)async{
    if(data==null){
      setState(() {
        imageUrl = dataProvider.audioMediaModel.image!;
      });
      _submitData(dataProvider,firebaseProvider,);
    }else{
      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(dataProvider.subCategory).child(dataProvider.audioMediaModel.id!);
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
  Future<void> updateData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    if (data == null) {
      setState(() {
        imageUrl = dataProvider.audioMediaModel.image!;
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
          .child(dataProvider.audioMediaModel.id!);
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
