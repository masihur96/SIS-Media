import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:provider/provider.dart';

class BottomBannerScreen extends StatefulWidget {
  const BottomBannerScreen({Key? key}) : super(key: key);

  @override
  _BottomBannerScreenState createState() => _BottomBannerScreenState();
}

class _BottomBannerScreenState extends State<BottomBannerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    return Container(
      color: Color(0xffedf7fd),
      width: dataProvider.pageWidth(size),
      height: size.height,
      child: Center(child: Text('BottomBannerScreen')),
    );
  }
}
