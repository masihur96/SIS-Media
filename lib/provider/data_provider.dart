import 'package:flutter/material.dart';
import 'package:media_directory_admin/screen/category/rate_chart/television_widget.dart';
import '../screen/category/audio_media_screen.dart';
import 'package:media_directory_admin/screen/dash_board.dart';
import 'package:media_directory_admin/screen/home_page.dart';
import '../screen/category/importent_emergency.dart';
import '../screen/category/new_media.dart';
import '../screen/category/printing_media.dart';
import '../screen/category/film_media_screen.dart';
import '../screen/category/television_media_screen.dart';

class DataProvider extends ChangeNotifier {

  String _category = '';
  String _subCategory = '';
  String get category => _category;
  String get subCategory => _subCategory;
//  bool get isTapped => _isTapped;

  set subCategory(String value) {
    _subCategory = value;
    notifyListeners();
  }
  set category(String value) {
    _category = value;
    notifyListeners();
  }

  double pageWidth(Size size) {
    if (size.width < 1200)
      return size.width;
    else
      return size.width * .8;
  }

  String pageHeader() {
    if (_category.isNotEmpty && _subCategory.isNotEmpty)
      return '$_category \u276D $_subCategory';
    else
      return 'Home';
  }


  Widget categoryPage() {
    if (subCategory == 'Film Media')
      return FilmMediaScreen();
    else if (subCategory == 'Television Media')
      return TelevisionMediaScreen();
    else if (subCategory == 'Audio Media')
      return AudioMediaScreen();
    else if (subCategory == 'Print Media')
      return PrintingMedia();
    else if (subCategory == 'New Media')
      return NewMedia();
    else
      return ImportentEmergency();

  }


  // Widget sidebarControl(){
  //   if(sideBarValue == 1 ) return HomePage();
  //   else return DashBoard();
  // }
// int _sideBarValue=1;
// int get sideBarValue => _sideBarValue;
// set sideBarValue(int val){
//     _sideBarValue =val;
//     notifyListeners();
//   }
//

//
// String _channelForm = '';
// String get channelForm => _channelForm;
//
// set channelForm(String value) {
//   _channelForm = value;
//   notifyListeners();
// }
//
// Widget tvChannelForm(){
//   if(channelForm == "Bangladesh Television")
//     return TelevisionRateChartWidget().TelevisionRateChartforSponsorship();
//   else if(channelForm == "Bangladesh Television"||channelForm=="Masaranga"|| channelForm == 'Channel 9'|| channelForm =='Bangla TV')
//     return TelevisionRateChartWidget().TelevisionRateChartforchannelI();
//     else
//     return TelevisionRateChartWidget().TelevisionRateChartforSponsorship();
// }

  // Widget pageBody() {
  //   if (subCategory == 'Film Media' ||
  //       subCategory == 'Television Media' ||
  //       subCategory == 'Audio Media' ||
  //       subCategory == 'Printing Media' ||
  //       subCategory == 'Importent & Emergency' ||
  //       subCategory == 'New Media')
  //     return HomePage();
  //   else
  //     return DashBoard();
  // }

}
