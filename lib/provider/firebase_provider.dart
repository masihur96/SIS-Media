import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/notificastion.dart';
import 'package:uuid/uuid.dart';

class FirebaseProvider extends ChangeNotifier {


  Future<bool> addFilmMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("FilmMediaData")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addTelevisionMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("TelevisionMediaData")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addAudioMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("AudioMediaData")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addPrintMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("PrintMediaData")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addNewMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("PrintMediaData")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addImportentEmergencyData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("Importent & Emergency")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }


}
