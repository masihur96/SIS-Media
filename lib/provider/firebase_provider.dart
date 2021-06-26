import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
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
          .collection("NewMediaData")
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
          .collection("ImportentEmergency")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addTelevisionMediaChartData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("TelevisionMediaChart")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addAudioMediaChartData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("AudioMediaChart")
          .doc(map['id'])
          .set(map);

      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> updateData(Map<String, String> map, BuildContext context) async {
    try {
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

  Future<bool> updateTelevisionMediaRateChartData(
      Map<String, String> map, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('TelevisionMediaChart')
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
      await FirebaseFirestore.instance
          .collection('AudioMediaData')
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

  Future<bool> deleteFilmMediaData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('FilmMediaData')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteTelevisionData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('TelevisionMediaData')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteTelevisionRateChartData(
      String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('TelevisionMediaChart')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteAudioData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('AudioMediaData')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteAudioRateChartData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('AudioMediaChart')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deletePrintData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('PrintMediaData')
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteNewData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('NewMediaData')
          .doc(id)
          .delete();
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
}
