import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/category_model.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:media_directory_admin/widgets/notificastion.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:uuid/uuid.dart';

class SubCategoryPage extends StatefulWidget {
  // const SisHomePage({Key? key}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  TextEditingController _fieldController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  bool _isLoading = false;
  String oldText = '';

  String category = '';
  String dropdownValue = "Film Media";
  List categorys = Variables().getCategoryList();

  int counter = 0;

  String addOrEdit = '';

  List _categoryList = [];

  List<CategoryModel> _filteredList = [];
  List<CategoryModel> _subCategoryList = [];

  _filterSubCategoryList(String searchItem) {
    setState(() {
      _filteredList = _subCategoryList
          .where((element) => (element.category!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
          .toList();
      //_filteredListForSearch = _filteredList;
    });
  }

  String collectionValue = 'FilmMediaData';

  String changeCategoryValue(String value) {
    if (value == 'Film Media')
      return 'FilmMediaData';
    else if (value == 'Television Media')
      return "TelevisionMediaData";
    else if (value == 'Audio Media')
      return "AudioData";
    else if (value == 'Print Media')
      return "PrintMediaData";
    else if (value == 'New Media')
      return "NewMediaData";
    else
      return "ImportentEmergency";
  }

  customInit(DataProvider dataProvider) async {
    setState(() {
      counter++;
    });

    setState(() {
      _isLoading = true;
    });

    changeCategoryValue(dropdownValue);

    if (dataProvider.subCategorydataList.isEmpty) {
      await dataProvider.fetchSubCategoryListData().then((value) {
        setState(() {
          _subCategoryList = dataProvider.subCategorydataList;
          _filterSubCategoryList(dropdownValue);
        });
      });
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _subCategoryList = dataProvider.subCategorydataList;
        _filterSubCategoryList(dropdownValue);
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  getData(DataProvider dataProvider) async {
    setState(() {
      _isLoading = true;
    });

    await dataProvider.fetchSubCategoryListData().then((value) {
      setState(() {
        _subCategoryList = dataProvider.subCategorydataList;
        _filterSubCategoryList(dropdownValue);

        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    if (counter == 0) {
      customInit(dataProvider);
    }
    return Container(
      color: Color(0xffedf7fd),
      width: dataProvider.pageWidth(size),
      height: size.height,
      child: Center(
        child: Column(
          children: [
            Text('Sub-Category List',
                style: TextStyle(fontSize: size.height * .035)),
            SizedBox(
              height: size.height * .01,
            ),
            Container(
              width: size.height * .8,
              height: size.height * .85,
              color: Colors.white,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Category : ",
                                  style:
                                      TextStyle(fontSize: size.height * .025),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    elevation: 0,
                                    dropdownColor: Colors.white,
                                    style: TextStyle(color: Colors.black),
                                    items: categorys.map((itemValue) {
                                      return DropdownMenuItem<String>(
                                        value: itemValue,
                                        child: Text(itemValue),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                      _filterSubCategoryList(dropdownValue);

                                      collectionValue =
                                          changeCategoryValue(dropdownValue);
                                    },
                                  ),
                                ),
                              ]),
                        )),
                        IconButton(
                          onPressed: () {
                            _textFieldController.clear();

                            setState(() {
                              addOrEdit = 'add';
                              oldText = '';
                            });

                            _displayTextInputDialog(
                                context, dataProvider, 'id');
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: size.height * .8,
                      color: Colors.grey,
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
                            child: Container(
                              child: ListView.builder(
                                  itemCount: _filteredList.length,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 3,
                                                right: 3,
                                              ),
                                              child: Container(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(_filteredList[index]
                                                      .subCategory!),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              setState(() {});
                                                              setState(() {
                                                                addOrEdit =
                                                                    'edit';

                                                                oldText = _filteredList[
                                                                        index]
                                                                    .subCategory!;

                                                                if (oldText == 'Rate Chart' ||
                                                                    oldText ==
                                                                        'Management Information' ||
                                                                    oldText ==
                                                                        'Management Information (Education Service Company)') {
                                                                  showToast(
                                                                      'You are not eligible to update this Subcategory');
                                                                }

                                                                _textFieldController
                                                                        .text =
                                                                    oldText;

                                                                _displayTextInputDialog(
                                                                    context,
                                                                    dataProvider,
                                                                    _filteredList[
                                                                            index]
                                                                        .id!);
                                                              });
                                                            },
                                                            icon: Icon(Icons
                                                                .edit_outlined)),
                                                        SizedBox(
                                                          width:
                                                              size.height * .02,
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                oldText = _filteredList[
                                                                        index]
                                                                    .subCategory!;
                                                                Alert(
                                                                  context:
                                                                      context,
                                                                  type: AlertType
                                                                      .warning,
                                                                  title:
                                                                      "Confirmation Alert",
                                                                  desc:
                                                                      "All the Data of this Subcategory Will be Deleted .\n Are you confirm to delete this Subcategory ? ",
                                                                  buttons: [
                                                                    DialogButton(
                                                                      child:
                                                                          Text(
                                                                        "Cancel",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                    DialogButton(
                                                                      child:
                                                                          Text(
                                                                        "OK",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              true;
                                                                        });

                                                                        dataProvider
                                                                            .batchDeleteSub(
                                                                                collectionValue,
                                                                                oldText,
                                                                                _filteredList[index].id!)
                                                                            .then((value) {
                                                                          if (value =
                                                                              true) {
                                                                            _filteredList.removeWhere((item) =>
                                                                                item.id ==
                                                                                _filteredList[index].id!);
                                                                            setState(() =>
                                                                                _isLoading = false);
                                                                          } else {
                                                                            setState(() =>
                                                                                _isLoading = false);

                                                                            showToast('Data delete unsuccessful');
                                                                          }
                                                                        }).then((value) {
                                                                          getData(
                                                                              dataProvider);
                                                                        });
                                                                      },
                                                                    )
                                                                  ],
                                                                ).show();
                                                              });
                                                            },
                                                            child: Icon(Icons
                                                                .cancel_outlined))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, DataProvider dataProvider, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Add SubCategory'),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    //   valueText = value;
                  });
                },
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Sub-Category Name"),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      // color: Colors.green,
                      // textColor: Colors.white,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          //  codeDialog = valueText;

                          _textFieldController.clear();
                          Navigator.pop(context);
                        });
                      },
                    ),
                    _isLoading
                        ? Container(
                            child: Column(
                            children: [
                              fadingCircle,
                            ],
                          ))
                        : Visibility(
                            visible: oldText != 'Rate Chart' &&
                                oldText != 'Management Information' &&
                                oldText !=
                                    'Management Information (Education Service Company)',
                            child: TextButton(
                              child: Text('OK',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                // print(oldText);
                                // print(_textFieldController.text);

                                if (addOrEdit == 'add') {
                                  final String uuid = Uuid().v1();

                                  dataProvider
                                      .addSubCategoryData(dropdownValue,
                                          _textFieldController.text, uuid)
                                      .then((value) {
                                    getData(dataProvider);
                                    Navigator.pop(context);
                                    _isLoading = false;
                                    _textFieldController.clear();
                                  });
                                } else {
                                  Map<String, String> mapData = {
                                    'category': dropdownValue,
                                    'subCategory': _textFieldController.text,
                                    'id': id,
                                  };
                                  dataProvider
                                      .batchUpdateSub(mapData, collectionValue,
                                          oldText, _textFieldController.text)
                                      .then((value) {
                                    getData(dataProvider);

                                    setState(() {
                                      Navigator.pop(context);
                                      _isLoading = false;
                                    });
                                  });
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ],
            );
          });
        });
  }
}
