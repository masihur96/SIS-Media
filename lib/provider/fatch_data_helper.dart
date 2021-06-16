import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:flutter/material.dart';


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
}