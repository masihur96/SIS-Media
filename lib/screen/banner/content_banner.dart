import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:provider/provider.dart';

class ContentBannerScreen extends StatefulWidget {
  const ContentBannerScreen({Key? key}) : super(key: key);

  @override
  _ContentBannerScreenState createState() => _ContentBannerScreenState();
}

class _ContentBannerScreenState extends State<ContentBannerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    return Container(
      color: Color(0xffedf7fd),
      width: dataProvider.pageWidth(size),
      height: size.height,
      child: Center(child: Text('Content Banner Screen')),
    );
  }
}
