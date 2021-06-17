import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/rate_chart/television_widget.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/painting.dart';

class TelevisionMediaScreen extends StatefulWidget {
  @override
  _TelevisionMediaScreenState createState() => _TelevisionMediaScreenState();
}

class _TelevisionMediaScreenState extends State<TelevisionMediaScreen> {
  bool _isLoading = false;
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

  final _ktabs = <Tab>[
    const Tab(text: 'All Data',),
    const Tab(text: 'Insert Data',),
  ];
  List staatus = ['Public', 'Private'];
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Television Channel';
  String channelValue = 'Bangladesh Television';
  bool _checkboSponsorship = false;
  Widget rateChartWidget = TelevisionRateChartWidget().TelevisionRateChart();
  Widget rateChartWidgetsponsorship =
      TelevisionRateChartWidget().TelevisionRateChartforSponsorship();
  Widget rateChartWidgetchannelI =
      TelevisionRateChartWidget().TelevisionRateChartforchannelI();
  List Televisions = Variables().getTelevisionList();
  List Channels = Variables().getTVChannelList();

  String statusValue = "Public";
  final String uuid = Uuid().v1();
  String name='';
  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
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
                          labelStyle:TextStyle(fontSize: size.height*.04,),
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
                      _insetDataUI(size, context, dataProvider, firebaseProvider),
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
  ) =>
      Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: size.width * .4,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Please Select Your Sub-Category :",style: TextStyle(fontSize: size.height*.04),),
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
            ),
            Align(alignment: Alignment.center, child: Text("Show All Data",style: TextStyle(fontSize: size.height*.04),)),
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
       height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Television Media",
                    style: TextStyle(
                        fontSize: size.height*.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
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
                            height: size.height*.05,
                            width: size.height*.05,
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
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          width: size.width * .5,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Please Select Your Sub-Category : ",style: TextStyle(fontSize: size.height*.025),),
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
                          )),
                      Container(
                          width: size.width * .2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Status : ",style: TextStyle(fontSize: size.height*.025),),
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
                                      value: _checkboSponsorship,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboSponsorship =
                                              !_checkboSponsorship;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                _checkboSponsorship
                                    ? rateChartWidgetsponsorship
                                    : rateChartWidget,
                              ],
                            )),
                        Visibility(
                          visible: channelValue == 'Channel I' ||
                              channelValue == 'MAASRANGA' ||
                              channelValue == 'CHANNEL 9' ||
                              channelValue == 'ASIAN TV',
                          child: rateChartWidgetchannelI,
                        ),
                      ],
                    )),
                Visibility(
                  visible: dropdownValue != "Rate Chart",
                  child: Container(
                    child: Column(
                      children: <Widget>[TelevisionMediaFild(size)],
                    ),
                  ),
                ),

                SizedBox(height: size.height*.04,),
                _isLoading
                    ? Container(height: size.height*.06, child: fadingCircle)
                    : ElevatedButton(
                        onPressed: () async {
                          uploadPhoto(dataProvider, firebaseProvider);
                          setState(() {
                            data=null;
                          });
                        },
                        child: Text(
                          'Submit Data Data',
                            style: TextStyle(color: Colors.white, fontSize: size.height*.04,
                        )),
                )
              ],
            ),
          ),
        ),
      );

  Future<void> _submitData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';

    if (statusValue.isNotEmpty) {
      setState(() => _isLoading = true);
      Map<String, String> map = {
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
        'id': uuid,
        'category': dataProvider.subCategory,
        'sub-category': dropdownValue,
        'status': statusValue.toLowerCase(),
        'date': dateData,
      };
      await firebaseProvider.addTelevisionMediaData(map).then((value) {
        if (value) {
          setState(() => _isLoading = false);
          showToast('Success');
          _emptyFildCreator();
        } else {
          setState(() => _isLoading = false);
          showToast('Failed');
        }
      });
    } else
      showToast("Select Status");
  }

  _emptyFildCreator() {
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
    firebase_storage.Reference storageReference =
    firebase_storage.FirebaseStorage.instance.ref().child(dataProvider.subCategory).child(uuid);
    firebase_storage.UploadTask storageUploadTask = storageReference.putBlob(file);
    firebase_storage.TaskSnapshot taskSnapshot;
    storageUploadTask.then((value) {
      taskSnapshot = value;
      taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl){
        final downloadUrl = newImageDownloadUrl;
        _submitData(dataProvider,firebaseProvider);
        setState((){
          imageUrl = downloadUrl;
        });
      });
    });
  }


  Widget TelevisionMediaFild(Size size) {
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
                width:  size.width>1200? size.width*.4: size.width *.5,
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
          : hint ==
          'Unit 4'
          ? _unit4
          : hint ==
          'Mac Pro'
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