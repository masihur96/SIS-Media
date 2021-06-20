import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/widgets/film_media_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'update_screen/update_importent_emergency.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:html' as html;
import 'package:uuid/uuid.dart';

class ImportentEmergency extends StatefulWidget {
  @override
  _ImportentEmergencyState createState() => _ImportentEmergencyState();
}

class _ImportentEmergencyState extends State<ImportentEmergency> {
  bool _isLoading=false;

  TextEditingController _name = TextEditingController(text:'',);
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


  List staatus=[
    'Public',
    'Private'
  ];
  String statusValue = "Public";
  String? uuid;
  String name='';
  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;

  String dropdownValue = "Bangladesh : At A Glance";

  final _ktabs = <Tab>[
    const Tab(text: 'All Data',),
    const Tab(text: 'Insert Data',),
  ];
  final _formKey = GlobalKey<FormState>();
  List importentEmergency = Variables().getImportentEmergencyList();

  FatchDataHelper _databaseHelper = FatchDataHelper();

  List<ImportentEmergencyModel> _dataList  = [];
  List<ImportentEmergencyModel> _dataListForDisplay = [];

  // List<ImportentEmergencyModel> _subList = [];
  // List<ImportentEmergencyModel> _filteredSubList = [];
  // int _counter=0;

  // void _initializeData() {
  //   setState((){
  //     _subList = _dataList;
  //     _filteredSubList = _subList;
  //     _counter++;
  //   });
  // }
  // ///SearchList builder
  // _filterList(String searchItem) {
  //   setState(() {
  //     _filteredSubList = _subList.where((element) =>
  //     (element.name.toLowerCase().contains(searchItem.toLowerCase()))).toList();
  //   });
  // }


  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
    setState(() {
      _dataListForDisplay = _dataList;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

 //   if(_counter==0) _initializeData();

    return Container(
        color: Color(0xffedf7fd),
        width:dataProvider.pageWidth(size),
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: size.height*.913,
                child: DefaultTabController(
                  length: _ktabs.length,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: AppBar(
                        elevation: 0.0,
                        backgroundColor: Color.fromRGBO(216, 211, 216, 1),
                        bottom: TabBar(
                          tabs: _ktabs,
                          indicatorColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          labelColor: Colors.black,
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      _allDataUI(size, dataProvider, context,firebaseProvider),
                      _insetDataUI(size, context,dataProvider,firebaseProvider),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));

  }
  Widget _allDataUI(
      Size size,
      DataProvider dataProvider,
      BuildContext context,
      FirebaseProvider firebaseProvider,
      ) =>
      Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFFCCDDE7),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width * .5,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Please Select Your Sub-Category :"),
                            DropdownButton<String>(
                              value: dropdownValue,
                              elevation: 0,
                              dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              items: importentEmergency.map((itemValue) {
                                _dataListForDisplay = _dataList.where((element) {
                                  var noteTitle = element.subCategory;
                                  return noteTitle.contains(dropdownValue);
                                }).toList();

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

                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .2,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Please Search your Query",
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search_outlined),
                            enabledBorder: InputBorder.none),
                        onChanged:(text){
                          text = text.toLowerCase();
                          setState(() {
                            _dataListForDisplay = _dataList.where((element) {
                              var noteTitle = element.name.toLowerCase();
                              return noteTitle.contains(text);
                            }).toList();

                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 500.0,
                child: RefreshIndicator(
                  backgroundColor: Colors.white,
                  onRefresh: ()async{
                    await _getDataFromDatabase();
                  //  _isLoading = false;
                  },
                  child:  new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return _listItem(index,size,firebaseProvider,);
                    },
                    itemCount: _dataListForDisplay.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  _listItem(index,Size size,FirebaseProvider firebaseProvider){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            Container(
                width: size.height*.15,
                height: size.height*.16,

            child: _dataListForDisplay[index].image.isEmpty? Image.asset('images/atnbanglalogo.jpg',fit: BoxFit.cover):Image.network(_dataListForDisplay[index].image,fit: BoxFit.cover)

            ),
            Container(
              width: size.width*.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dataListForDisplay[index].name.isEmpty?Container():
                  Text(_dataListForDisplay[index].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  _dataListForDisplay[index].address.isEmpty?Container():
                  Text('Address: ${_dataListForDisplay[index].address}',style: TextStyle(fontSize: 12,)),
                  _dataListForDisplay[index].pabx.isEmpty?Container():
                  Text('PABX: ${_dataListForDisplay[index].pabx}',style: TextStyle(fontSize: 12),),
                  _dataListForDisplay[index].email.isEmpty?Container():
                  Text('E-mail: ${_dataListForDisplay[index].email}',style: TextStyle(fontSize: 12,)),
                  _dataListForDisplay[index].web.isEmpty?Container():
                  Text('Web: ${_dataListForDisplay[index].web}',style: TextStyle(fontSize: 12,)),
                  _dataListForDisplay[index].fax.isEmpty?Container():
                  Text('Fax: ${_dataListForDisplay[index].fax}',style: TextStyle(fontSize: 12)),
                  _dataListForDisplay[index].phone.isEmpty?Container():
                  Text('Phone: ${_dataListForDisplay[index].phone}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].mobile.isEmpty?Container():
                  Text('Mobile: ${_dataListForDisplay[index].mobile}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].contact.isEmpty?Container():
                  Text('Contact: ${_dataListForDisplay[index].contact}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].facebook.isEmpty?Container():
                  Text('Facebook: ${_dataListForDisplay[index].facebook}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].corporateOffice.isEmpty?Container():
                  Text('Corporate Office: ${_dataListForDisplay[index].corporateOffice}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].headOffice.isEmpty?Container():
                  Text('Head Office: ${_dataListForDisplay[index].headOffice}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].position.isEmpty?Container():
                  Text('Position: ${_dataListForDisplay[index].position}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].businessType.isEmpty?Container():
                  Text('Business Type: ${_dataListForDisplay[index].businessType}',style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].status.isEmpty?Container():
                  Text('Status: ${_dataListForDisplay[index].status}',style: TextStyle(fontSize: 12,),),
                  // _dataList[index].id.isEmpty?Container():
                  // Text(_dataList[index].id,style: TextStyle(fontSize: 12,),),
                  _dataListForDisplay[index].date.isEmpty?Container():
                  Text('Date: ${_dataListForDisplay[index].date}',style: TextStyle(fontSize: 12,),),
                ],
              ),
            ),
            Container(
              width: size.width*.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          UpdateImportentEmergencyData(
                            name: _dataList[index].name,
                            address: _dataList[index].address,
                            pabx: _dataList[index].pabx,
                            email: _dataList[index].email,
                            web: _dataList[index].web,
                            fax: _dataList[index].fax,
                            phone: _dataList[index].phone,
                            mobile: _dataList[index].mobile,
                            contact: _dataList[index].contact,
                            facebook: _dataList[index].facebook,
                            image: _dataList[index].image,
                            corporateOffice: _dataList[index].corporateOffice,
                            headOffice: _dataList[index].headOffice,
                            position: _dataList[index].position,
                            businessType: _dataList[index].businessType,
                            id: _dataList[index].id,
                            status: _dataList[index].status,
                            date: _dataList[index].date,
                          )));

                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),


                  SizedBox(height: 5,),

                  ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Confirmation Alert",
                        desc: "Are you confirm to delete this item ?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              setState(()=> _isLoading=true);
                              firebaseProvider.deleteImportentEmergencyData(_dataList[index].id, context).then((value){
                                if(value==true){
                                  _getDataFromDatabase();
                                  setState(()=> _isLoading=false);
                                  Navigator.pop(context);
                                  showToast('Data deleted successful');
                                }else{
                                  setState(()=> _isLoading=false);
                                  showToast('Data delete unsuccessful');
                                }
                              });
                            },
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
                          )
                        ],
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );


  }

  Widget _insetDataUI(
      Size size,
      BuildContext context,
      DataProvider dataProvider,
      FirebaseProvider firebaseProvider,

      ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Importent & Emergency",
                  style: TextStyle(
                      fontSize: size.height*.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
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
                          child: Icon(Icons.account_box),
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
                      width: size.width * .6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Please Select Your Sub-Category : "),

                            DropdownButton<String>(
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  width: size.width * .2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Status : "),
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
                ),
                ImportMediaWidget(size),

                _isLoading?
                Container(
                    child: fadingCircle)
                    : ElevatedButton(
                    onPressed: () async {
                      uuid = Uuid().v1();
                      uploadPhoto(dataProvider,firebaseProvider);
                      setState(() {
                        data=null;
                      });
                    },
                    child: Text(
                      'Insert Data',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))
              ],
            ),
          ),
        ),
      );
  Future<void> _submitData(DataProvider dataProvider,FirebaseProvider firebaseProvider) async{
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if(statusValue.isNotEmpty){
      setState(()=> _isLoading=true);
      Map<String,String> map ={
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
        'id': uuid!,
        'category': dataProvider.subCategory,
        'sub-category': dropdownValue,
        'date': dateData,
        'status': statusValue.toLowerCase(),
      };
      await firebaseProvider.addImportentEmergencyData(map).then((value){
        if(value){
          setState(()=> _isLoading=false);
          showToast('Success');
          _emptyFieldCreator();
        } else {
          setState(()=> _isLoading=false);
          showToast('Failed');
        }
      });
    }else showToast("Select Status");


  }

  _emptyFieldCreator(){

    _name.clear();
    _address.clear();
    _PABX.clear();
    _email.clear();
    _web.clear();
    _fax.clear();
    _phonet_t.clear();
    _mobile.clear();
    _contact.clear();
    _facebook.clear();
    _corporateOffice.clear();
    _headOffice.clear();
    _position.clear();
    _businessType.clear();

  }

  Widget ImportMediaWidget(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:  size.width>1200? size.width*.4: size.width *.5,
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
                width:  size.width>1200? size.width*.4: size.width *.5,
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
  Future<void> uploadPhoto(DataProvider dataProvider ,FirebaseProvider firebaseProvider)async{
    if(data==null){
      _submitData(dataProvider,firebaseProvider,);
    }else {
      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(dataProvider.subCategory).child(uuid!);
      firebase_storage.UploadTask storageUploadTask = storageReference.putBlob(file);
      firebase_storage.TaskSnapshot taskSnapshot;
      storageUploadTask.then((value) {
        taskSnapshot = value;
        taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl){
          final downloadUrl = newImageDownloadUrl;
          setState((){
            imageUrl = downloadUrl;
          });
          _submitData(dataProvider,firebaseProvider,);
        });
      });
    }
  }

  Future<void> _getDataFromDatabase()async{
    await _databaseHelper.fetchImportentEmergencyData().then((result){
      if(result.isNotEmpty){
        setState(() {
          _dataList.clear();
          _dataList=result;
          _isLoading=false;
          showToast("Data  Get Successful");
        });
      }else{
        setState(() {
          _dataList.clear();
          _isLoading=false;
          showToast('Failed to fetch data');
        });
      }
    });
  }

}
