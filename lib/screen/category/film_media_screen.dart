import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/update_data_page.dart';
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
  Widget commonCategoryFild(Size size) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width*.4,
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
                width: size.width*.4,
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
  String name='';

  Uint8List? data;
  String imageUrl = '';
   var file;
  String? error;
  List films = Variables().getFilmMediaList();


  FatchDataHelper _databaseHelper = FatchDataHelper();
   List<FilmMediaModel> _dataList  = [];
   @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }
  Future<void> _getDataFromDatabase()async{
    await _databaseHelper.fetchData().then((result){
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
  String? uuid ;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                      _allFilmUI(size, dataProvider,context),
                      _insetFilmUI(size, context, dataProvider,firebaseProvider),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  Widget _allFilmUI(
    Size size,
    DataProvider dataProvider,
    BuildContext context,
  ) =>
      Container(
        padding: const EdgeInsets.all(10.0),
        height: size.height,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                          Text("Please Select Your Sub-Category : ",style: TextStyle(fontSize: size.height*.025),),
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
        Expanded(
          child: SizedBox(
            height: 500.0,
            child: RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: ()async{
                await _getDataFromDatabase();
              },
              child: new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _dataList.length,
                itemBuilder: (context,index){
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
                              child: Image.network(_dataList[index].image,fit: BoxFit.cover)
                          ),
                          Container(
                            width: size.width*.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _dataList[index].name.isEmpty?Container():
                                Text(_dataList[index].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                _dataList[index].address.isEmpty?Container():
                                Text(_dataList[index].address ,style: TextStyle(fontSize: 12,)),
                                _dataList[index].pabx.isEmpty?Container():
                                Text(_dataList[index].pabx,style: TextStyle(fontSize: 12),),
                                _dataList[index].email.isEmpty?Container():
                                Text(_dataList[index].email,style: TextStyle(fontSize: 12,)),
                                _dataList[index].web.isEmpty?Container():
                                Text(_dataList[index].web,style: TextStyle(fontSize: 12,)),
                                _dataList[index].fax.isEmpty?Container():
                                Text(_dataList[index].fax,style: TextStyle(fontSize: 12)),
                                _dataList[index].phone.isEmpty?Container():
                                Text(_dataList[index].phone,style: TextStyle(fontSize: 12,),),
                                _dataList[index].mobile.isEmpty?Container():
                                Text(_dataList[index].mobile,style: TextStyle(fontSize: 12,),),
                                _dataList[index].contact.isEmpty?Container():
                                Text(_dataList[index].contact,style: TextStyle(fontSize: 12,),),
                                _dataList[index].facebook.isEmpty?Container():
                                Text(_dataList[index].facebook,style: TextStyle(fontSize: 12,),),
                                _dataList[index].designation.isEmpty?Container():
                                Text(_dataList[index].designation,style: TextStyle(fontSize: 12),),
                                _dataList[index].hallname.isEmpty?Container():
                                Text(_dataList[index].hallname,style: TextStyle(fontSize: 12,),),
                                // _dataList[index].id.isEmpty?Container():
                                // Text(_dataList[index].id,style: TextStyle(fontSize: 12,),),
                                _dataList[index].status.isEmpty?Container():
                                Text(_dataList[index].status,style: TextStyle(fontSize: 12,),),
                                _dataList[index].date.isEmpty?Container():
                                Text(_dataList[index].date,style: TextStyle(fontSize: 12,),),
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
                                        UpdateDataPage(
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
                                          designation: _dataList[index].designation,
                                          hallname: _dataList[index].hallname,
                                          image: _dataList[index].image,
                                          id: _dataList[index].id,
                                          status: _dataList[index].status,

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
                                  onPressed: () {},
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
                },

              ),
            ),
          ),
        )
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
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        height: size.height,
        child: SingleChildScrollView(
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        width: size.width * .4,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Please Select Your Sub-Category :",style: TextStyle(fontSize: size.height*.025),),
                              SizedBox(
                                width: size.height*.04,
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
                      ),
                      Container(
                        width: size.width * .2,
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
                ),
                commonCategoryFild(size),

                SizedBox(height: size.height*.04,),

                if (_isLoading) Container(
                    height: size.height*.06,
                    child: fadingCircle) else ElevatedButton( onPressed: () {
                       uuid = Uuid().v1();
                       uploadPhoto(dataProvider, firebaseProvider);
                        setState(() {
                          data=null;
                        });
                        },
                      child: Text(
                                'Submit Data',
                                style: TextStyle(color: Colors.white, fontSize: size.height*.04,),
                              )
                ),
                SizedBox(height: size.height*.04,),
              ],
            ),
          ),
        ),
      );

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

      //uploadtostprage
      // reader1.onLoadEnd.listen((event) async {
      //   // setState(() {
      //   //   image = reader.result;
      //   // });
      //   FirebaseStorage fs = FirebaseStorage.instance;
      //   var snapshot = await fs
      //       .ref()
      //       .child(dataProvider.subCategory)
      //       .child(uuid)
      //       .putBlob(file);
      //
      //   //Get DownloadLink
      //   final String downloadUrl =
      //   Uri.parse(await snapshot.ref.getDownloadURL()).toString();
      //   setState(() {
      //     imageUrl = downloadUrl;
      //   });
      //
      // });
    });
  }

  Future<void> uploadPhoto(DataProvider dataProvider ,FirebaseProvider firebaseProvider)async{
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
  Future<void> _submitData(DataProvider dataProvider,FirebaseProvider firebaseProvider,) async{
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if(statusValue.isNotEmpty){
      setState(()=> _isLoading=true);
      Map<String,String> map ={
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
        'id': uuid!,
        'image': imageUrl,
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
    _pabx.clear();
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

