import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/audio_rate_chart_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AllDataAudioRateChart extends StatefulWidget {
  const AllDataAudioRateChart({Key? key}) : super(key: key);

  @override
  _AllDataAudioRateChartState createState() => _AllDataAudioRateChartState();
}

class _AllDataAudioRateChartState extends State<AllDataAudioRateChart> {
  bool _isLoading = false;

  List channels = Variables().getaudioChannelList();
  String channelValue = 'Bangladesh Betar';

  List<AudioRateChartModel> _subList = [];
  List<AudioRateChartModel> _filteredList = [];

  _filterChannelList(String searchItem) {
    setState(() {
      _filteredList = _subList
          .where((element) => (element.channelName!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  int counter = 0;
  customInit(FatchDataHelper fatchDataHelper) async {
    setState(() {
      counter++;
    });
    if (fatchDataHelper.audioRateChartList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchAudioRateChartData().then((value) {
        setState(() {
          _subList = fatchDataHelper.audioRateChartList;
          _filteredList = _subList;
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.audioRateChartList;
        _filteredList = _subList;
      });
    }
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchAudioRateChartData().then((value) {
      setState(() {
        _subList = fatchDataHelper.audioRateChartList;
        _filteredList = _subList;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    final FatchDataHelper fatchDataHelper =
        Provider.of<FatchDataHelper>(context);

    if (counter == 0) {
      customInit(fatchDataHelper);
    }
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                  ),
                  // width: size.width * .2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                              _filterChannelList(channelValue);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                GestureDetector(
                    onTap: () {
                      getData(fatchDataHelper);
                    },
                    child: Icon(Icons.refresh_outlined)),
              ],
            ),
            _isLoading
                ? Container(
                    child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .4,
                      ),
                      fadingCircle,
                    ],
                  ))
                : Expanded(
                    child: SizedBox(
                      height: 500.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _filteredList.length,
                        itemBuilder: (context, index) {
                          return _listItem(index, size, firebaseProvider,
                              fatchDataHelper, dataProvider);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _listItem(index, Size size, FirebaseProvider firebaseProvider,
      FatchDataHelper fatchDataHelper, DataProvider dataProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _filteredList[index].channelName!.isEmpty
                      ? Container()
                      : Text(
                          _filteredList[index].channelName!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                  _filteredList[index].companyName!.isEmpty
                      ? Container()
                      : Text(_filteredList[index].companyName!,
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].address!.isEmpty
                      ? Container()
                      : Text(
                          'Address: ${_filteredList[index].address}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _filteredList[index].phone!.isEmpty
                      ? Container()
                      : Text('Phone: ${_filteredList[index].phone}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].fax!.isEmpty
                      ? Container()
                      : Text('Fax: ${_filteredList[index].fax}',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                  _filteredList[index].email!.isEmpty
                      ? Container()
                      : Text('E-mail: ${_filteredList[index].email}',
                          style: TextStyle(fontSize: 12)),
                  _filteredList[index].web!.isEmpty
                      ? Container()
                      : Text(
                          'Web: ${_filteredList[index].web}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].regionalOffice!.isEmpty
                      ? Container()
                      : Text(
                          'Regional Office: ${_filteredList[index].regionalOffice}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].effectiveForm!.isEmpty
                      ? Container()
                      : Text(
                          'Effective Form: ${_filteredList[index].effectiveForm}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].rateFore!.isEmpty
                      ? Container()
                      : Text(
                          'Rate For: ${_filteredList[index].rateFore}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].kendroName!.isEmpty
                      ? Container()
                      : Text(
                          'Kendro Name: ${_filteredList[index].kendroName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].spotDuration!.isEmpty
                      ? Container()
                      : Text(
                          'Spot Duration: ${_filteredList[index].spotDuration}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].perSpot!.isEmpty
                      ? Container()
                      : Text(
                          'Per Spot: ${_filteredList[index].perSpot}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].sponsorFor!.isEmpty
                      ? Container()
                      : Text(
                          'Sponsore For: ${_filteredList[index].sponsorFor}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].newsTime!.isEmpty
                      ? Container()
                      : Text(
                          'News Time: ${_filteredList[index].newsTime}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].midBreak!.isEmpty
                      ? Container()
                      : Text(
                          'Mid Break: ${_filteredList[index].midBreak}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].duration!.isEmpty
                      ? Container()
                      : Text(
                          'Duration: ${_filteredList[index].duration}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].time!.isEmpty
                      ? Container()
                      : Text(
                          'Time: ${_filteredList[index].time}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].peakHour!.isEmpty
                      ? Container()
                      : Text(
                          'Peak Time: ${_filteredList[index].peakHour}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].offPeakHour!.isEmpty
                      ? Container()
                      : Text(
                          'Off Peak Hour : ${_filteredList[index].offPeakHour}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].termsCondition!.isEmpty
                      ? Container()
                      : Text(
                          'Terms & Condition: ${_filteredList[index].termsCondition}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].branding!.isEmpty
                      ? Container()
                      : Text(
                          'Branding: ${_filteredList[index].branding}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].broadCastTime!.isEmpty
                      ? Container()
                      : Text(
                          'BroadCast Time: ${_filteredList[index].broadCastTime}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].RDC!.isEmpty
                      ? Container()
                      : Text(
                          'RDC: ${_filteredList[index].RDC}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _filteredList[index].endorsement!.isEmpty
                      ? Container()
                      : Text(
                          'Endorsement: ${_filteredList[index].endorsement}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].status!.isEmpty
                      ? Container()
                      : Text(
                          'Status: ${_filteredList[index].status}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].date!.isEmpty
                      ? Container()
                      : Text(
                          'Date: ${_filteredList[index].date}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
            Container(
              width: size.width * .1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Update Audio Media Chart";

                      dataProvider.audioRateChartModel.id =
                          _filteredList[index].id;
                      dataProvider.audioRateChartModel.companyName =
                          _filteredList[index].companyName;
                      dataProvider.audioRateChartModel.address =
                          _filteredList[index].address;
                      dataProvider.audioRateChartModel.phone =
                          _filteredList[index].phone;
                      dataProvider.audioRateChartModel.fax =
                          _filteredList[index].fax;
                      dataProvider.audioRateChartModel.email =
                          _filteredList[index].email;
                      dataProvider.audioRateChartModel.web =
                          _filteredList[index].web;
                      dataProvider.audioRateChartModel.regionalOffice =
                          _filteredList[index].regionalOffice;
                      dataProvider.audioRateChartModel.effectiveForm =
                          _filteredList[index].effectiveForm;
                      dataProvider.audioRateChartModel.rateFore =
                          _filteredList[index].rateFore;
                      dataProvider.audioRateChartModel.kendroName =
                          _filteredList[index].kendroName;
                      dataProvider.audioRateChartModel.spotDuration =
                          _filteredList[index].spotDuration;
                      dataProvider.audioRateChartModel.perSpot =
                          _filteredList[index].perSpot;
                      dataProvider.audioRateChartModel.sponsorFor =
                          _filteredList[index].sponsorFor;
                      dataProvider.audioRateChartModel.newsTime =
                          _filteredList[index].newsTime;
                      dataProvider.audioRateChartModel.midBreak =
                          _filteredList[index].midBreak;
                      dataProvider.audioRateChartModel.duration =
                          _filteredList[index].duration;
                      dataProvider.audioRateChartModel.time =
                          _filteredList[index].time;
                      dataProvider.audioRateChartModel.peakHour =
                          _filteredList[index].peakHour;
                      dataProvider.audioRateChartModel.offPeakHour =
                          _filteredList[index].offPeakHour;
                      dataProvider.audioRateChartModel.termsCondition =
                          _filteredList[index].termsCondition;
                      dataProvider.audioRateChartModel.branding =
                          _filteredList[index].branding;
                      dataProvider.audioRateChartModel.broadCastTime =
                          _filteredList[index].broadCastTime;
                      dataProvider.audioRateChartModel.RDC =
                          _filteredList[index].RDC;
                      dataProvider.audioRateChartModel.endorsement =
                          _filteredList[index].endorsement;
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Confirmation Alert",
                        desc: "Are you confirm to delete this item ?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          DialogButton(
                            child: Text(
                              "OK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() => _isLoading = true);
                              firebaseProvider
                                  .deleteAudioRateChartData(
                                      _filteredList[index].id!, context)
                                  .then((value) async {
                                if (value == true) {
                                  setState(() => _isLoading = false);
                                  getData(fatchDataHelper);
                                  Navigator.pop(context);
                                  showToast('Data deleted successful');
                                } else {
                                  setState(() => _isLoading = false);
                                  Navigator.pop(context);
                                  showToast('Data delete unsuccessful');
                                }
                              });
                            },
                          )
                        ],
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
