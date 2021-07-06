import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/audio_media_model.dart';
import 'package:media_directory_admin/model/film_media_model.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/model/new_media_model.dart';
import 'package:media_directory_admin/model/print_media_model.dart';
import 'package:media_directory_admin/model/television_media_model.dart';
import 'package:media_directory_admin/model/user_request_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool _isLoading = false;
  int counter = 0;
  List<FilmMediaModel> _filmTotalDataList = [];
  List<FilmMediaModel> _filmPrivateDataList = [];

  List<TelevisionMediaModel> _televisionTotalDataList = [];
  List<TelevisionMediaModel> _televisionPrivateDataList = [];

  List<AudioMediaModel> _audioTotalDataList = [];
  List<AudioMediaModel> _audioPrivateDataList = [];

  List<PrintMediaModel> _printingTotalDataList = [];
  List<PrintMediaModel> _printingPrivateDataList = [];
  List<NewMediaModel> _newTotalDataList = [];
  List<NewMediaModel> _newPrivateDataList = [];
  List<ImportentEmergencyModel> _importentTotalDataList = [];
  List<ImportentEmergencyModel> _importentPrivateDataList = [];

  List<UserRequestModel> _requestTotalDataList = [];
  List<UserRequestModel> _requestTodayRequestList = [];

  customInit(
    FatchDataHelper fatchDataHelper,
  ) async {
    setState(() {
      counter++;
      _isLoading = true;
    });

    if (fatchDataHelper.filmMediadataList.isEmpty) {
      await fatchDataHelper.fetchFilmMediaData().then((value) {
        setState(() {
          _filmTotalDataList = fatchDataHelper.filmMediadataList;
          for (int i = 0; i < _filmTotalDataList.length; i++) {
            if (_filmTotalDataList[i].status == 'private') {
              _filmPrivateDataList.add(_filmTotalDataList[i]);
            }
          }
        });
      });
    } else {
      setState(() {
        _filmTotalDataList = fatchDataHelper.filmMediadataList;
        for (int i = 0; i < _filmTotalDataList.length; i++) {
          if (_filmTotalDataList[i].status == 'private') {
            _filmPrivateDataList.add(_filmTotalDataList[i]);
          }
        }
      });
    }

    if (fatchDataHelper.televisionMediadataList.isEmpty) {
      await fatchDataHelper.fetchTelevisionData().then((value) {
        setState(() {
          _televisionTotalDataList = fatchDataHelper.televisionMediadataList;
          for (int i = 0; i < _televisionTotalDataList.length; i++) {
            if (_televisionTotalDataList[i].status == 'private') {
              _televisionPrivateDataList.add(_televisionTotalDataList[i]);
            }
          }
        });
      });
    } else {
      setState(() {
        _televisionTotalDataList = fatchDataHelper.televisionMediadataList;
        for (int i = 0; i < _televisionTotalDataList.length; i++) {
          if (_televisionTotalDataList[i].status == 'private') {
            _televisionPrivateDataList.add(_televisionTotalDataList[i]);
          }
        }
      });
    }

    if (fatchDataHelper.audioMediadataList.isEmpty) {
      await fatchDataHelper.fetchAudioData().then((value) {
        setState(() {
          _audioTotalDataList = fatchDataHelper.audioMediadataList;
          for (int i = 0; i < _audioTotalDataList.length; i++) {
            if (_audioTotalDataList[i].status == 'private') {
              _audioPrivateDataList.add(_audioTotalDataList[i]);
            }
          }
        });
      });
    } else {
      setState(() {
        _audioTotalDataList = fatchDataHelper.audioMediadataList;
        for (int i = 0; i < _audioTotalDataList.length; i++) {
          if (_audioTotalDataList[i].status == 'private') {
            _audioPrivateDataList.add(_audioTotalDataList[i]);
          }
        }
      });
    }

    if (fatchDataHelper.printMediaDataList.isEmpty) {
      await fatchDataHelper.fetchPrintData().then((value) {
        setState(() {
          _printingTotalDataList = fatchDataHelper.printMediaDataList;
          for (int i = 0; i < _printingTotalDataList.length; i++) {
            if (_printingTotalDataList[i].status == 'private') {
              _printingPrivateDataList.add(_printingTotalDataList[i]);
            }
          }
        });
      });
    } else {
      setState(() {
        _printingTotalDataList = fatchDataHelper.printMediaDataList;
        for (int i = 0; i < _printingTotalDataList.length; i++) {
          if (_printingTotalDataList[i].status == 'private') {
            _printingPrivateDataList.add(_printingTotalDataList[i]);
          }
        }
      });
    }

    if (fatchDataHelper.newMediadataList.isEmpty) {
      await fatchDataHelper.fetchNewData().then((value) {
        setState(() {
          _newTotalDataList = fatchDataHelper.newMediadataList;
          for (int i = 0; i < _newTotalDataList.length; i++) {
            if (_newTotalDataList[i].status == 'private') {
              _newPrivateDataList.add(_newTotalDataList[i]);
            }
          }
        });
      });
    } else {
      setState(() {
        _newTotalDataList = fatchDataHelper.newMediadataList;
        for (int i = 0; i < _newTotalDataList.length; i++) {
          if (_newTotalDataList[i].status == 'private') {
            _newPrivateDataList.add(_newTotalDataList[i]);
          }
        }
      });
    }

    if (fatchDataHelper.importentMediadataList.isEmpty) {
      await fatchDataHelper.fetchImportentEmergencyData().then((value) {
        setState(() {
          _importentTotalDataList = fatchDataHelper.importentMediadataList;
          for (int i = 0; i < _importentTotalDataList.length; i++) {
            if (_importentTotalDataList[i].status == 'private') {
              _importentPrivateDataList.add(_importentTotalDataList[i]);
            }
          }
        });
      });
    } else {
      setState(() {
        _importentTotalDataList = fatchDataHelper.importentMediadataList;
        for (int i = 0; i < _importentTotalDataList.length; i++) {
          if (_importentTotalDataList[i].status == 'private') {
            _importentPrivateDataList.add(_importentTotalDataList[i]);
          }
        }
      });
    }

    DateTime date = DateTime.now();
    String dateData = '${date.day}-${date.month}-${date.year}';

    if (fatchDataHelper.userRequestdataList.isEmpty) {
      await fatchDataHelper.fetchRequestData().then((value) {
        setState(() {
          _requestTotalDataList = fatchDataHelper.userRequestdataList;
          for (int i = 0; i < _requestTotalDataList.length; i++) {
            if (_requestTotalDataList[i].request_date == dateData) {
              _requestTodayRequestList.add(_requestTotalDataList[i]);
            }
          }

          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _requestTotalDataList = fatchDataHelper.userRequestdataList;
        for (int i = 0; i < _requestTotalDataList.length; i++) {
          if (_requestTotalDataList[i].request_date == dateData) {
            _requestTodayRequestList.add(_requestTotalDataList[i]);
          }
        }

        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    final FatchDataHelper fatchDataHelper =
        Provider.of<FatchDataHelper>(context);

    if (counter == 0) {
      customInit(fatchDataHelper);
    }

    return Container(
      width: dataProvider.pageWidth(size),
      height: size.height,
      color: Colors.grey.shade50,
      alignment: Alignment.center,
      child: _isLoading
          ? Container(
              child: Column(
              children: [
                SizedBox(
                  height: size.height * .4,
                ),
                fadingCircle,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Please Wait ..........',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
              ],
            ))
          : GridView(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width < 600
                      ? 1
                      : size.width < 700
                          ? 2
                          : size.width < 1300
                              ? 3
                              : 4,
                  childAspectRatio: 1.3),
              children: [
                _gridViewTile(
                    size,
                    'Film' + "\n" 'Media',
                    Color(0xff9D7CFD),
                    'Total Data',
                    'Private Data',
                    _filmTotalDataList.length.toString(),
                    _filmPrivateDataList.length.toString(),
                    dataProvider),
                _gridViewTile(
                    size,
                    'Television' + "\n" 'Media',
                    Color(0xff00B5C9),
                    'Total Data',
                    'Private Data',
                    _televisionTotalDataList.length.toString(),
                    _televisionPrivateDataList.length.toString(),
                    dataProvider),
                _gridViewTile(
                    size,
                    'Audio' + "\n" 'Media',
                    Color(0xffFF8C00),
                    'Total Data',
                    'Private Data',
                    _audioTotalDataList.length.toString(),
                    _audioPrivateDataList.length.toString(),
                    dataProvider),
                _gridViewTile(
                    size,
                    'Print' + "\n" 'Media',
                    Color(0xff00A958),
                    'Total Data',
                    'Private Data',
                    _printingTotalDataList.length.toString(),
                    _printingPrivateDataList.length.toString(),
                    dataProvider),
                _gridViewTile(
                    size,
                    'New' + "\n" 'Media',
                    Color(0xff00C4FE),
                    'Total Data',
                    'Private Data',
                    _newTotalDataList.length.toString(),
                    _newPrivateDataList.length.toString(),
                    dataProvider),
                _gridViewTile(
                    size,
                    'Importent ' + "\n" '& ' + "\n" 'Imergecy',
                    Color(0xffFF8C00),
                    'Total Data',
                    'Private Data',
                    _importentTotalDataList.length.toString(),
                    _importentPrivateDataList.length.toString(),
                    dataProvider),
                _gridViewTile(
                  size,
                  'Request' + "\n" 'Data',
                  Color(0xff9D7CFD),
                  'Total Request',
                  'Today  Request',
                  _requestTotalDataList.length.toString(),
                  _requestTodayRequestList.length.toString(),
                  dataProvider,
                ),
              ],
            ),
    );
  }

  Widget _gridViewTile(
      Size size,
      String title,
      Color bgColor,
      String heading1,
      String heading2,
      String h1Data,
      String h2Data,
      DataProvider dataProvider) {
    return Stack(
      children: [
        Container(
          width: size.height * .5,
          height: size.height * .21,
          margin: EdgeInsets.only(
              top: size.height * .05,
              left: size.height * .02,
              right: size.height * .02),
          padding: EdgeInsets.symmetric(
              horizontal: size.height * .02, vertical: size.height * .02),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    heading1,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.height * .016,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(h1Data,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: size.height * .022,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(height: size.height * .01),
                  Text(
                    heading2,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.height * .016,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(h2Data,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: size.height * .022,
                        fontWeight: FontWeight.w400,
                      )),
                  Divider(height: 3, thickness: 0.2, color: Colors.grey),
                ],
              ),
              TextButton(
                  onPressed: () {
                    if (title == 'Film' + "\n" 'Media') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Film Media";
                    } else if (title == 'Television' + "\n" 'Media') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Television Media";
                    } else if (title == 'Audio' + "\n" 'Media') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Audio Media";
                    } else if (title == 'Print' + "\n" 'Media') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Print Media";
                    } else if (title == 'New' + "\n" 'Media') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "New Media";
                    } else if (title ==
                        'Importent ' + "\n" '& ' + "\n" 'Imergecy') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Importent & Emergency";
                    } else if (title == 'Request' + "\n" 'Data') {
                      dataProvider.category = dataProvider.subCategory;
                      dataProvider.subCategory = "Request Details";
                    }
                  },
                  child: Text('View All',
                      style: TextStyle(
                        fontSize: size.height * .016,
                        fontWeight: FontWeight.w400,
                      )))
            ],
          ),
        ),
        Positioned(
          left: size.height * .04,
          top: size.height * .02,
          child: Container(
            height: size.height * .1,
            width: size.height * .1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 10,
                  )
                ]),
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * .02,
                )),
          ),
        )
      ],
    );
  }
}
