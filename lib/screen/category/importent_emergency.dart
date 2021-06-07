import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

class ImportentEmergency extends StatefulWidget {
  @override
  _ImportentEmergencyState createState() => _ImportentEmergencyState();
}

class _ImportentEmergencyState extends State<ImportentEmergency> {
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

  Widget ImportMediaWidget() {
    return Container(
        child: Column(
          children: <Widget>[
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
          ],
        ));
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
          ? _facebook
          : hint == 'Head Office'
          ? _facebook
          : hint == 'Position'
          ? _facebook
          : _businessType,
      decoration: InputDecoration(hintText: hint),
    );
  }
  var  _image;
  // final picker = ImagePicker();

  Future _getImage() async {

    html.File imageFile =
    await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (imageFile != null) {

      setState(() {
        _image = imageFile;
      });
    }

  }
  List staatus=[
    'Public',
    'Private'
  ];
  String statusValue = "Public";
  String dropdownValue = "Bangladesh : At A Glance";

  final _ktabs = <Tab>[
    const Tab(text: 'All Data',),
    const Tab(text: 'Insert Data',),
  ];
  final _formKey = GlobalKey<FormState>();
  List importentEmergency = Variables().getImportentEmergencyList();
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
    return Container(
        color: Color(0xffedf7fd),
        child: Column(
          children: <Widget>[
            Container(
              width: size.width < 1200 ? 0.0 : size.width * .8,
              height: size.height * .8,
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
                    _allDataUI(size, dataProvider, context,),
                    _insetDataUI(size, context,dataProvider,firebaseProvider),
                  ]),
                ),
              ),
            ),
          ],
        ));

  }
  Widget _allDataUI(
      Size size,
      DataProvider dataProvider,
      BuildContext context,
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
                    Container(
                      width: size.width * .25,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Please Search your Query",
                            prefixIcon: Icon(Icons.search_outlined),
                            enabledBorder: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(child: Align(alignment: Alignment.center, child: Text("Show All Data"))),
          ],
        ),
      );
  Widget _insetDataUI(
      Size size,
      BuildContext context,
      DataProvider dataProvider,
      FirebaseProvider firebaseProvider,

      ) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Importent & Emergency",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50)),
                            color: Colors.grey,
                          ),
                          child: _image!=null? Image.file(_image): Icon(Icons.people),

                        ),
                        IconButton(
                            onPressed: ()=> _getImage(),
                            icon: Icon(Icons.camera_alt, color: Colors.black54))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      width: size.width * .5,
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
                          ),



                        ],
                      ),
                    ),
                  ],
                ),

                Container(
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
                ImportMediaWidget(),

                _isLoading?
                Container(
                    child: fadingCircle)
                    : ElevatedButton(
                    onPressed: () async {

                      _submitData(dataProvider,firebaseProvider);
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
    String uuid = Uuid().v1();
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
        'image': '',
        'corporateOffice': _corporateOffice.text,
        'headOffice': _headOffice.text,
        'position': _position.text,
        'businessType': _businessType.text,
        'id': uuid,
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



}
