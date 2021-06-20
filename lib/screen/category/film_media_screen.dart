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
import 'update_screen/update_data_page.dart';
import '../../widgets/notificastion.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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


  final _ktabs = <Tab>[
    const Tab(text: 'All Data'),
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

  FatchDataHelper _databaseHelper = FatchDataHelper();

   List<FilmMediaModel> _dataList  = [];
   List<FilmMediaModel> _dataListForDisplay = [];
   List<FilmMediaModel> _dataListForDropDisplay = [];

   @override
  void initState() {
    super.initState();

    setState(() {
      _dataListForDisplay = _dataList;
      _dataListForDropDisplay = _dataList;
      _isLoading=true;

      if(_isLoading=true){
        Center(
          child: Container(
              child: fadingCircle),
        );
      }
    });
    _getDataFromDatabase();

  }

  List films = Variables().getFilmMediaList();

  String? uuid ;

  final myController = TextEditingController();

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
                          labelStyle:TextStyle(fontSize: size.height*.03,),
                          tabs: _ktabs,
                          indicatorColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          labelColor: Colors.black,
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      _allFilmUI(size, dataProvider,context,firebaseProvider),
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
      FirebaseProvider firebaseProvider
  ) =>
      Container(
        padding: const EdgeInsets.all(10.0),
        height: size.height,
        width: size.width,
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
                    width: size.width * .3,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          hintText: "Please Search your Query",
                          prefixIcon: Icon(Icons.search_outlined),
                          enabledBorder: InputBorder.none
                      ),
                   onChanged: (text){
                        text = text.toLowerCase();
                       setState((){

                         _dataListForDropDisplay = _dataList.where((element) {
                             var noteTitle = element.name.toLowerCase();
                               return noteTitle.contains(text)?noteTitle.contains(text):noteTitle.contains("noteTitle");
                           }).toList();
                       });
                       },
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
                itemCount: _dataListForDisplay.length,
                itemBuilder: (context, index){
                  return _listItem(index,size,firebaseProvider);
                },
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
        child: myController.text.isEmpty? Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: size.height*.15,
                  height: size.height*.16,
                  child: _dataListForDisplay[index].image.isEmpty? Icon(Icons.photo,size: size.height*.16,color: Colors.grey,):Image.network(_dataListForDisplay[index].image,fit: BoxFit.fill)
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
                    _dataListForDisplay[index].designation.isEmpty?Container():
                    Text('Designation: ${_dataListForDisplay[index].designation}',style: TextStyle(fontSize: 12),),
                    _dataListForDisplay[index].hallname.isEmpty?Container():
                    Text('Hall Name: ${_dataListForDisplay[index].hallname}',style: TextStyle(fontSize: 12,),),
                    // _dataList[index].id.isEmpty?Container():
                    // Text(_dataList[index].id,style: TextStyle(fontSize: 12,),),
                    _dataListForDisplay[index].status.isEmpty?Container():
                    Text('Status: ${_dataListForDisplay[index].status}',style: TextStyle(fontSize: 12,),),
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
                                firebaseProvider.deleteData(_dataListForDisplay[index].id, context).then((value){
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
        ):Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: size.height*.15,
                  height: size.height*.16,
                  child: _dataListForDropDisplay[index].image.isEmpty? Image.asset('images/atnbanglalogo.jpg',fit: BoxFit.cover):Image.network(_dataList[index].image,fit: BoxFit.cover)
              ),
              Container(
                width: size.width*.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _dataListForDropDisplay[index].name.isEmpty?Container():
                    Text(_dataListForDropDisplay[index].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                    _dataListForDropDisplay[index].address.isEmpty?Container():
                    Text('Address: ${_dataListForDropDisplay[index].address}',style: TextStyle(fontSize: 12,)),
                    _dataListForDropDisplay[index].pabx.isEmpty?Container():
                    Text('PABX: ${_dataListForDropDisplay[index].pabx}',style: TextStyle(fontSize: 12),),
                    _dataListForDropDisplay[index].email.isEmpty?Container():
                    Text('E-mail: ${_dataListForDropDisplay[index].email}',style: TextStyle(fontSize: 12,)),
                    _dataListForDropDisplay[index].web.isEmpty?Container():
                    Text('Web: ${_dataListForDropDisplay[index].web}',style: TextStyle(fontSize: 12,)),
                    _dataListForDropDisplay[index].fax.isEmpty?Container():
                    Text('Fax: ${_dataListForDropDisplay[index].fax}',style: TextStyle(fontSize: 12)),
                    _dataListForDropDisplay[index].phone.isEmpty?Container():
                    Text('Phone: ${_dataListForDropDisplay[index].phone}',style: TextStyle(fontSize: 12,),),
                    _dataListForDropDisplay[index].mobile.isEmpty?Container():
                    Text('Mobile: ${_dataListForDropDisplay[index].mobile}',style: TextStyle(fontSize: 12,),),
                    _dataListForDropDisplay[index].contact.isEmpty?Container():
                    Text('Contact: ${_dataListForDropDisplay[index].contact}',style: TextStyle(fontSize: 12,),),
                    _dataListForDropDisplay[index].facebook.isEmpty?Container():
                    Text('Facebook: ${_dataListForDropDisplay[index].facebook}',style: TextStyle(fontSize: 12,),),
                    _dataListForDropDisplay[index].designation.isEmpty?Container():
                    Text('Designation: ${_dataListForDropDisplay[index].designation}',style: TextStyle(fontSize: 12),),
                    _dataListForDropDisplay[index].hallname.isEmpty?Container():
                    Text('Hall Name: ${_dataListForDropDisplay[index].hallname}',style: TextStyle(fontSize: 12,),),
                    // _dataList[index].id.isEmpty?Container():
                    // Text(_dataList[index].id,style: TextStyle(fontSize: 12,),),
                    _dataListForDropDisplay[index].status.isEmpty?Container():
                    Text('Status: ${_dataListForDropDisplay[index].status}',style: TextStyle(fontSize: 12,),),
                    _dataListForDropDisplay[index].date.isEmpty?Container():
                    Text('Date: ${_dataListForDropDisplay[index].date}',style: TextStyle(fontSize: 12,),),
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
                                firebaseProvider.deleteData(_dataList[index].id, context).then((value){
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
      ),
    );


  }

  Widget _insetFilmUI(
    Size size,
    BuildContext context,
      DataProvider dataProvider,
      FirebaseProvider firebaseProvider,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "FILM MEDIA",
                    style: TextStyle(
                        fontSize: size.height*.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        letterSpacing: 2.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          data==null ? CircleAvatar(
                            radius: size.height*.09,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.account_box,size: size.height*.08,),
                          ): CircleAvatar(
                            radius: size.height*.09,
                            backgroundColor: Colors.white,
                             child: Image.memory(data!,fit: BoxFit.fill,),
                          ),                   
                          IconButton(
                              onPressed: () {
                                pickedImage(dataProvider);
                              },
                              icon:
                              Icon(Icons.photo_library_outlined,
                               color: Colors.grey))
                        ],
                      ),
                      Container(
                        // width: size.width * .4,
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

               ElevatedButton( onPressed: () {
                      
                       uuid = Uuid().v1();
                        setState(() {
                          data=null;
                        });           
                           showLoaderDialog(context);
                          uploadData(dataProvider, firebaseProvider);
                        },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Text(
                                  'SUBMIT',
                                  style: TextStyle(color: Colors.white, fontSize: size.height*.04,),
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
      );

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
  Future<void> uploadData(DataProvider dataProvider ,FirebaseProvider firebaseProvider)async{
 
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

          setState((){
            return Navigator.pop(context);
          });
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
  Widget commonCategoryFild(Size size) {
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
                width:  size.width>1200? size.width*.4: size.width *.5,
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

      decoration: InputDecoration(hintText: hint,  border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(5.0),
        borderSide: new BorderSide(width: 1),
      ),),
      maxLines: 2,
    );
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


showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


}

