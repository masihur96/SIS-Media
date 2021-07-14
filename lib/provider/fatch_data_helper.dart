import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';

import 'package:media_directory_admin/model/celebrity_request_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/index_banner_model.dart';
import 'package:media_directory_admin/model/management_data_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/rate_chart_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/model/user_request_model.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';

class FatchDataHelper extends ChangeNotifier {
  List<FilmMediaModel> _filmMediadataList = [];
  get filmMediadataList => _filmMediadataList;

  List<TelevisionMediaModel> _televisionMediadataList = [];
  get televisionMediadataList => _televisionMediadataList;

  List<RateChartModel> _rateChartList = [];
  get rateChartList => _rateChartList;

  List<ManagementDataModel> _managementDataList = [];
  get managementDataList => _managementDataList;

  List<AudioMediaModel> _audioMediadataList = [];
  get audioMediadataList => _audioMediadataList;

  // List<RateChartModel> _audioRateChartList = [];
  // get audioRateChartList => _audioRateChartList;

  List<PrintMediaModel> _printMediaDataList = [];
  get printMediaDataList => _printMediaDataList;

  List<NewMediaModel> _newMediadataList = [];
  get newMediadataList => _newMediadataList;

  List<ImportentEmergencyModel> _importentMediadataList = [];
  get importentMediadataList => _importentMediadataList;

  List<IndexBannerModel> _indexdataList = [];
  get indexdataList => _indexdataList;

  List<UserRequestModel> _userRequestdataList = [];
  get userRequestdataList => _userRequestdataList;

  List<CelebrityRequestModel> _celebrityRequestdataList = [];
  get celebrityRequestdataList => _celebrityRequestdataList;

