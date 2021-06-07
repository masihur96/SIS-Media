import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import '../../widgets/notificastion.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

class FilmMediaScreen extends StatefulWidget {
  @override
  _FilmMediaScreenState createState() => _FilmMediaScreenState();
}

class _FilmMediaScreenState extends State<FilmMediaScreen> {
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
  TextEditingController _designation = TextEditingController(text:'');
  TextEditingController _hallname = TextEditingController(text:'');

  Widget commonCategoryFild() {
    return Container(
      child: Column(
        children: <Widget>[
          _textFormBuilder('Name'),
          SizedBox(height: 20),
          _textFormBuilder('Address'),
          SizedBox(height: 20),
          _textFormBuilder('PABX'),
          SizedBox(height: 20),
          _textFormBuilder('E-mail'),
          SizedBox(height: 20),
          _textFormBuilder('Web'),
          SizedBox(height: 20),
          _textFormBuilder('FAX'),
          SizedBox(height: 20),
          _textFormBuilder('Phone(T&T)'),
          SizedBox(height: 20),
          _textFormBuilder('Mobile'),
          SizedBox(height: 20),
          _textFormBuilder('Contact'),
          SizedBox(height: 20),
          _textFormBuilder('FaceBook'),
          SizedBox(height: 20),
          _textFormBuilder('Designation'),
          SizedBox(height: 20),
          _textFormBuilder('Hall Name'),
          SizedBox(height: 20),
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
          : hint == 'Designation'
          ? _designation
          : _hallname,

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

  final _ktabs = <Tab>[
    const Tab(text: 'All Data',),
    const Tab(text: 'Insert Data',),
  ];
  final _formKey = GlobalKey<FormState>();
  Variables filmmedialist = Variables();
  String dropdownValue = "Film Institution";
  List staatus=[
    'Public',
    'Private'
  ];
  String statusValue = "Public";
  List films = Variables().getFilmMediaList();


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return Container(
        color: Color(0xffedf7fd),
        child: Column(
          children: <Widget>[
            Container(
              width:dataProvider.pageWidth(size),
              height: size.height * .91,
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
                    _allFilmUI(size, dataProvider, context,),
                    _insetFilmUI(size, context, dataProvider,firebaseProvider),
                  ]),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _allFilmUI(
    Size size,
    DataProvider dataProvider,
    BuildContext context,

  ) =>
      Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: size.width * .4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Please Select Your Sub-Category :"),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 0,
                        dropdownColor: Colors.white,
                        style: TextStyle(color: Colors.black),
                        items: films.map((itemValue) {
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
                  width: size.width * .3,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Please Search your Query",
                        prefixIcon: Icon(Icons.search_outlined),
                        enabledBorder: InputBorder.none),
                  ),
                )
              ],
            ),
            Align(alignment: Alignment.center, child: Text("Show All Data")),
          ],
        ),
      );

  Widget _insetFilmUI(
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
                  "Film Media",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
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
                            Text("Please Select Your Sub-Category :"),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              elevation: 0,
                              dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              items: films.map((itemValue) {
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

                            SizedBox(width: 5,),
                            Text("Status : "),
                          Expanded(
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
                    ],
                  ),
                ),
                commonCategoryFild(),
                _isLoading
                    ?Container(
                  height: 50.0,
                    child: fadingCircle)
                    : ElevatedButton( onPressed: () {
                 _submitData(dataProvider,firebaseProvider);
                },
                    child: Text(
                          'Submit Data',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )
                ),
                SizedBox(height: 20),
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
         'phone': _phonet_t.text,
         'address': _address.text,
         'pabx': _PABX.text,
         'email': _email.text,
         'web': _web.text,
         'fax': _fax.text,
         'mobile': _mobile.text,
         'contact': _contact.text,
         'facebook': _facebook.text,
         'designation': _designation.text,
         'hallname': _hallname.text,
         'date': dateData,
         'id': uuid,
         'image': '',
         'status': statusValue.toLowerCase(),
         'category': dataProvider.subCategory,
         'sub-category': dropdownValue
       };
       await firebaseProvider.addFilmMediaData(map).then((value){
         if(value){
           setState(()=> _isLoading=false);
           showToast('Success');
           _emptyFildCreator();
         } else {
           setState(()=> _isLoading=false);
           showToast('Failed');
         }
       });
     }else showToast("Select Status");


  }

  _emptyFildCreator(){

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
    _designation.clear();
    _hallname.clear();

  }



}

