import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UpdateAudioRateChart extends StatefulWidget {
  String? channelName;
  String? companyName;
  String? address;
  String? phone;
  String? fax;
  String? email;
  String? web;
  String? regionalOffice;
  String? effectiveForm;
  String? rateFore;
  String? RDC;
  String? branding;
  String? broadCastTime;
  String? duration;
  String? endorsement;
  String? kendroName;
  String? midBreak;
  String? newsTime;
  String? offPeakHour;
  String? peakHour;
  String? perSpot;
  String? sponsorFor;
  String? spotDuration;
  String? termsCondition;
  String? time;
  String? id;
  String? status;
  String? date;

  UpdateAudioRateChart({
    this.channelName,
    this.companyName,
    this.address,
    this.phone,
    this.fax,
    this.email,
    this.web,
    this.regionalOffice,
    this.effectiveForm,
    this.rateFore,
    this.RDC,
    this.branding,
    this.broadCastTime,
    this.duration,
    this.endorsement,
    this.kendroName,
    this.midBreak,
    this.newsTime,
    this.peakHour,
    this.offPeakHour,
    this.perSpot,
    this.sponsorFor,
    this.spotDuration,
    this.termsCondition,
    this.time,
    this.id,
    this.status,
    this.date,
  });

  @override
  _UpdateAudioRateChartState createState() => _UpdateAudioRateChartState();
}

class _UpdateAudioRateChartState extends State<UpdateAudioRateChart> {
  TextEditingController _companyName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _fax = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _web = TextEditingController();
  TextEditingController _kendroName = TextEditingController();
  TextEditingController _effectiveForm = TextEditingController();
  TextEditingController _spotDuration = TextEditingController();
  TextEditingController _perSpot = TextEditingController();
  TextEditingController __sponsorFor = TextEditingController();
  TextEditingController _newsTime = TextEditingController();
  TextEditingController _midBreak = TextEditingController();
  TextEditingController _regionalStation = TextEditingController();
  TextEditingController _duration = TextEditingController();
  TextEditingController _time = TextEditingController();
  TextEditingController _peakHour = TextEditingController();
  TextEditingController _offPeakHour = TextEditingController();
  TextEditingController _termsCondition = TextEditingController();
  TextEditingController _branding = TextEditingController();
  TextEditingController _broadCastTime = TextEditingController();
  TextEditingController _rateFor = TextEditingController();
  TextEditingController _RDC = TextEditingController();
  TextEditingController _endorsement = TextEditingController();

  List staatus = ['Public', 'Private'];
  String statusValue = "Public";

  List channels = Variables().getaudioChannelList();
  String channelValue = 'Bangladesh Betar';

  bool _isLoading = false;
  String? uuid;

