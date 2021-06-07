import 'package:flutter/material.dart';
class TelevisionRateChartWidget{
  TextEditingController _business_type = TextEditingController();
  TextEditingController _camera = TextEditingController();
  TextEditingController _unit = TextEditingController();
  TextEditingController _mac_pro = TextEditingController();
  TextEditingController _branch_office = TextEditingController();
  TextEditingController _programs = TextEditingController();
  TextEditingController _training = TextEditingController();
  TextEditingController _shooting = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _artist_type = TextEditingController();
  TextEditingController _representative = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _company_name = TextEditingController();


  Widget TelevisionRateChart(){

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForTelevisionChart('Address'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('Phone'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('Fax'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('Email'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('Web'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('Peak Time'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('Duration'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('General Rate'),
          SizedBox(height: 20,),
          _textFormBuilderForTelevisionChart('With 50% Surcharge for any Fixed Position'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForTelevisionChart('With 80% Surcharge for any Fixed Position'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForTelevisionChart('With 140% Surcharge for any Fixed Position'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForTelevisionChart('With 100% Surcharge for any Fixed Position'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForTelevisionChart('With 200% Surcharge for any Fixed Position'),
          SizedBox(
            height: 20,
          ),
        ],
      )
    );
  }
  Widget _textFormBuilderForTelevisionChart(String hint) {
    return TextFormField(
      controller: hint == 'Address'
          ? _business_type
          : hint == 'Phone'
          ? _business_type
          : hint == 'Fax'
          ? _business_type
          : hint == 'E mail'
          ? _business_type
          : hint == 'Web'
          ? _business_type
          : hint == 'Peak Time'
          ? _camera
          : hint == 'Duration'
          ? _unit
          : hint == 'General Rate'
          ? _mac_pro
          : hint == 'With 50% Surcharge for any Fixed Position'
          ? _branch_office
          : hint == 'With 80% Surcharge for any Fixed Position'
          ? _programs
          : hint == 'With 140% Surcharge for any Fixed Position'
          ? _training
          : hint == 'With 100% Surcharge for any Fixed Position'
          ? _shooting
          : hint == 'With 200% Surcharge for any Fixed Position'
          ? _location
          : _company_name,
      decoration: InputDecoration(hintText: hint),
    );
  }

  Widget TelevisionRateChartforSponsorship(){

    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForTelevisionChartforSponsorship('Program Type'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Program Duration'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Advertisement Time'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Peak Time'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Peak Time Extra Per Min'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Off Peak Time'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Off Peak Time Extra Per Min'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforSponsorship('Program Type'),
            SizedBox(height: 20,),
          ],
        )
    );
  }
  Widget _textFormBuilderForTelevisionChartforSponsorship(String hint) {
    return TextFormField(
      controller: hint == 'Address'
          ? _business_type
          : hint == 'Phone'
          ? _business_type
          : hint == 'Fax'
          ? _business_type
          : hint == 'E mail'
          ? _business_type
          : hint == 'Web'
          ? _business_type
          : hint == 'Peak Time'
          ? _camera
          : hint == 'Duration'
          ? _unit
          : hint == 'General Rate'
          ? _mac_pro
          : hint == 'With 50% Surcharge for any Fixed Position'
          ? _branch_office
          : hint == 'With 80% Surcharge for any Fixed Position'
          ? _programs
          : hint == 'With 140% Surcharge for any Fixed Position'
          ? _training
          : hint == 'With 100% Surcharge for any Fixed Position'
          ? _shooting
          : hint == 'With 200% Surcharge for any Fixed Position'
          ? _location
          : _company_name,
      decoration: InputDecoration(hintText: hint),
    );
  }


  Widget TelevisionRateChartforchannelI(){

    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForTelevisionChartforChannelI('Position'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('10 Sec'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('20 Sec'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('30 Sec'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('40 Sec'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('50 Sec'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('60 Sec'),
            SizedBox(height: 20,),
            _textFormBuilderForTelevisionChartforChannelI('Program Type'),
            SizedBox(height: 20,),
          ],
        )
    );
  }
  Widget _textFormBuilderForTelevisionChartforChannelI(String hint) {
    return TextFormField(
      controller: hint == 'Position'
          ? _business_type
          : hint == '10 Sec'
          ? _business_type
          : hint == '20 Sec'
          ? _business_type
          : hint == '30 Sec'
          ? _business_type
          : hint == '40 Sec'
          ? _business_type
          : hint == '50 Sec'
          ? _camera
          : hint == '60 Sec'
          ? _unit
          : hint == 'With 200% Surcharge for any Fixed Position'
          ? _location
          : _company_name,
      decoration: InputDecoration(hintText: hint),
    );
  }


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

}