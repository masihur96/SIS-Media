import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';


class FatchDataHelper{

  Future<List<FilmMediaModel>> fetchData()async{
    List<FilmMediaModel> dataList = [];
    try{
      await FirebaseFirestore.instance.collection('FilmMediaData').get().then((snapshot){
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
          );
          dataList.add(filmMediaModel);
        });
      });
      return dataList;
    }catch(error){
      return [];
    }
  }

  Future<List<TelevisionMediaModel>> fetchTelevisionData()async{
    List<TelevisionMediaModel> dataList = [];
    try{
      await FirebaseFirestore.instance.collection('TelevisionMediaData').get().then((snapshot){
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
          );
          dataList.add(televisionMediaModel);
        });
      });
      return dataList;
    }catch(error){
      return [];
    }
  }

  Future<List<AudioMediaModel>> fetchAudioData()async{
    List<AudioMediaModel> dataList = [];
    try{
      await FirebaseFirestore.instance.collection('AudioMediaData').get().then((snapshot){
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
          );
          dataList.add(audioMediaModel);
        });
      });
      return dataList;
    }catch(error){
      return [];
    }
  }

  Future<List<NewMediaModel>> fetchNewData()async{
    List<NewMediaModel> dataList = [];
    try{
      await FirebaseFirestore.instance.collection('NewMediaData').get().then((snapshot){
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
          );
          dataList.add(newMediaModel);
        });
      });
      return dataList;
    }catch(error){
      return [];
    }
  }

  Future<List<ImportentEmergencyModel>> fetchImportentEmergencyData()async{
    List<ImportentEmergencyModel> dataList = [];
    try{
      await FirebaseFirestore.instance.collection('ImportentEmergency').get().then((snapshot){
        snapshot.docChanges.forEach((element) {
          ImportentEmergencyModel importentEmergencyModel = ImportentEmergencyModel(
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
          );
          dataList.add(importentEmergencyModel);
        });
      });
      return dataList;
    }catch(error){
      return [];
    }
  }

  Future<List<PrintMediaModel>> fetchPrintData()async{
    List<PrintMediaModel> dataList = [];
    try{
      await FirebaseFirestore.instance.collection('PrintMediaData').get().then((snapshot){
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
          );
          dataList.add(printMediaModel);
        });
      });
      return dataList;
    }catch(error){
      return [];
    }
  }

  Future<bool> deleteData(String id, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('FilmMediaData').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }
  Future<bool> deleteTelevisionData(String id, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('TelevisionMediaData').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }
  Future<bool> deleteAudioData(String id, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('AudioMediaData').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }
  Future<bool> deleteImportentEmergencyData(String id, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('ImportentEmergency').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }
  Future<bool> deleteNewData(String id, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('NewMediaData').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deletePrintData(String id, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.collection('PrintMediaData').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateData(Map<String, String> map, BuildContext context)async{
    try{
      await FirebaseFirestore.instance.
      collection('FilmMediaData').doc(map['id']).update(map);
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }
}