  int counter = 0;
  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    // _name.text = dataProvider.importentEmergencyModel.name!;
    // _address.text = dataProvider.importentEmergencyModel.address!;
    // _PABX.text = dataProvider.importentEmergencyModel.pabx!;
    // _email.text = dataProvider.importentEmergencyModel.email!;
    // _web.text = dataProvider.importentEmergencyModel.web!;
    // _fax.text = dataProvider.importentEmergencyModel.fax!;
    // _phonet_t.text = dataProvider.importentEmergencyModel.phone!;
    // _mobile.text = dataProvider.importentEmergencyModel.mobile!;
    // _contact.text = dataProvider.importentEmergencyModel.contact!;
    // _facebook.text = dataProvider.importentEmergencyModel.facebook!;
    // _corporateOffice.text =
    //     dataProvider.importentEmergencyModel.corporateOffice!;
    // _headOffice.text = dataProvider.importentEmergencyModel.headOffice!;
    // _position.text = dataProvider.importentEmergencyModel.position!;
    // _businessType.text = dataProvider.importentEmergencyModel.businessType!;
  }

  @override
  Widget build(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    Size size = MediaQuery.of(context).size;

    if (counter == 0) {
      customInit(dataProvider);
    }

    return Container(
      height: size.height,
      width: size.width * .8,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 2,
              width: size.width * .8,
              color: Colors.blueGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                      ),
                      // width: size.width * .2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Channel Name : ",
                              style: TextStyle(fontSize: size.height * .025),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: channelValue,
                                elevation: 0,
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.black),
                                items: channels.map((itemValue) {
                                  return DropdownMenuItem<String>(
                                    value: itemValue,
                                    child: Text(itemValue),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    channelValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                      ),
                      // width: size.width * .2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Status : ",
                              style: TextStyle(fontSize: size.height * .025),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: statusValue,
                                elevation: 0,
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.black),
                                items: staatus.map((itemValue) {
                                  return DropdownMenuItem<String>(
                                    value: itemValue,
                                    child: Text(itemValue),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    statusValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width:
                          size.width > 1200 ? size.width * .4 : size.width * .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _textFormBuilderForTelevisionChart('Company Name'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Address'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Phone'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Fax'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Email'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Web'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart(
                                'Regional Station'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart(
                                'Effective From'),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width:
                          size.width > 1200 ? size.width * .4 : size.width * .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _textFormBuilderForTelevisionChart('Kendro Name'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart(
                                'Advertise Duration'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Per Spot'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Sponsor For'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('News Time'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Mid Break'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Duration'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Time'),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width:
                          size.width > 1200 ? size.width * .4 : size.width * .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _textFormBuilderForTelevisionChart('Peak Hour'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Off Peak Hour'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Rate For'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart(
                                'Terms & Condition'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Branding'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart(
                                'BroadCast Time'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('RDC'),
                            SizedBox(height: 20),
                            _textFormBuilderForTelevisionChart('Endorsement'),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? Container(
                    child: Column(
                    children: [
                      fadingCircle,
                    ],
                  ))
                : ElevatedButton(
                    onPressed: () {
                      uuid = Uuid().v1();
                      // uploadData(dataProvider, firebaseProvider);
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height * .04,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _textFormBuilderForTelevisionChart(String hint) {
    return TextFormField(
      controller: hint == 'Company Name'
          ? _companyName
          : hint == 'Address'
              ? _address
              : hint == 'Phone'
                  ? _phone
                  : hint == 'Fax'
                      ? _fax
                      : hint == 'Email'
                          ? _email
                          : hint == 'Web'
                              ? _web
                              : hint == 'Regional Station'
                                  ? _regionalStation
                                  : hint == 'Effective From'
                                      ? _effectiveForm
                                      : hint == 'Kendro Name'
                                          ? _kendroName
                                          : hint == 'Advertise Duration'
                                              ? _spotDuration
                                              : hint == 'Per Spot'
                                                  ? _perSpot
                                                  : hint == 'Sponsor For'
                                                      ? __sponsorFor
                                                      : hint == 'News Time'
                                                          ? _newsTime
                                                          : hint == 'Mid Break'
                                                              ? _midBreak
                                                              : hint == 'Time'
                                                                  ? _time
                                                                  : hint ==
                                                                          'Duration'
                                                                      ? _duration
                                                                      : hint ==
                                                                              'Peak Hour'
                                                                          ? _peakHour
                                                                          : hint == 'Off Peak Hour'
                                                                              ? _offPeakHour
                                                                              : hint == 'Rate For'
                                                                                  ? _rateFor
                                                                                  : hint == 'Branding'
                                                                                      ? _branding
                                                                                      : hint == 'Terms & Condition'
                                                                                          ? _termsCondition
                                                                                          : hint == 'BroadCast Time'
                                                                                              ? _broadCastTime
                                                                                              : hint == 'RDC'
                                                                                                  ? _RDC
                                                                                                  : _endorsement,
      decoration: InputDecoration(
        hintText: hint,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide: new BorderSide(width: 1),
        ),
      ),
      maxLines: 2,
    );
  }

  _emptyFildCreator() {
    _companyName.clear();
    _address.clear();
    _phone.clear();
    _email.clear();
    _web.clear();
    _fax.clear();
    _regionalStation.clear();
    _effectiveForm.clear();
    _rateFor.clear();
    _kendroName.clear();
    _spotDuration.clear();
    _perSpot.clear();
    __sponsorFor.clear();
    _newsTime.clear();
    _midBreak.clear();
    _duration.clear();
    _time.clear();
    _peakHour.clear();
    _offPeakHour.clear();
    _termsCondition.clear();
    _branding.clear();
    _broadCastTime.clear();
    _RDC.clear();
    _endorsement.clear();
  }
}