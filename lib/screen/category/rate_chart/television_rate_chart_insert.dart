import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TelevisionRateChart extends StatefulWidget {
  const TelevisionRateChart({Key? key}) : super(key: key);

  @override
  _TelevisionRateChartState createState() => _TelevisionRateChartState();
}

class _TelevisionRateChartState extends State<TelevisionRateChart> {
  TextEditingController _companyName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _fax = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _web = TextEditingController();
  TextEditingController _regionalSalesOffice = TextEditingController();
  TextEditingController _effectiveForm = TextEditingController();
  TextEditingController _rateFor = TextEditingController();
  TextEditingController _programType = TextEditingController();
  TextEditingController __programDuration = TextEditingController();
  TextEditingController _addDuration = TextEditingController();
  TextEditingController _generalRate = TextEditingController();
  TextEditingController _fixedPosition = TextEditingController();
  TextEditingController _popUp = TextEditingController();
  TextEditingController _topDown = TextEditingController();
  TextEditingController _LShape = TextEditingController();
  TextEditingController _beforeNews = TextEditingController();
  TextEditingController _midBreakProgram = TextEditingController();
  TextEditingController _peakTime = TextEditingController();
  TextEditingController _offPeack = TextEditingController();
  TextEditingController _day = TextEditingController();
  TextEditingController _spacialNote = TextEditingController();
  TextEditingController _newsTime = TextEditingController();
  TextEditingController _cmTime = TextEditingController();
  TextEditingController _ordinery = TextEditingController();
  TextEditingController _banglaFilm = TextEditingController();
  TextEditingController _namingBranding = TextEditingController();
  TextEditingController _tarifBrand = TextEditingController();
  TextEditingController _extraCommercialTime = TextEditingController();

  List staatus = ['Public', 'Private'];
  String statusValue = "Public";

  List channels = Variables().getTVChannelList();
  String channelValue = 'Bangladesh Television';

  bool _isLoading = false;
  String? uuid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    return Container(
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                  ),
                  // width: size.width * .2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: size.width > 1200 ? size.width * .4 : size.width * .5,
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
                            'Regional Salse Office'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Effective From'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Rate For'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Program Type'),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width > 1200 ? size.width * .4 : size.width * .5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _textFormBuilderForTelevisionChart('General Rate'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Fixed Position'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Before News'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart(
                            'Mid Break in program / Drama'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Off Peak Time'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart(
                            'Peak Time / Spot Time'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Day'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Spacial Note'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('PopUp'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Program Duration'),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width > 1200 ? size.width * .4 : size.width * .5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _textFormBuilderForTelevisionChart('CM Time'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Ordinery'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Film'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Naming & Branding'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Tarif-Brand'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Top Down'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('L Shap'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart(
                            'Extra Comercial Time'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('Add Duration'),
                        SizedBox(height: 20),
                        _textFormBuilderForTelevisionChart('News Time'),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                    uploadData(dataProvider, firebaseProvider);
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
    );
  }

  Future<void> uploadData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    _submitData(
      dataProvider,
      firebaseProvider,
    );
  }