  Future<List<IndexBannerModel>> fetchBannerData() async {
    try {
      await FirebaseFirestore.instance
          .collection('Banner')
          .get()
          .then((snapshot) {
        _indexdataList.clear();
        snapshot.docChanges.forEach((element) {
          IndexBannerModel indexBannerModel = IndexBannerModel(
            image: element.doc['image'],
            id: element.doc['id'],
            status: element.doc['status'],
            date: element.doc['date'],
            place: element.doc['place'],
            category: element.doc['category'],
          );
          _indexdataList.add(indexBannerModel);
        });
      });
      return indexdataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<IndexBannerModel>> fetchEditorsData() async {
    try {
      await FirebaseFirestore.instance
          .collection('EditorsView')
          .get()
          .then((snapshot) {
        _indexdataList.clear();
        snapshot.docChanges.forEach((element) {
          IndexBannerModel indexBannerModel = IndexBannerModel(
            image: element.doc['image'],
            id: element.doc['id'],
            status: element.doc['status'],
            date: element.doc['date'],
            place: element.doc['place'],
            category: element.doc['category'],
          );
          _indexdataList.add(indexBannerModel);
        });
      });
      return indexdataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<FilmMediaModel>> fetchFilmMediaData() async {
    try {
      await FirebaseFirestore.instance
          .collection('FilmMediaData')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _filmMediadataList.clear();
        snapshot.docChanges.forEach((element) {
          FilmMediaModel filmMediaModel = FilmMediaModel(
              name: element.doc['name'],
              address: element.doc['address'],
              pabx: element.doc['pabx'],
              email: element.doc['email'],
              web: element.doc['web'],
              fax: element.doc['fax'],
              phone: element.doc['phone'],
              mobile: element.doc['mobile'],
              contact: element.doc['contact'],
              facebook: element.doc['facebook'],
              designation: element.doc['designation'],
              hallname: element.doc['hallname'],
              image: element.doc['image'],
              status: element.doc['status'],
              id: element.doc['id'],
              date: element.doc['date'],
              subCategory: element.doc['sub-category']);
          _filmMediadataList.add(filmMediaModel);
        });
      });

      return filmMediadataList;
    } catch (error) {
      return [];
    }
  }

  Future<bool> updateData(Map<String, String> map, BuildContext context) async {
    try {
      filmMediadataList.clear();
      await FirebaseFirestore.instance
          .collection('FilmMediaData')
          .doc(map['id'])
          .update(map);

      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateTelevisionMediaData(
      Map<String, String> map, BuildContext context) async {
    try {
      televisionMediadataList.clear();
      await FirebaseFirestore.instance
          .collection('TelevisionMediaData')
          .doc(map['id'])
          .update(map);
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateAudioMediaData(
      Map<String, String> map, BuildContext context) async {
    try {
      audioMediadataList.clear();
      await FirebaseFirestore.instance
          .collection('AudioData')
          .doc(map['id'])
          .update(map);
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updatePrintMediaData(
      Map<String, String> map, BuildContext context) async {
    try {
      printMediaDataList.clear();
      await FirebaseFirestore.instance
          .collection('PrintMediaData')
          .doc(map['id'])
          .update(map);
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateNewMediaData(
      Map<String, String> map, BuildContext context) async {
    try {
      newMediadataList.clear();
      await FirebaseFirestore.instance
          .collection('NewMediaData')
          .doc(map['id'])
          .update(map);
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateImportentEmergencyData(
      Map<String, String> map, BuildContext context) async {
    try {
      importentMediadataList.clear();
      await FirebaseFirestore.instance
          .collection('ImportentEmergency')
          .doc(map['id'])
          .update(map);
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteImportentEmergencyData(
      String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('ImportentEmergency')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<List<TelevisionMediaModel>> fetchTelevisionData() async {
    try {
      await FirebaseFirestore.instance
          .collection('TelevisionMediaData')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _televisionMediadataList.clear();
        snapshot.docChanges.forEach((element) {
          TelevisionMediaModel televisionMediaModel = TelevisionMediaModel(
              name: element.doc['name'],
              address: element.doc['address'],
              pabx: element.doc['pabx'],
              email: element.doc['email'],
              web: element.doc['web'],
              fax: element.doc['fax'],
              phone: element.doc['phone'],
              mobile: element.doc['mobile'],
              contact: element.doc['contact'],
              facebook: element.doc['facebook'],
              image: element.doc['image'],
              businessType: element.doc['businessType'],
              camera: element.doc['camera'],
              unit1: element.doc['unit1'],
              unit2: element.doc['unit2'],
              unit3: element.doc['unit3'],
              unit4: element.doc['unit4'],
              macPro: element.doc['macPro'],
              brunchOffice: element.doc['brunchOffice'],
              programs: element.doc['programs'],
              training: element.doc['training'],
              shooting: element.doc['shooting'],
              location: element.doc['location'],
              artist: element.doc['artist'],
              representative: element.doc['representative'],
              designation: element.doc['designation'],
              companyName: element.doc['companyName'],
              regionalOffice: element.doc['regionalOffice'],
              channelName: element.doc['channelName'],
              houseName: element.doc['houseName'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date'],
              subCategory: element.doc['sub-category']);
          _televisionMediadataList.add(televisionMediaModel);
        });
      });
      return televisionMediadataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<RateChartModel>> fetchRateChartData() async {
    try {
      await FirebaseFirestore.instance
          .collection('RateChartData')
          .orderBy('channelName')
          .get()
          .then((snapshot) {
        _rateChartList.clear();
        snapshot.docChanges.forEach((element) {
          RateChartModel rateChartModel = RateChartModel(
              channelName: element.doc['channelName'],
              image: element.doc['image'],
              category: element.doc['category'],
              subCategory: element.doc['subCategory'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date']);

          _rateChartList.add(rateChartModel);
        });
      });
      return rateChartList;
    } catch (error) {
      return [];
    }
  }

  Future<List<ManagementDataModel>> fetchManagementData() async {
    try {
      await FirebaseFirestore.instance
          .collection('ManagementData')
          .orderBy('sectionName')
          .get()
          .then((snapshot) {
        _managementDataList.clear();
        snapshot.docChanges.forEach((element) {
          ManagementDataModel managementDataModel = ManagementDataModel(
              sectionName: element.doc['sectionName'],
              image: element.doc['image'],
              category: element.doc['category'],
              subCategory: element.doc['subCategory'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date']);
          _managementDataList.add(managementDataModel);
        });
      });
      return rateChartList;
    } catch (error) {
      return [];
    }
  }

  Future<List<AudioMediaModel>> fetchAudioData() async {
    try {
      await FirebaseFirestore.instance
          .collection('AudioData')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _audioMediadataList.clear();
        snapshot.docChanges.forEach((element) {
          AudioMediaModel audioMediaModel = AudioMediaModel(
              name: element.doc['name'],
              address: element.doc['address'],
              pabx: element.doc['pabx'],
              email: element.doc['email'],
              web: element.doc['web'],
              fax: element.doc['fax'],
              phone: element.doc['phone'],
              mobile: element.doc['mobile'],
              contact: element.doc['contact'],
              facebook: element.doc['facebook'],
              image: element.doc['image'],
              chiefEngineer: element.doc['chiefEngineer'],
              director: element.doc['director'],
              regionalStation: element.doc['regionalStation'],
              salesContact: element.doc['salesContact'],
              whatApp: element.doc['whatsApp'],
              hotlineNumber: element.doc['hotlineNumber'],
              businessType: element.doc['businessType'],
              channelName: element.doc['channelName'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date'],
              ddgNews: element.doc['ddgNews'],
              ddgprogram: element.doc['ddgProgram'],
              category: element.doc['category'],
              subCategory: element.doc['sub-category'],
              statusData: element.doc['statusData']);

          _audioMediadataList.add(audioMediaModel);
        });
      });
      return audioMediadataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<PrintMediaModel>> fetchPrintData() async {
    try {
      await FirebaseFirestore.instance
          .collection('PrintMediaData')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _printMediaDataList.clear();
        snapshot.docChanges.forEach((element) {
          PrintMediaModel printMediaModel = PrintMediaModel(
              name: element.doc['name'],
              address: element.doc['address'],
              pabx: element.doc['pabx'],
              email: element.doc['email'],
              web: element.doc['web'],
              fax: element.doc['fax'],
              phone: element.doc['phone'],
              mobile: element.doc['mobile'],
              contact: element.doc['contact'],
              facebook: element.doc['facebook'],
              image: element.doc['image'],
              editor: element.doc['editor'],
              businessType: element.doc['businessType'],
              director: element.doc['director'],
              position: element.doc['position'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date'],
              subCategory: element.doc['sub-category']);
          _printMediaDataList.add(printMediaModel);
        });
      });
      return printMediaDataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<NewMediaModel>> fetchNewData() async {
    try {
      await FirebaseFirestore.instance
          .collection('NewMediaData')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _newMediadataList.clear();
        snapshot.docChanges.forEach((element) {
          NewMediaModel newMediaModel = NewMediaModel(
              name: element.doc['name'],
              address: element.doc['address'],
              pabx: element.doc['pabx'],
              email: element.doc['email'],
              web: element.doc['web'],
              fax: element.doc['fax'],
              phone: element.doc['phone'],
              mobile: element.doc['mobile'],
              contact: element.doc['contact'],
              facebook: element.doc['facebook'],
              image: element.doc['image'],
              editor: element.doc['editor'],
              birthDate: element.doc['birthDate'],
              deathDate: element.doc['deathDate'],
              designation: element.doc['designation'],
              deathList: element.doc['deathList'],
              youtubeChannel: element.doc['youtuveChannel'],
              member: element.doc['member'],
              companyName: element.doc['companyName'],
              corporateOffice: element.doc['corporateOffice'],
              whatsApp: element.doc['whatsApp'],
              skype: element.doc['skype'],
              hotline: element.doc['hotline'],
              salesSupport: element.doc['salesSupport'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date'],
              subCategory: element.doc['subCategory']);
          _newMediadataList.add(newMediaModel);
        });
      });
      return _newMediadataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<ImportentEmergencyModel>> fetchImportentEmergencyData() async {
    try {
      await FirebaseFirestore.instance
          .collection('ImportentEmergency')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _importentMediadataList.clear();
        snapshot.docChanges.forEach((element) {
          ImportentEmergencyModel importentEmergencyModel =
              ImportentEmergencyModel(
                  name: element.doc['name'],
                  address: element.doc['address'],
                  pabx: element.doc['pabx'],
                  email: element.doc['email'],
                  web: element.doc['web'],
                  fax: element.doc['fax'],
                  phone: element.doc['phone'],
                  mobile: element.doc['mobile'],
                  contact: element.doc['contact'],
                  facebook: element.doc['facebook'],
                  image: element.doc['image'],
                  corporateOffice: element.doc['corporateOffice'],
                  headOffice: element.doc['headOffice'],
                  position: element.doc['position'],
                  businessType: element.doc['businessType'],
                  companyName: element.doc['companyName'],
                  branch: element.doc['branch'],
                  reservation: element.doc['reservation'],
                  marketingSales: element.doc['marketingSales'],
                  serviceName: element.doc['serviceName'],
                  mainCampus: element.doc['mainCampus'],
                  showroom: element.doc['showroom'],
                  hotline: element.doc['hotline'],
                  customerCare: element.doc['customerCare'],
                  id: element.doc['id'],
                  status: element.doc['status'],
                  date: element.doc['date'],
                  subCategory: element.doc['subCategory']);
          _importentMediadataList.add(importentEmergencyModel);
        });
      });
      return importentMediadataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<UserRequestModel>> fetchRequestData() async {
    try {
      await FirebaseFirestore.instance
          .collection('UserRequest')
          .orderBy('name')
          .get()
          .then((snapshot) {
        _userRequestdataList.clear();
        snapshot.docChanges.forEach((element) {
          UserRequestModel userRequestModel = UserRequestModel(
              name: element.doc['name'],
              id: element.doc['id'],
              category: element.doc['category'],
              request_date: element.doc['request_date'],
              sub_category: element.doc['sub_category'],
              user_address: element.doc['user_address'],
              user_email: element.doc['user_email'],
              user_name: element.doc['user_name'],
              user_phone: element.doc['user_phone']);

          _userRequestdataList.add(userRequestModel);
        });
      });
      return userRequestdataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<CelebrityRequestModel>> fetchCelebrityRequestData() async {
    try {
      await FirebaseFirestore.instance
          .collection('SubmittedInformation')
          .orderBy('request_date')
          .get()
          .then((snapshot) {
        _celebrityRequestdataList.clear();
        snapshot.docChanges.forEach((element) {
          CelebrityRequestModel celebrityRequestModel = CelebrityRequestModel(
            id: element.doc['id'],
            category: element.doc['category'],
            request_date: element.doc['request_date'],
            sub_category: element.doc['sub_category'],
            details: element.doc['details'],
          );

          _celebrityRequestdataList.add(celebrityRequestModel);
        });
      });
      return celebrityRequestdataList;
    } catch (error) {
      return [];
    }
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
