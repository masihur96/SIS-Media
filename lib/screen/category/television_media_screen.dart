import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/rate_chart/television_widget.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

class TelevisionMediaScreen extends StatefulWidget {
  @override
  _TelevisionMediaScreenState createState() => _TelevisionMediaScreenState();
}

class _TelevisionMediaScreenState extends State<TelevisionMediaScreen> {

  bool _isLoading=false;
  TextEditingController _name = TextEditingController(text:'');
  TextEditingController _address = TextEditingController(text:'');
  TextEditingController _PABX = TextEditingController(text:'');
  TextEditingController _email = TextEditingController(text:'');
  TextEditingController _web = TextEditingController(text:'');
  TextEditingController _fax = TextEditingController(text:'');
  TextEditingController _phonet_t = TextEditingController(text:'');
  TextEditingController _mobile = TextEditingController(text:'');
  TextEditingController _caontact = TextEditingController(text:'');
  TextEditingController _facebook = TextEditingController(text:'');
  TextEditingController _business_type = TextEditingController(text:'');
  TextEditingController _camera = TextEditingController(text:'');
  TextEditingController _unit1 = TextEditingController(text:'');
  TextEditingController _unit2 = TextEditingController(text:'');
  TextEditingController _unit3 = TextEditingController(text:'');
  TextEditingController _unit4 = TextEditingController(text:'');
  TextEditingController _mac_pro = TextEditingController(text:'');
  TextEditingController _branch_office = TextEditingController(text:'');
  TextEditingController _programs = TextEditingController(text:'');
  TextEditingController _training = TextEditingController(text:'');
  TextEditingController _shooting = TextEditingController(text:'');
  TextEditingController _location = TextEditingController(text:'');
  TextEditingController _artist_type = TextEditingController(text:'');
  TextEditingController _representative = TextEditingController(text:'');
  TextEditingController _designation = TextEditingController(text:'');
  TextEditingController _company_name = TextEditingController(text:'');
  TextEditingController _regionalSalesOffice = TextEditingController(text:'');
  TextEditingController _channelName = TextEditingController(text:'');
  TextEditingController _houseName = TextEditingController(text:'');







