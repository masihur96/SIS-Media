import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/screen/side_bar.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("images/atnbanglalogo.jpg"),

            ),
            SizedBox(width: 10,),
            Row(children: [
              Text("Media",style: TextStyle(fontSize: size.height*.03,fontWeight: FontWeight.w700,color: Colors.blue),),
              Text(" Directory",style: TextStyle(fontSize: size.height*.03,fontWeight: FontWeight.w700,color: Colors.redAccent),),
            ],),
            SizedBox(width: size.width*.25,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(dataProvider.pageHeader(),style: TextStyle(fontSize: size.height*.025,fontWeight: FontWeight.w700,color: Colors.grey),)),
          ],
        ),

        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 2,color: Colors.grey),
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Center(child: Text("Logout",style: TextStyle(fontSize: size.height*.025,color: Colors.black),)),
            ),
          ),
          SizedBox(width: size.width*.04,),


        ],

      ),

      drawer: size.width<1200? NavigationDrawer():null,
      body:_bodyUI(size,dataProvider) ,

    );
  }
}
Widget _bodyUI(Size size,DataProvider dataProvider)=>Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SideBar(),

    dataProvider.categoryPage(),
  ],
);
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
        margin: EdgeInsets.only(top: 56),
        child: Drawer(
          elevation: 0.0,
          child: Container(
            width: size.width<1200? 0.0: size.width*.2,
            height: size.height,
            color: Color.fromRGBO(216,211,216,1),
            //color: Colors.white,
            child:  ListView.builder(
              itemCount: Variables.sideBarMenuList().length,
              itemBuilder: (context, index)=>EntryItemTile(
                  Variables.sideBarMenuList()[index],
                  size,dataProvider),
            ),
          ),
        )
    );
  }
}