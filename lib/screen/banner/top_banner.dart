import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:provider/provider.dart';

class TopBannerScreen extends StatefulWidget {
  const TopBannerScreen({Key? key}) : super(key: key);

  @override
  _TopBannerScreenState createState() => _TopBannerScreenState();
}

class _TopBannerScreenState extends State<TopBannerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    return Container(
      color: Color(0xffedf7fd),
      width: dataProvider.pageWidth(size),
      height: size.height,
      child: Center(child: Text('Top Banner')),
    );
  }
}
