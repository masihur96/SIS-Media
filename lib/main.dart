import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/provider/fatch_data_helper.dart';
import 'package:media_directory_admin/provider/firebase_provider.dart';
import 'package:media_directory_admin/screen/home_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FatchDataHelper(),
        )
      ],
      child: MaterialApp(
          title: 'Media Directory Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            backgroundColor: Color.fromRGBO(216, 211, 216, 1),
            primarySwatch: Colors.green,
            canvasColor: Colors.transparent,
          ),
          home: HomePage()),
    );
  }
}
