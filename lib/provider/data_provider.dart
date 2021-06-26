import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/model/television_rate_chart_model.dart';
import 'package:media_directory_admin/screen/banner/bottom_banner.dart';
import 'package:media_directory_admin/screen/banner/content_banner.dart';
import 'package:media_directory_admin/screen/banner/index_banner.dart';
import 'package:media_directory_admin/screen/banner/popup_banner.dart';
import 'package:media_directory_admin/screen/banner/top_banner.dart';
import 'package:media_directory_admin/screen/category/rate_chart/audio_rate_chart_alldata.dart';
import 'package:media_directory_admin/screen/category/rate_chart/television_rate_chart_alldata.dart';
import 'package:media_directory_admin/screen/category/rate_chart/update_audio_rate_chart.dart';
import 'package:media_directory_admin/screen/category/rate_chart/update_television_rate_chart.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_audio_media_data.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_film_media_page.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_importent_emergency.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_new_media.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_print_media_data.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_television_media_data.dart';
import '../screen/category/audio_media_screen.dart';
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

  FilmMediaModel _filmMediaModel = new FilmMediaModel();
  FilmMediaModel get filmMediaModel => _filmMediaModel;
  set filmMediaModel(FilmMediaModel model) {
    model = FilmMediaModel();
    _filmMediaModel = model;
    notifyListeners();
  }

  TelevisionMediaModel _televisionMediaModel = new TelevisionMediaModel();
  TelevisionMediaModel get televisionMediaModel => _televisionMediaModel;
  set televisionMediaModel(TelevisionMediaModel model) {
    model = TelevisionMediaModel();
    _televisionMediaModel = model;
    notifyListeners();
  }

  TelevisionRateChartModel _televisionRateChartModel =
      new TelevisionRateChartModel();
  TelevisionRateChartModel get televisionRateChartModel =>
      _televisionRateChartModel;
  set televisionRateChartModel(TelevisionRateChartModel model) {
    model = TelevisionRateChartModel();
    _televisionRateChartModel = model;
    notifyListeners();
  }

  AudioMediaModel _audioMediaModel = new AudioMediaModel();
  AudioMediaModel get audioMediaModel => _audioMediaModel;
  set audioMediaModel(AudioMediaModel model) {
    model = AudioMediaModel();
    _audioMediaModel = model;
    notifyListeners();
  }

  PrintMediaModel _printMediaModel = new PrintMediaModel();
  PrintMediaModel get printMediaModel => _printMediaModel;
  set printMediaModel(PrintMediaModel model) {
    model = PrintMediaModel();
    _printMediaModel = model;
    notifyListeners();
  }

  NewMediaModel _newMediaModel = new NewMediaModel();
  NewMediaModel get newMediaModel => _newMediaModel;
  set newMediaModel(NewMediaModel model) {
    model = NewMediaModel();
    _newMediaModel = model;
    notifyListeners();
  }

  ImportentEmergencyModel _importentEmergencyModel =
      new ImportentEmergencyModel();
  ImportentEmergencyModel get importentEmergencyModel =>
      _importentEmergencyModel;
  set importentEmergencyModel(ImportentEmergencyModel model) {
    model = ImportentEmergencyModel();
    _importentEmergencyModel = model;
    notifyListeners();
  }

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
    else if (subCategory == 'Update Film Media')
      return UpdateFilmMediaDataPage();
    else if (subCategory == 'Film Media Screen')
      return FilmMediaScreen();
    else if (subCategory == 'Update Television Media')
      return UpdateTelevisionData();
    else if (subCategory == 'Television Media Screen')
      return TelevisionMediaScreen();
    else if (subCategory == 'Update Audio Media')
      return UpdateAdioData();
    else if (subCategory == 'Audio Media Screen')
      return AudioMediaScreen();
    else if (subCategory == 'Update Print Media')
      return UpdatePrintMedia();
    else if (subCategory == 'Print Media Screen')
      return PrintingMedia();
    else if (subCategory == 'Update New Media')
      return UpdateNewMedia();
    else if (subCategory == 'New Media Screen')
      return NewMedia();
    else if (subCategory == 'Update Importent Media')
      return UpdateImportentEmergencyData();
    else if (subCategory == 'Important Media Screen')
      return ImportentEmergency();
    else if (subCategory == 'Update Television Media Chart')
      return UpdateTelevisionRateChart();
    else if (subCategory == 'Television Media Chart Screen')
      return AllDataTelevisionRate();
    else if (subCategory == 'Update Audio Media Chart')
      return UpdateAudioRateChart();
    else if (subCategory == 'Audio Media Chart Screen')
      return AllDataAudioRateChart();
    else if (subCategory == 'Index Banner')
      return IndexBannerScreen();
    else if (subCategory == 'Content Banner')
      return ContentBannerScreen();
    else if (subCategory == 'Top Banner')
      return TopBannerScreen();
    else if (subCategory == 'Bottom Banner')
      return BottomBannerScreen();
    else if (subCategory == 'Pop Up Banner')
      return PopUpBannerScreen();
    else
      return ImportentEmergency();
  }

  // List<FilmMediaModel> _filmMediaList=[];
  // List<FilmMediaModel> _tvMediaList=[];
  // List<FilmMediaModel> _audioMediaList=[];
  // List<FilmMediaModel> _printMediaList=[];
  // List<FilmMediaModel> _newMediaList=[];
  // List<FilmMediaModel> _importantMediaList=[];
  //
  // List<FilmMediaModel> _subCategoryList=[];
  //
  // get filmMediaList => _filmMediaList;
  // get tvMediaList => _tvMediaList;
  // get audioMediaList => _audioMediaList;
  // get printMediaList => _printMediaList;
  // get newMediaList => _newMediaList;
  // get importantMediaList => _importantMediaList;
  //
  // get subCategoryList => _subCategoryList;
  //
  //
  //
  // void getSubFilmMediaList(String category,String subCategory){
  //   _subCategoryList.clear();
  //   int i=0;
  //   if(category.toLowerCase()=='Film Media'.toLowerCase()){
  //     while(i<_filmMediaList.length){
  //       if(_filmMediaList[i].subCatagory.toLowerCase()==subCategory.toLowerCase()){
  //         _subCategoryList.add(_filmMediaList[i]);
  //       }
  //       i++;
  //     }
  //     notifyListeners();
  //     print(_subCategoryList.length);
  //   }
  // }

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