  Widget TelevisionMediaFild() {
    return Container(
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
          _textFormBuilderForTelevision('Business Type'),
          SizedBox(height: 20),
          _textFormBuilderForTelevision('Camera'),
          SizedBox(height: 20),
          _textFormBuilderForTelevision('Unit 1'),
          SizedBox(height: 20),
          _textFormBuilderForTelevision('Unit 2'),
          SizedBox(height: 20),
          _textFormBuilderForTelevision('Unit 3'),
          SizedBox(height: 20),
          _textFormBuilderForTelevision('Unit 4'),
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
          SizedBox(height: 20),
          _textFormBuilderForTelevision('House Name'),
          SizedBox(height: 20),

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


  // Widget CommonCategoryFild() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         _textFormBuilder('Name'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Address'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('PABX'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('E-mail'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Web'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('FAX'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Phone(T&T)'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Mobile'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Caontact'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('FaceBook'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Designation'),
  //         SizedBox(height: 20),
  //         _textFormBuilder('Hall Name'),
  //         SizedBox(height: 20),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _textFormBuilder(String hint) {
  //   return TextFormField(
  //     controller: hint == 'Name'
  //         ? _name
  //         : hint == 'address'
  //         ? _address
  //         : hint == 'PABX'
  //         ? _PABX
  //         : hint == 'Email Address'
  //         ? _email
  //         : hint == 'WEB'
  //         ? _web
  //         : hint == 'Fax'
  //         ? _fax
  //         : hint == 'Phone Number(T & T)'
  //         ? _phonet_t
  //         : hint == 'Mobile'
  //         ? _mobile
  //         : hint == 'Contact'
  //         ? _caontact
  //         : hint == 'Designation'
  //         ? _designation
  //         : hint == 'Hall Name'
  //         ? _hallname
  //         : hint == 'Facebok'
  //         ? _facebook
  //         : _address,
  //     decoration: InputDecoration(hintText: hint),
  //   );
  // }

  final _ktabs = <Tab>[
    const Tab(
      text: 'All Data',
    ),
    const Tab(
      text: 'Insert Data',
    ),
  ];
  List staatus=[
    'Public',
    'Private'
  ];

  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Television Channel';
  String channelValue = 'Bangladesh Television';
  bool _checkbox_Sponsorship = false;
  Widget rateChartWidget = TelevisionRateChartWidget().TelevisionRateChart();
  Widget rateChartWidgetsponsorship = TelevisionRateChartWidget().TelevisionRateChartforSponsorship();
  Widget rateChartWidgetchannelI = TelevisionRateChartWidget().TelevisionRateChartforchannelI();
  List Televisions = Variables().getTelevisionList();
  List Channels = Variables().getTVChannelList();
  String statusValue = "Public";

  var  _image;
  Future _getImage() async {

    html.File imageFile =
    await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (imageFile != null) {

      setState(() {
        _image = imageFile;
      });
    }

  }
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
                    _allDataUI(
                      size,
                      dataProvider,
                      context,
                    ),
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
                        items: Televisions.map((itemValue) {
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
                  "Television Media",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                items: Televisions.map((itemValue) {
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
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: dropdownValue == "Rate Chart",
                        child: Container(
                          child: Row(
                            children: [
                              Text("Please Select Channel Name :"),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<String>(
                                value: channelValue,
                                elevation: 0,
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.black),
                                items: Channels.map((itemValue) {
                                  return DropdownMenuItem<String>(
                                    value: itemValue,
                                    child: Text(itemValue),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    channelValue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                    visible: dropdownValue == "Rate Chart",
                    child: Column(
                      children: <Widget>[


                        Visibility(
                            visible: channelValue == 'Bangladesh Television',
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("To Rate For Sponsorship : "),
                                    Checkbox(
                                      value: _checkbox_Sponsorship,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkbox_Sponsorship =
                                              !_checkbox_Sponsorship;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                _checkbox_Sponsorship
                                    ? rateChartWidgetsponsorship
                                    : rateChartWidget,
                              ],
                            )
                        ),
                        Visibility(
                            visible: channelValue=='Channel I'||channelValue=='MAASRANGA'||channelValue=='CHANNEL 9'||channelValue=='ASIAN TV',
                            child: rateChartWidgetchannelI,
                        ),
                      ],
                    )),
                Visibility(
                  visible: dropdownValue != "Rate Chart",
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        TelevisionMediaFild()
                      ],
                    ),
                  ),
                ),
                _isLoading?
                Container(
                  height: 50.0,
                  child: fadingCircle)
                 : ElevatedButton(
                      onPressed: () async {
                        _submitData(dataProvider,firebaseProvider);
                      },
                      child: Text(
                        'Insert Data',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
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
        'contact': _caontact.text,
        'facebook': _facebook.text,
        'image': '',
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
        'id': uuid,
        'category': dataProvider.subCategory,
        'sub-category': dropdownValue,
        'status': statusValue.toLowerCase(),
        'date': dateData,
      };
      await firebaseProvider.addTelevisionMediaData(map).then((value){
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
    _caontact.clear();
    _facebook.clear();
    _business_type.clear();
    _camera.clear();
    _unit1.clear();
    _unit2.clear();
    _unit3.clear();
    _unit4.clear();
    _mac_pro.clear();
    _branch_office.clear();
    _programs.clear();
    _training.clear();
    _shooting.clear();
    _location.clear();
    _artist_type.clear();
    _representative.clear();
    _designation.clear();
    _company_name.clear();
    _regionalSalesOffice.clear();
    _channelName.clear();
    _houseName.clear();
  }

}
