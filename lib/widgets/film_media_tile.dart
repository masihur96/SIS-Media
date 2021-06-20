import 'package:flutter/material.dart';
import 'package:media_directory_admin/model/importent_emergency_model.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/category/update_screen/update_importent_emergency.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'notificastion.dart';

// ignore: must_be_immutable
class FilmMediaTile extends StatelessWidget {
  List<ImportentEmergencyModel> dataList;
  int index;
  FilmMediaTile({required this.index,required this.dataList});

  @override
  Widget build(BuildContext context) {
    final FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            Container(
                width: size.height*.15,
                height: size.height*.16,

                child: dataList[index].image.isEmpty? Image.asset('images/atnbanglalogo.jpg',fit: BoxFit.cover):Image.network(dataList[index].image,fit: BoxFit.cover)

            ),
            Container(
              width: size.width*.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dataList[index].name.isEmpty?Container():
                  Text(dataList[index].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  dataList[index].address.isEmpty?Container():
                  Text('Address: ${dataList[index].address}',style: TextStyle(fontSize: 12,)),
                  dataList[index].pabx.isEmpty?Container():
                  Text('PABX: ${dataList[index].pabx}',style: TextStyle(fontSize: 12),),
                  dataList[index].email.isEmpty?Container():
                  Text('E-mail: ${dataList[index].email}',style: TextStyle(fontSize: 12,)),
                  dataList[index].web.isEmpty?Container():
                  Text('Web: ${dataList[index].web}',style: TextStyle(fontSize: 12,)),
                  dataList[index].fax.isEmpty?Container():
                  Text('Fax: ${dataList[index].fax}',style: TextStyle(fontSize: 12)),
                  dataList[index].phone.isEmpty?Container():
                  Text('Phone: ${dataList[index].phone}',style: TextStyle(fontSize: 12,),),
                  dataList[index].mobile.isEmpty?Container():
                  Text('Mobile: ${dataList[index].mobile}',style: TextStyle(fontSize: 12,),),
                  dataList[index].contact.isEmpty?Container():
                  Text('Contact: ${dataList[index].contact}',style: TextStyle(fontSize: 12,),),
                  dataList[index].facebook.isEmpty?Container():
                  Text('Facebook: ${dataList[index].facebook}',style: TextStyle(fontSize: 12,),),
                  dataList[index].corporateOffice.isEmpty?Container():
                  Text('Corporate Office: ${dataList[index].corporateOffice}',style: TextStyle(fontSize: 12,),),
                  dataList[index].headOffice.isEmpty?Container():
                  Text('Head Office: ${dataList[index].headOffice}',style: TextStyle(fontSize: 12,),),
                  dataList[index].position.isEmpty?Container():
                  Text('Position: ${dataList[index].position}',style: TextStyle(fontSize: 12,),),
                  dataList[index].businessType.isEmpty?Container():
                  Text('Business Type: ${dataList[index].businessType}',style: TextStyle(fontSize: 12,),),
                  dataList[index].status.isEmpty?Container():
                  Text('Status: ${dataList[index].status}',style: TextStyle(fontSize: 12,),),
                  // _dataList[index].id.isEmpty?Container():
                  // Text(_dataList[index].id,style: TextStyle(fontSize: 12,),),
                  dataList[index].date.isEmpty?Container():
                  Text('Date: ${dataList[index].date}',style: TextStyle(fontSize: 12,),),
                ],
              ),
            ),
            Container(
              width: size.width*.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          UpdateImportentEmergencyData(
                            name: dataList[index].name,
                            address: dataList[index].address,
                            pabx: dataList[index].pabx,
                            email: dataList[index].email,
                            web: dataList[index].web,
                            fax: dataList[index].fax,
                            phone: dataList[index].phone,
                            mobile: dataList[index].mobile,
                            contact: dataList[index].contact,
                            facebook: dataList[index].facebook,
                            image: dataList[index].image,
                            corporateOffice: dataList[index].corporateOffice,
                            headOffice: dataList[index].headOffice,
                            position: dataList[index].position,
                            businessType: dataList[index].businessType,
                            id: dataList[index].id,
                            status: dataList[index].status,
                            date: dataList[index].date,
                          )));

                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),


                  SizedBox(height: 5,),

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
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {

                              firebaseProvider.deleteImportentEmergencyData(dataList[index].id, context).then((value){
                                if(value==true){
                                  Navigator.pop(context);
                                  showToast('Data deleted successful');
                                }else{
                                  showToast('Data delete unsuccessful');
                                }
                              });
                            },
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
                          )
                        ],
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );;
  }
}