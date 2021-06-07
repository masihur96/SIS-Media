import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:provider/provider.dart';

class SubTitleView extends StatefulWidget {
  @override
  _SubTitleViewState createState() => _SubTitleViewState();
}

class _SubTitleViewState extends State<SubTitleView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
      // child: Card(
      //   elevation: 5,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(20))),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(20.0),
      //         child: Text(
      //           "SUB-CATEGORY",
      //           style: TextStyle(
      //               fontSize: size.height * .030, color: Colors.black),
      //         ),
      //       ),
      //       Divider(
      //         height: 1,
      //         color: Colors.grey,
      //       ),
      //       Expanded(
      //         child: SingleChildScrollView(
      //           scrollDirection: Axis.vertical,
      //           child: Column(
      //             children: <Widget>[
      //               InkWell(
      //                 onTap: () {
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=1;
      //                // UpdateDeleteDialog();
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle1(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                //   UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=2;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle2(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //                  // UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=3;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle3(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //              //     UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=4;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle4(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //             //      UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=5;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle5(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //            //       UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=6;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle6(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //             //      UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=7;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle7(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=8;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle8(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=9;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle9(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=10;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle10(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=11;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle11(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=12;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle12(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=13;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle13(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //               InkWell(
      //                 onLongPress: () {
      //               //    UpdateDeleteDialog();
      //                   dataProvider.mainValue=1;
      //                   dataProvider.subValue=14;
      //                 },
      //                 child: Container(
      //                   alignment: Alignment.topLeft,
      //                   padding: EdgeInsets.only(
      //                       left: size.width * .015, top: 10, bottom: 10),
      //                   child: Text(
      //                     dataProvider.setSubTitle14(),
      //                     textAlign: TextAlign.start,
      //                     style: TextStyle(
      //                         fontSize: size.height * .023,
      //                         color: Colors.black),
      //                   ),
      //                 ),
      //                 hoverColor: Colors.grey[100],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // void UpdateDeleteDialog() {
  //   AlertDialog alert = AlertDialog(
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //               border: Border.all(color: Colors.blueAccent, width: 2),
  //               //     color: Colors.blue,
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(15.0),
  //               child: Row(
  //                 children: <Widget>[
  //                   Text("UPDATE"),
  //                   Icon(Icons.edit),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //               border: Border.all(color: Colors.redAccent, width: 2),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(15.0),
  //               child: Row(
  //                 children: <Widget>[
  //                   Text("DELETE"),
  //                   Icon(Icons.delete),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       )
  //     ],
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
