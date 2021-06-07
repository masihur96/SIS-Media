import 'package:flutter/material.dart';
class AudioRateChartWidgt{
  TextEditingController _chief_enginear = TextEditingController();
  Widget bangladeshBeterRateChart() {
    return Container(
        child: Column(
          children: <Widget>[
            _textFormBuilderForAudioChart('Channel Name'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Kendro Name'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Advertise / Spot Duration'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Per Spot(Tk)'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Special Day (Per Spot Tk)'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Sponsor for Football'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Sponsor for Cricket'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Sponsor for Play'),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart("Address"),
            SizedBox(
              height: 20,
            ),
            _textFormBuilderForAudioChart('Regional Station'),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _textFormBuilderForAudioChart(String hint) {
    return TextFormField(
      controller: hint == 'Channel Name'
          ? _chief_enginear
          : hint == 'Kendro Name'
          ? _chief_enginear
          : hint == 'Web'
          ? _chief_enginear
          : hint == 'Advertise / Spot Duration'
          ? _chief_enginear
          : hint == 'Per Spot(Tk)'
          ? _chief_enginear
          : hint == 'Special Day (Per Spot Tk)'
          ? _chief_enginear
          : hint == 'Sponsor for Football'
          ? _chief_enginear
          : hint == 'Sponsor for Cricket'
          ? _chief_enginear
          : hint == 'Sponsor for Play'
          ? _chief_enginear
          : hint == 'Address'
          ? _chief_enginear
          : _chief_enginear,
      decoration: InputDecoration(hintText: hint),
    );
  }

  Widget CommonForAudioForm(){
    return Container(
      child: Column(
        children: <Widget>[
          _textFormBuilderForAudioChart('Address'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Phone'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('E-mail'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Web'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Fax'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Tearms & Condition'),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget RadioToday(){

    return Container(
      child: Column(
        children: <Widget>[
          _textFormBuilderForAudioChart('Duration'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Standerd Day'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Prime'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Super Prime'),
          SizedBox(
            height: 20,
          ),
          _textFormBuilderForAudioChart('Standerd Night'),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }


}