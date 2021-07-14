import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/model/management_data_model.dart';
import 'package:media_directory_admin/model/rate_chart_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/index_banner_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/screen/banner/content_banner.dart';
import 'package:media_directory_admin/screen/banner/index_banner.dart';
import 'package:media_directory_admin/screen/banner/popup_banner.dart';
import 'package:media_directory_admin/screen/banner/update_banner_data.dart';
import 'package:media_directory_admin/screen/banner/update_content_data.dart';
import 'package:media_directory_admin/screen/banner/update_popup_data.dart';
import 'package:media_directory_admin/screen/category/change_password_screen.dart';
import 'package:media_directory_admin/screen/category/managment/audio_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/important_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/print_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/television_managment_alldata.dart';
import 'package:media_directory_admin/screen/category/managment/update_television_management.dart';
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
import 'package:media_directory_admin/screen/celebrity_request.dart';
import 'package:media_directory_admin/screen/contact_info.dart';
import 'package:media_directory_admin/screen/dash_board.dart';
import 'package:media_directory_admin/screen/editors_view.dart';
import 'package:media_directory_admin/screen/request_details.dart';
import 'package:media_directory_admin/screen/set_cover_photo.dart';
import 'package:media_directory_admin/screen/set_ratechart_banner.dart';
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

  // RateChartModel _televisionRateChartModel =
  //     new RateChartModel();
  // RateChartModel get televisionRateChartModel =>
  //     _televisionRateChartModel;
  // set televisionRateChartModel(RateChartModel model) {
  //   model = RateChartModel();
  //   _televisionRateChartModel = model;
  //   notifyListeners();
  // }

  AudioMediaModel _audioMediaModel = new AudioMediaModel();
  AudioMediaModel get audioMediaModel => _audioMediaModel;
  set audioMediaModel(AudioMediaModel model) {
    model = AudioMediaModel();
    _audioMediaModel = model;
    notifyListeners();
  }

  RateChartModel _rateChartModel = new RateChartModel();
  RateChartModel get rateChartModel => _rateChartModel;
  set rateChartModel(RateChartModel model) {
    model = RateChartModel();
    _rateChartModel = model;
    notifyListeners();
  }

  ManagementDataModel _managementDataModel = new ManagementDataModel();
  ManagementDataModel get managementDataModel => _managementDataModel;
  set managementDataModel(ManagementDataModel model) {
    model = ManagementDataModel();
    _managementDataModel = model;
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

  IndexBannerModel _indexBannerModel = new IndexBannerModel();
  IndexBannerModel get indexBannerModel => _indexBannerModel;
  set indexBannerModel(IndexBannerModel model) {
    model = IndexBannerModel();
    _indexBannerModel = model;
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
      return size.width * .83;
  }

  String pageHeader() {
    if (_category.isNotEmpty && _subCategory.isNotEmpty)
      return '$_category \u276D $_subCategory';
    else
      return 'Dashboard';
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
    else if (subCategory == 'Important & Emergency')
      return ImportentEmergency();
    else if (subCategory == 'Update Film Media')
      return UpdateFilmMediaDataPage();
    else if (subCategory == 'Update Television Media')
      return UpdateTelevisionData();
    else if (subCategory == 'Update Audio Media')
      return UpdateAdioData();
    else if (subCategory == 'Update Print Media')
      return UpdatePrintMedia();
    else if (subCategory == 'Update New Media')
      return UpdateNewMedia();
    else if (subCategory == 'Update Importent Media')
      return UpdateImportentEmergencyData();
    else if (subCategory == 'Television Media Chart Screen')
      return AllDataTelevisionRate();
    else if (subCategory == 'Update Television Media Chart')
      return UpdateTelevisionRateChart();
    else if (subCategory == 'Audio Media Chart Screen')
      return AllDataAudioRateChart();
    else if (subCategory == 'Update Audio Media Chart')
      return UpdateAudioRateChart();
    else if (subCategory == 'Index Banner')
      return IndexBannerScreen();
    else if (subCategory == 'Update Index Media')
      return UpdateBannerData();
    else if (subCategory == 'Content Banner')
      return ContentBannerScreen();
    else if (subCategory == 'Update Content Data')
      return UpdateContentData();
    else if (subCategory == 'Pop Up Banner')
      return PopUpBannerScreen();
    else if (subCategory == 'Update PopUp Data')
      return UpdatePopUpData();
    else if (subCategory == 'Update Television Management')
      return UpdateTelevisionManagement();
    else if (subCategory == 'Television Management Screen')
      return TelevisionManagmentAllData();
    else if (subCategory == 'Audio Management Screen')
      return AudioManagmentAllData();
    else if (subCategory == 'Print Management Screen')
      return PrintManagmentAllData();
    else if (subCategory == 'Important Management Screen')
      return ImportantManagementAllData();
    else if (subCategory == 'User Request')
      return RequestPage();
    else if (subCategory == 'Client Request')
      return CelebrityRequest();
    else if (subCategory == 'Change Password')
      return ChangePassword();
    else if (subCategory == 'Editors View')
      return EditorsView();
    else if (subCategory == 'Contact Information')
      return ContactInfo();
    else if (subCategory == 'Set Cover Photo')
      return CoverBanner();
    else if (subCategory == 'Set Rate Chart Banner')
      return RateChartBanner();
    else if (subCategory == 'DashBoard')
      return DashBoardPage();
    else
      return DashBoardPage();
  }
}
