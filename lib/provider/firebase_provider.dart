import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/notificastion.dart';

class FirebaseProvider extends ChangeNotifier {
  Future<bool> addFilmMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("FilmMediaData")
          .doc(map['id'])
          .set(map);
      notifyListeners();
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
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addAudioMediaData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("AudioData")
          .doc(map['id'])
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addRegisteredData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("AdminPanel")
          .doc(map['id'])
          .set(map);
      notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addBannerData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("Banner")
          .doc(map['id'])
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addEditorsData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("SingleBanner")
          .doc('123456')
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addManagmentData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("ManagementData")
          .doc(map['id'])
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addInfoData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("ContactInfo")
          .doc('123456789')
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addCoverData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("SingleBanner")
          .doc('1234567')
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addRatechartBannerData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("SingleBanner")
          .doc('12345678')
          .set(map);
      notifyListeners();
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
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> addRateChartData(Map<String, String> map) async {
    try {
      await FirebaseFirestore.instance
          .collection("RateChartData")
          .doc(map['id'])
          .set(map);
      notifyListeners();
      return true;
    } catch (err) {
      showToast(err.toString());
      return false;
    }
  }

  Future<bool> updateRateChartData(
      Map<String, String> map, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('RateChartData')
          .doc(map['id'])
          .update(map);
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateManagementData(
      Map<String, String> map, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('ManagementData')
          .doc(map['id'])
          .update(map);
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateBanerData(
      Map<String, String> map, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('Banner')
          .doc(map['id'])
          .update(map);
      notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteAudioData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('AudioData').doc(id).delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteEditorsData() async {
    try {
      await FirebaseFirestore.instance
          .collection('SingleBanner')
          .doc('123456')
          .delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteCoverData() async {
    try {
      await FirebaseFirestore.instance
          .collection('SingleBanner')
          .doc('1234567')
          .delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteRateChartBannerData() async {
    try {
      await FirebaseFirestore.instance
          .collection('SingleBanner')
          .doc('12345678')
          .delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteRateChartData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('RateChartData')
          .doc(id)
          .delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteManagementData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('ManagementData')
          .doc(id)
          .delete();
      notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteBannerData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('Banner').doc(id).delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteTelevisioData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('Banner').doc(id).delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteRequestData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('UserRequest')
          .doc(id)
          .delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteCelebrityRequestData(
      String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('SubmittedInformation')
          .doc(id)
          .delete();
      notifyListeners();
      return true;
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }
}
