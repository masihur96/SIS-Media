import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:provider/provider.dart';

class IndexBannerScreen extends StatefulWidget {
  const IndexBannerScreen({Key? key}) : super(key: key);

  @override
  _IndexBannerScreenState createState() => _IndexBannerScreenState();
}

class _IndexBannerScreenState extends State<IndexBannerScreen> {
  List staatus = ['Public', 'Private'];
  String statusValue = "Public";
  String? uuid;

  final _ktabs = <Tab>[
    const Tab(
      text: 'All Banner',
    ),
    const Tab(
      text: 'Insert Banner',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    return Container(
        color: Color(0xffedf7fd),
        width: dataProvider.pageWidth(size),
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * .913,
                child: DefaultTabController(
                  length: _ktabs.length,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: AppBar(
                        elevation: 0.0,
                        backgroundColor: Colors.blueGrey,
                        bottom: TabBar(
                          labelStyle: TextStyle(
                            fontSize: size.height * .03,
                          ),
                          tabs: _ktabs,
                          indicatorColor: Colors.white,
                          unselectedLabelColor: Colors.white60,
                          labelColor: Colors.white,
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      showImageUI(),
                      addImageUI(size),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showImageUI() {
    return Container(child: Center(child: Text("Show Index Image")));
  }

  addImageUI(Size size) {
    return Center(
      child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * .35,
                width: size.width * .35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey),
                ),
                // width: size.width * .2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Status : ",
                        style: TextStyle(fontSize: size.height * .025),
                      ),
                      DropdownButtonHideUnderline(
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {}, child: Text('Picked Banner')),
                    SizedBox(
                      width: size.width * .05,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: Text('Upload Banner')),
                  ],
                ),
              ),
              Center(child: Text("Add Index Image")),
            ],
          )),
    );
  }
}