  Future<void> _submitData(
      DataProvider dataProvider, FirebaseProvider firebaseProvider) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    if (statusValue.isNotEmpty) {
      setState(() => _isLoading = true);
      Map<String, String> map = {
        'channelName': channelValue,
        'companyName': _companyName.text,
        'address': _address.text,
        'phone': _phone.text,
        'fax': _fax.text,
        'email': _email.text,
        'web': _web.text,
        'regionalSalesOffice': _regionalSalesOffice.text,
        'effectiveForm': _effectiveForm.text,
        'rateFor': _rateFor.text,
        'ProgramType': _programType.text,
        'programDuration': __programDuration.text,
        'addDuration': _addDuration.text,
        'generalRate': _generalRate.text,
        'fixedPosition': _fixedPosition.text,
        'beforeNews': _beforeNews.text,
        'midBreakInProgram': _midBreakProgram.text,
        'offPeakTime': _offPeack.text,
        'peakTime': _peakTime.text,
        'day': _day.text,
        'spacialNote': _spacialNote.text,
        'newsTime': _newsTime.text,
        'popUp': _popUp.text,
        'CMTime': _cmTime.text,
        'extraCommercialTime': _extraCommercialTime.text,
        'ordinery': _ordinery.text,
        'banglaFilm': _banglaFilm.text,
        'tarifBrand': _tarifBrand.text,
        'namingBranding': _namingBranding.text,
        'topDown': _topDown.text,
        'LShap': _LShape.text,
        'status': statusValue.toLowerCase(),
        'date': dateData,
        'id': uuid!,
      };
      await firebaseProvider.addTelevisionMediaChartData(map).then((value) {
        if (value) {
          setState(() => _isLoading = false);
          showToast('Success');
          _emptyFildCreator();
        } else {
          setState(() => _isLoading = false);
          showToast('Failed');
        }
      });
    } else
      showToast("Select Status");
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
                              : hint == 'Regional Salse Office'
                                  ? _regionalSalesOffice
                                  : hint == 'Effective From'
                                      ? _effectiveForm
                                      : hint == 'Rate For'
                                          ? _rateFor
                                          : hint == 'Program Type'
                                              ? _programType
                                              : hint == 'Program Duration'
                                                  ? __programDuration
                                                  : hint == 'Add Duration'
                                                      ? _addDuration
                                                      : hint == 'General Rate'
                                                          ? _generalRate
                                                          : hint ==
                                                                  'Fixed Position'
                                                              ? _fixedPosition
                                                              : hint ==
                                                                      'Before News'
                                                                  ? _beforeNews
                                                                  : hint ==
                                                                          'Mid Break in program / Drama'
                                                                      ? _midBreakProgram
                                                                      : hint ==
                                                                              'Off Peak Time'
                                                                          ? _offPeack
                                                                          : hint == 'Peak Time / Spot Time'
                                                                              ? _peakTime
                                                                              : hint == 'Day'
                                                                                  ? _day
                                                                                  : hint == 'Spacial Note'
                                                                                      ? _spacialNote
                                                                                      : hint == 'News Time'
                                                                                          ? _newsTime
                                                                                          : hint == 'PopUp'
                                                                                              ? _popUp
                                                                                              : hint == 'CM Time'
                                                                                                  ? _cmTime
                                                                                                  : hint == 'Ordinery'
                                                                                                      ? _ordinery
                                                                                                      : hint == 'Film'
                                                                                                          ? _banglaFilm
                                                                                                          : hint == 'Naming & Branding'
                                                                                                              ? _namingBranding
                                                                                                              : hint == 'Tarif-Brand'
                                                                                                                  ? _tarifBrand
                                                                                                                  : hint == 'Extra Comercial Time'
                                                                                                                      ? _extraCommercialTime
                                                                                                                      : hint == 'Top Down'
                                                                                                                          ? _topDown
                                                                                                                          : _LShape,
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
    _regionalSalesOffice.clear();
    _effectiveForm.clear();
    _rateFor.clear();
    _programType.clear();
    __programDuration.clear();
    _addDuration.clear();
    _generalRate.clear();
    _fixedPosition.clear();
    _beforeNews.clear();
    _midBreakProgram.clear();
    _offPeack.clear();
    _peakTime.clear();
    _day.clear();
    _spacialNote.clear();
    _newsTime.clear();
    _popUp.clear();
    _cmTime.clear();
    _extraCommercialTime.clear();
    _ordinery.clear();
    _banglaFilm.clear();
    _namingBranding.clear();
    _tarifBrand.clear();
    _topDown.clear();
    _LShape.clear();
  }
}

// class TelevisionRateChartWidget{

// Widget TelevisionRateChart(){

//   return Container(
//     child: Column(
//       children: <Widget>[
//         SizedBox(
//           height: 20,
//         ),
//         _textFormBuilderForTelevisionChart('Address'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('Phone'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('Fax'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('Email'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('Web'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('Peak Time'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('Duration'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('General Rate'),
//         SizedBox(height: 20,),
//         _textFormBuilderForTelevisionChart('With 50% Surcharge for any Fixed Position'),
//         SizedBox(
//           height: 20,
//         ),
//         _textFormBuilderForTelevisionChart('With 80% Surcharge for any Fixed Position'),
//         SizedBox(
//           height: 20,
//         ),
//         _textFormBuilderForTelevisionChart('With 140% Surcharge for any Fixed Position'),
//         SizedBox(
//           height: 20,
//         ),
//         _textFormBuilderForTelevisionChart('With 100% Surcharge for any Fixed Position'),
//         SizedBox(
//           height: 20,
//         ),
//         _textFormBuilderForTelevisionChart('With 200% Surcharge for any Fixed Position'),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     )
//   );
// }

// Widget _textFormBuilderForTelevisionChart(String hint) {
//   return TextFormField(
//     controller: hint == 'Address'
//         ? _business_type
//         : hint == 'Phone'
//         ? _business_type
//         : hint == 'Fax'
//         ? _business_type
//         : hint == 'E mail'
//         ? _business_type
//         : hint == 'Web'
//         ? _business_type
//         : hint == 'Peak Time'
//         ? _camera
//         : hint == 'Duration'
//         ? _unit
//         : hint == 'General Rate'
//         ? _mac_pro
//         : hint == 'With 50% Surcharge for any Fixed Position'
//         ? _branch_office
//         : hint == 'With 80% Surcharge for any Fixed Position'
//         ? _programs
//         : hint == 'With 140% Surcharge for any Fixed Position'
//         ? _training
//         : hint == 'With 100% Surcharge for any Fixed Position'
//         ? _shooting
//         : hint == 'With 200% Surcharge for any Fixed Position'
//         ? _location
//         : _company_name,
//     decoration: InputDecoration(hintText: hint),
//   );
// }

