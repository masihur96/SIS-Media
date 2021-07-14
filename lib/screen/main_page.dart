import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/screen/home_page.dart';
import 'package:media_directory_admin/screen/side_bar.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: size.width < 1200 ? true : false,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: size.height * .06,
                        width: size.height * .06,
                        child: Image.asset(
                          'images/book.png',
                          color: Colors.white,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      width: size.height * .02,
                    ),
                    Row(
                      children: [
                        Text(
                          "WIZARD Media",
                          style: TextStyle(
                              fontSize: size.height * .025,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          "Directory",
                          style: TextStyle(
                              fontSize: size.height * .025,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    dataProvider.pageHeader(),
                    style: TextStyle(
                        fontSize: size.height * .030,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Center(
                      child: Row(
                    children: [
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: size.height * .025, color: Colors.white),
                      ),
                      SizedBox(width: size.height * .02),
                      Icon(
                        Icons.logout_outlined,
                        size: size.height * .03,
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.blueGrey),
      drawer: size.width < 1200 ? NavigationDrawer() : null,
      body: _bodyUI(size, dataProvider),
    );
  }
}

Widget _bodyUI(Size size, DataProvider dataProvider) => Row(
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
            width: size.width < 1200 ? 0.0 : size.width * .17,
            height: size.height,
            color: Colors.blueGrey,
            //color: Colors.white,
            child: ListView.builder(
              itemCount: Variables.sideBarMenuList().length,
              itemBuilder: (context, index) => EntryItemTile(
                  Variables.sideBarMenuList()[index], size, dataProvider),
            ),
          ),
        ));
  }
}
