import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/rate_chart/radio_widget.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

class AudioMediaScreen extends StatefulWidget {
  @override
  _AudioMediaScreenState createState() => _AudioMediaScreenState();
}

class _AudioMediaScreenState extends State<AudioMediaScreen> {
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

  Widget AudioMediaFild() {
    return Container(
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
          SizedBox(height: 20),
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
          SizedBox(height: 20),
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

      decoration: InputDecoration(hintText: hint),
    );
  }

  var  _image;
  // final picker = ImagePicker();


  String dropdownValue = "FM Radio Channel";
  String kendrodropdownValue = "Dhaka Kendro";
  String channelValue = 'Bangladesh Betar';
  List staatus=[
    'Public',
    'Private'
  ];
  String statusValue = "Public";
  final String uuid = Uuid().v1();
  String name='';
  String? error;
  Uint8List? data;
  String imageUrl = '';
  var file;
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
  final _ktabs = <Tab>[
    const Tab(text: 'All Data',),
    const Tab(text: 'Insert Data',),
  ];
  final _formKey = GlobalKey<FormState>();
  Variables audioMediaList = Variables();
  Widget rateChartbangladeshBeter = AudioRateChartWidgt().bangladeshBeterRateChart();
  Widget rateChartradioToday = AudioRateChartWidgt().RadioToday();
  Widget rateChartcommon = AudioRateChartWidgt().CommonForAudioForm();
  List Channels = Variables().getaudioChannelList();
  List Kendros = Variables().getKendroNameList();

  @override
  Widget build(BuildContext context) {
    List audios = audioMediaList.getAudioMediaList();

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
                    _allDataUI(size, dataProvider, context, audios),
                    _insetDataUI(size, context, audios,firebaseProvider,dataProvider),
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
    List Audios,
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
                            items: Audios.map((itemValue) {
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
              ),
            ),
            Center(
                child: Align(
                    alignment: Alignment.center, child: Text("Show All Data"))),
          ],
        ),
      );

  Widget _insetDataUI(
      Size size,
      BuildContext context,
      List audios,
      FirebaseProvider firebaseProvider,
      DataProvider dataProvider,
      ) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Audio Media",
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
                          imageUrl.isEmpty ? CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.account_box),

                          ): Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child:  imageUrl==null? Icon(Icons.image): Image.network(imageUrl,fit: BoxFit.fill,),
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
                Visibility(
                    visible: dropdownValue == "Rate Chart",
                    child:Column(
                      children: <Widget>[
                        Visibility(
                            visible: channelValue == 'Bangladesh Betar',
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("To Select Kendro : "),

                                    DropdownButton<String>(
                                      value: kendrodropdownValue,
                                      elevation: 0,
                                      dropdownColor: Colors.white,
                                      style: TextStyle(color: Colors.black),
                                      items: Kendros.map((itemValue) {
                                        return DropdownMenuItem<String>(
                                          value: itemValue,
                                          child: Text(itemValue),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          kendrodropdownValue = newValue!;
                                        });
                                      },
                                    ),


                                  ],
                                ),

                                rateChartbangladeshBeter

                              ],
                            )
                        ),
                        Visibility(
                            visible: channelValue == 'Radio Today',
                            child: Column(
                              children: [
                                rateChartcommon,
                                rateChartradioToday,
                              ],
                            ),
                        ),
                        // Visibility(
                        //   visible: channelValue=='Channel I'||channelValue=='MAASRANGA'||channelValue=='CHANNEL 9'||channelValue=='ASIAN TV',
                        //   child: rateChartWidgetchannelI,
                        // ),
                      ],
                    )),
                Visibility(
                  visible: dropdownValue != "Rate Chart",
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AudioMediaFild()
                      ],
                    ),
                  ),
                ),

                _isLoading?Container(
                    height: 50.0,
                    child: fadingCircle)
               : ElevatedButton(
                    onPressed: ()  {

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
        'image': '',
        'chiefEngineer':_chief_enginear.text,
        'chiefEngineer':_director.text,
        'chiefEngineer':_regional_station.text,
        'chiefEngineer':_sales_contact.text,
        'chiefEngineer':_whats_app.text,
        'chiefEngineer':_hotline_number.text,
        'designation': _business_type.text,
        'hallname': _channelName.text,
        'id': uuid,
        'category': dataProvider.subCategory,
        'sub-category': dropdownValue,
        'date': dateData,
        'status': statusValue.toLowerCase(),
      };
      await firebaseProvider.addAudioMediaData(map).then((value){
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
    _chief_enginear.clear();
    _director.clear();
    _regional_station.clear();
    _sales_contact.clear();
    _whats_app.clear();
    _hotline_number.clear();
    _business_type.clear();
    _channelName.clear();
  }

}