// Widget TelevisionRateChartforSponsorship(){

//   return Container(
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           _textFormBuilderForTelevisionChartforSponsorship('Program Type'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Program Duration'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Advertisement Time'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Peak Time'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Peak Time Extra Per Min'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Off Peak Time'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Off Peak Time Extra Per Min'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforSponsorship('Program Type'),
//           SizedBox(height: 20,),
//         ],
//       )
//   );
// }
// Widget _textFormBuilderForTelevisionChartforSponsorship(String hint) {
//   return TextFormField(
//     controller: hint == 'Address'
//         ? _business_type
//         : hint == 'Phone'
//         ? _business_type
//         : hint == 'Fax'
//         ? _business_type
//         : hint == 'E mail'
//         ? _business_type
//         : hint == 'Web'
//         ? _business_type
//         : hint == 'Peak Time'
//         ? _camera
//         : hint == 'Duration'
//         ? _unit
//         : hint == 'General Rate'
//         ? _mac_pro
//         : hint == 'With 50% Surcharge for any Fixed Position'
//         ? _branch_office
//         : hint == 'With 80% Surcharge for any Fixed Position'
//         ? _programs
//         : hint == 'With 140% Surcharge for any Fixed Position'
//         ? _training
//         : hint == 'With 100% Surcharge for any Fixed Position'
//         ? _shooting
//         : hint == 'With 200% Surcharge for any Fixed Position'
//         ? _location
//         : _company_name,
//     decoration: InputDecoration(hintText: hint),
//   );
// }

// Widget TelevisionRateChartforchannelI(){

//   return Container(
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           _textFormBuilderForTelevisionChartforChannelI('Position'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('10 Sec'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('20 Sec'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('30 Sec'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('40 Sec'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('50 Sec'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('60 Sec'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartforChannelI('Program Type'),
//           SizedBox(height: 20,),
//         ],
//       )
//   );
// }
// Widget _textFormBuilderForTelevisionChartforChannelI(String hint) {
//   return TextFormField(
//     controller: hint == 'Position'
//         ? _business_type
//         : hint == '10 Sec'
//         ? _business_type
//         : hint == '20 Sec'
//         ? _business_type
//         : hint == '30 Sec'
//         ? _business_type
//         : hint == '40 Sec'
//         ? _business_type
//         : hint == '50 Sec'
//         ? _camera
//         : hint == '60 Sec'
//         ? _unit
//         : hint == 'With 200% Surcharge for any Fixed Position'
//         ? _location
//         : _company_name,
//     decoration: InputDecoration(hintText: hint),
//   );
// }

//
// Widget TelevisionRateChartATN(){
//
//   return Container(
//       child: Column(
//         children: <Widget>[
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Address'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Phone'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Fax'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Email'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Web'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Spot Duration'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Normal'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Before Program'),
//           SizedBox(height: 20,),
//           _textFormBuilderForTelevisionChartATN('Middle Break in Drama'),
//           SizedBox(
//             height: 20,
//           ),
//           _textFormBuilderForTelevisionChartATN('Middle Break in Bangla Cinema'),
//           SizedBox(
//             height: 20,
//           ),
//           _textFormBuilderForTelevisionChartATN('Pop-Up in Drama / Film'),
//           SizedBox(
//             height: 20,
//           ),
//           _textFormBuilderForTelevisionChartATN('With 100% Surcharge for any Fixed Position'),
//           SizedBox(
//             height: 20,
//           ),
//           _textFormBuilderForTelevisionChartATN('With 200% Surcharge for any Fixed Position'),
//           SizedBox(
//             height: 20,
//           ),
//         ],
//       )
//   );
// }
// Widget _textFormBuilderForTelevisionChartATN(String hint) {
//   return TextFormField(
//     controller: hint == 'Address'
//         ? _business_type
//         : hint == 'Phone'
//         ? _business_type
//         : hint == 'Fax'
//         ? _business_type
//         : hint == 'E mail'
//         ? _business_type
//         : hint == 'Web'
//         ? _business_type
//         : hint == 'Peak Time'
//         ? _camera
//         : hint == 'Duration'
//         ? _unit
//         : hint == 'General Rate'
//         ? _mac_pro
//         : hint == 'With 50% Surcharge for any Fixed Position'
//         ? _branch_office
//         : hint == 'With 80% Surcharge for any Fixed Position'
//         ? _programs
//         : hint == 'With 140% Surcharge for any Fixed Position'
//         ? _training
//         : hint == 'With 100% Surcharge for any Fixed Position'
//         ? _shooting
//         : hint == 'With 200% Surcharge for any Fixed Position'
//         ? _location
//         : _company_name,
//     decoration: InputDecoration(hintText: hint),
//   );
// }
