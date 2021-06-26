import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/model/audio_rate_chart_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/model/television_rate_chart_model.dart';

class FatchDataHelper extends ChangeNotifier {
  List<FilmMediaModel> _filmMediadataList = [];
  get filmMediadataList => _filmMediadataList;

  List<TelevisionMediaModel> _televisionMediadataList = [];
  get televisionMediadataList => _televisionMediadataList;

  List<TelevisionRateChartModel> _televisionRateChartList = [];
  get televisionRateChartList => _televisionRateChartList;

  List<AudioMediaModel> _audioMediadataList = [];
  get audioMediadataList => _audioMediadataList;

  List<AudioRateChartModel> _audioRateChartList = [];
  get audioRateChartList => _audioRateChartList;

  List<PrintMediaModel> _printMediaDataList = [];
  get printMediaDataList => _printMediaDataList;

  List<NewMediaModel> _newMediadataList = [];
  get newMediadataList => _newMediadataList;

  List<ImportentEmergencyModel> _importentMediadataList = [];
  get importentMediadataList => _importentMediadataList;

  Future<List<FilmMediaModel>> fetchFilmMediaData() async {
    try {
      await FirebaseFirestore.instance
          .collection('FilmMediaData')
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

  Future<List<TelevisionMediaModel>> fetchTelevisionData() async {
    try {
      await FirebaseFirestore.instance
          .collection('TelevisionMediaData')
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

  Future<List<TelevisionRateChartModel>> fetchTelevisionRateChartData() async {
    try {
      await FirebaseFirestore.instance
          .collection('TelevisionMediaChart')
          .get()
          .then((snapshot) {
        _televisionRateChartList.clear();
        snapshot.docChanges.forEach((element) {
          TelevisionRateChartModel televisionRateChartModel =
              TelevisionRateChartModel(
                  channelName: element.doc['channelName'],
                  companyName: element.doc['companyName'],
                  address: element.doc['address'],
                  phone: element.doc['phone'],
                  fax: element.doc['fax'],
                  email: element.doc['email'],
                  web: element.doc['web'],
                  regionalSalesOffice: element.doc['regionalSalesOffice'],
                  effectiveForm: element.doc['effectiveForm'],
                  rateFor: element.doc['rateFor'],
                  programType: element.doc['ProgramType'],
                  programDuration: element.doc['programDuration'],
                  addDuration: element.doc['addDuration'],
                  generalRate: element.doc['generalRate'],
                  fixedPosition: element.doc['fixedPosition'],
                  beforeNews: element.doc['beforeNews'],
                  midBreakInProgram: element.doc['midBreakInProgram'],
                  offPeakTime: element.doc['offPeakTime'],
                  peakTime: element.doc['peakTime'],
                  day: element.doc['day'],
                  specialNote: element.doc['spacialNote'],
                  newsTime: element.doc['newsTime'],
                  popUp: element.doc['popUp'],
                  CMTime: element.doc['CMTime'],
                  extraCommercialTime: element.doc['extraCommercialTime'],
                  ordinery: element.doc['ordinery'],
                  banglaFilm: element.doc['banglaFilm'],
                  namingBranding: element.doc['namingBranding'],
                  tarifBrand: element.doc['tarifBrand'],
                  topDown: element.doc['topDown'],
                  id: element.doc['id'],
                  status: element.doc['status'],
                  date: element.doc['date'],
                  LShap: element.doc['LShap']);
          _televisionRateChartList.add(televisionRateChartModel);
        });
      });
      return televisionRateChartList;
    } catch (error) {
      return [];
    }
  }

  Future<List<AudioMediaModel>> fetchAudioData() async {
    try {
      await FirebaseFirestore.instance
          .collection('AudioMediaData')
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
              subCategory: element.doc['sub-category']);
          _audioMediadataList.add(audioMediaModel);
        });
      });
      return audioMediadataList;
    } catch (error) {
      return [];
    }
  }

  Future<List<AudioRateChartModel>> fetchAudioRateChartData() async {
    try {
      await FirebaseFirestore.instance
          .collection('AudioMediaChart')
          .get()
          .then((snapshot) {
        _audioRateChartList.clear();
        snapshot.docChanges.forEach((element) {
          AudioRateChartModel audioRateChartModel = AudioRateChartModel(
            channelName: element.doc['channelName'],
            companyName: element.doc['companyName'],
            address: element.doc['address'],
            phone: element.doc['phone'],
            fax: element.doc['fax'],
            email: element.doc['email'],
            web: element.doc['web'],
            regionalOffice: element.doc['regionalOffice'],
            effectiveForm: element.doc['effectiveForm'],
            rateFore: element.doc['rateFore'],
            kendroName: element.doc['kendroName'],
            spotDuration: element.doc['spotDuration'],
            perSpot: element.doc['perSpot'],
            sponsorFor: element.doc['sponsorFor'],
            newsTime: element.doc['newsTime'],
            midBreak: element.doc['midBreak'],
            duration: element.doc['duration'],
            time: element.doc['time'],
            peakHour: element.doc['peakHour'],
            offPeakHour: element.doc['offPeakHour'],
            termsCondition: element.doc['termsCondition'],
            branding: element.doc['branding'],
            broadCastTime: element.doc['broadCastTime'],
            RDC: element.doc['RDC'],
            endorsement: element.doc['endorsement'],
            id: element.doc['id'],
            status: element.doc['status'],
            date: element.doc['date'],
          );
          _audioRateChartList.add(audioRateChartModel);
        });
      });
      return audioRateChartList;
    } catch (error) {
      return [];
    }
  }

  Future<List<PrintMediaModel>> fetchPrintData() async {
    try {
      await FirebaseFirestore.instance
          .collection('PrintMediaData')
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
              birthDate: element.doc['dirthDate'],
              deathDate: element.doc['deathDate'],
              designation: element.doc['designation'],
              deathList: element.doc['deathList'],
              youtubeChannel: element.doc['youtuveChannel'],
              id: element.doc['id'],
              status: element.doc['status'],
              date: element.doc['date'],
              subCategory: element.doc['sub-category']);
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
                  id: element.doc['id'],
                  status: element.doc['status'],
                  date: element.doc['date'],
                  subCategory: element.doc['sub-category']);
          _importentMediadataList.add(importentEmergencyModel);
        });
      });
      return importentMediadataList;
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
