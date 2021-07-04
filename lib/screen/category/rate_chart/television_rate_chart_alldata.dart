import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/television_rate_chart_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AllDataTelevisionRate extends StatefulWidget {
  const AllDataTelevisionRate({Key? key}) : super(key: key);

  @override
  _AllDataTelevisionRateState createState() => _AllDataTelevisionRateState();
}

class _AllDataTelevisionRateState extends State<AllDataTelevisionRate> {
  bool _isLoading = false;
  List channels = Variables().getTVChannelList();
  String channelValue = 'Bangladesh Television';

  List<TelevisionRateChartModel> _subList = [];
  List<TelevisionRateChartModel> _filteredList = [];

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
    if (fatchDataHelper.televisionRateChartList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      await fatchDataHelper.fetchTelevisionRateChartData().then((value) {
        setState(() {
          _subList = fatchDataHelper.televisionRateChartList;
          _filteredList = _subList;
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = fatchDataHelper.televisionRateChartList;
        _filteredList = _subList;
      });
    }
    getData(fatchDataHelper);
  }

  getData(FatchDataHelper fatchDataHelper) async {
    setState(() {
      _isLoading = true;
    });
    await fatchDataHelper.fetchTelevisionRateChartData().then((value) {
      setState(() {
        _subList = fatchDataHelper.televisionRateChartList;
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
            Container(
              height: 2,
              width: size.width * .8,
              color: Colors.blueGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    // width: size.width * .2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
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
                  InkWell(
                    onTap: () {
                      getData(fatchDataHelper);
                    },
                    child: Container(
                      // width: size.width * .1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Refresh '),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Icon(Icons.refresh_outlined),
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
                      SizedBox(
                        height: size.height * .4,
                      ),
                      fadingCircle,
                      Text(
                        'Please Wait ..........',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
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
                  _filteredList[index].regionalSalesOffice!.isEmpty
                      ? Container()
                      : Text(
                          'Regional Office: ${_filteredList[index].regionalSalesOffice}',
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
                  _filteredList[index].rateFor!.isEmpty
                      ? Container()
                      : Text(
                          'Rate For: ${_filteredList[index].rateFor}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].programType!.isEmpty
                      ? Container()
                      : Text(
                          'Program Type: ${_filteredList[index].programType}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].programDuration!.isEmpty
                      ? Container()
                      : Text(
                          'Program Duration: ${_filteredList[index].programDuration}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].addDuration!.isEmpty
                      ? Container()
                      : Text(
                          'Advertisement Time: ${_filteredList[index].addDuration}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].generalRate!.isEmpty
                      ? Container()
                      : Text(
                          'General Rate: ${_filteredList[index].generalRate}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].fixedPosition!.isEmpty
                      ? Container()
                      : Text(
                          'Fixed Position: ${_filteredList[index].fixedPosition}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].beforeNews!.isEmpty
                      ? Container()
                      : Text(
                          'Before News: ${_filteredList[index].beforeNews}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].midBreakInProgram!.isEmpty
                      ? Container()
                      : Text(
                          'Mid Break: ${_filteredList[index].midBreakInProgram}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].offPeakTime!.isEmpty
                      ? Container()
                      : Text(
                          'Off Peak Time: ${_filteredList[index].offPeakTime}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].peakTime!.isEmpty
                      ? Container()
                      : Text(
                          'Peak Time: ${_filteredList[index].peakTime}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].day!.isEmpty
                      ? Container()
                      : Text(
                          'Day : ${_filteredList[index].day}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].specialNote!.isEmpty
                      ? Container()
                      : Text(
                          'Special Note: ${_filteredList[index].specialNote}',
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
                  _filteredList[index].popUp!.isEmpty
                      ? Container()
                      : Text(
                          'Pop-Up: ${_filteredList[index].popUp}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].CMTime!.isEmpty
                      ? Container()
                      : Text(
                          'CM Time: ${_filteredList[index].CMTime}',
                          style: TextStyle(fontSize: 12),
                        ),
                  _filteredList[index].extraCommercialTime!.isEmpty
                      ? Container()
                      : Text(
                          'Commercial Time: ${_filteredList[index].extraCommercialTime}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].ordinery!.isEmpty
                      ? Container()
                      : Text(
                          'Ordinery: ${_filteredList[index].ordinery}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].banglaFilm!.isEmpty
                      ? Container()
                      : Text(
                          'Bangla Film: ${_filteredList[index].banglaFilm}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].namingBranding!.isEmpty
                      ? Container()
                      : Text(
                          'Branding: ${_filteredList[index].namingBranding}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].tarifBrand!.isEmpty
                      ? Container()
                      : Text(
                          'Tarif Brand: ${_filteredList[index].tarifBrand}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].topDown!.isEmpty
                      ? Container()
                      : Text(
                          'Top-Down: ${_filteredList[index].topDown}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  _filteredList[index].LShap!.isEmpty
                      ? Container()
                      : Text(
                          'L-Shap: ${_filteredList[index].LShap}',
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
                      dataProvider.subCategory =
                          "Update Television Media Chart";
                      dataProvider.televisionRateChartModel.id =
                          _filteredList[index].id;
                      dataProvider.televisionRateChartModel.companyName =
                          _filteredList[index].companyName;
                      dataProvider.televisionRateChartModel.address =
                          _filteredList[index].address;
                      dataProvider.televisionRateChartModel.phone =
                          _filteredList[index].phone;
                      dataProvider.televisionRateChartModel.fax =
                          _filteredList[index].fax;
                      dataProvider.televisionRateChartModel.email =
                          _filteredList[index].email;
                      dataProvider.televisionRateChartModel.web =
                          _filteredList[index].web;
                      dataProvider
                              .televisionRateChartModel.regionalSalesOffice =
                          _filteredList[index].regionalSalesOffice;
                      dataProvider.televisionRateChartModel.effectiveForm =
                          _filteredList[index].effectiveForm;
                      dataProvider.televisionRateChartModel.rateFor =
                          _filteredList[index].rateFor;
                      dataProvider.televisionRateChartModel.programType =
                          _filteredList[index].programType;
                      dataProvider.televisionRateChartModel.programDuration =
                          _filteredList[index].programDuration;
                      dataProvider.televisionRateChartModel.addDuration =
                          _filteredList[index].addDuration;
                      dataProvider.televisionRateChartModel.generalRate =
                          _filteredList[index].generalRate;
                      dataProvider.televisionRateChartModel.fixedPosition =
                          _filteredList[index].fixedPosition;
                      dataProvider.televisionRateChartModel.beforeNews =
                          _filteredList[index].beforeNews;
                      dataProvider.televisionRateChartModel.midBreakInProgram =
                          _filteredList[index].midBreakInProgram;
                      dataProvider.televisionRateChartModel.offPeakTime =
                          _filteredList[index].offPeakTime;
                      dataProvider.televisionRateChartModel.peakTime =
                          _filteredList[index].peakTime;
                      dataProvider.televisionRateChartModel.day =
                          _filteredList[index].day;
                      dataProvider.televisionRateChartModel.specialNote =
                          _filteredList[index].specialNote;
                      dataProvider.televisionRateChartModel.newsTime =
                          _filteredList[index].newsTime;
                      dataProvider.televisionRateChartModel.popUp =
                          _filteredList[index].popUp;
                      dataProvider.televisionRateChartModel.CMTime =
                          _filteredList[index].CMTime;
                      dataProvider
                              .televisionRateChartModel.extraCommercialTime =
                          _filteredList[index].extraCommercialTime;
                      dataProvider.televisionRateChartModel.ordinery =
                          _filteredList[index].ordinery;
                      dataProvider.televisionRateChartModel.banglaFilm =
                          _filteredList[index].banglaFilm;
                      dataProvider.televisionRateChartModel.namingBranding =
                          _filteredList[index].namingBranding;
                      dataProvider.televisionRateChartModel.tarifBrand =
                          _filteredList[index].tarifBrand;
                      dataProvider.televisionRateChartModel.topDown =
                          _filteredList[index].topDown;
                      dataProvider.televisionRateChartModel.LShap =
                          _filteredList[index].LShap;
                      dataProvider.televisionRateChartModel.status =
                          _filteredList[index].status;
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
                              Navigator.pop(context);
                              setState(() => _isLoading = true);
                              firebaseProvider
                                  .deleteTelevisionRateChartData(
                                      _filteredList[index].id!, context)
                                  .then((value) async {
                                if (value == true) {
                                  setState(() => _isLoading = false);
                                  getData(fatchDataHelper);

                                  showToast('Data deleted successful');
                                } else {
                                  Navigator.pop(context);
                                  setState(() => _isLoading = false);

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
