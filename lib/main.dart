import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firenoteapp/pages/home_page.dart';
import 'package:firenoteapp/services/auth_service.dart';
import 'package:firenoteapp/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/detail_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(DBService.dbName);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final RouteObserver<PageRoute> routeObserver =
  RouteObserver<PageRoute>();

  Widget _startPage(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.auth.authStateChanges(),
      builder: (context, value) {
        if(value.hasData) {
          DBService.storeString(StorageKeys.UID, value.data!.uid);
          return HomePage();
        } else {
          DBService.removeString(StorageKeys.UID);
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      title: 'Fire Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(context),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        DetailPage.id: (context) => DetailPage(),
      },
    );
  }
}
