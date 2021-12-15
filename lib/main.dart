import 'package:flutter/material.dart';
import 'package:pitcher/pages/climb/add_send.dart';
import 'package:pitcher/pages/climb/camera.dart';
import 'package:pitcher/pages/climb/detail.dart';
import 'package:pitcher/pages/crag/detail.dart';
import "pages/auth/login.dart";
import "pages/auth/register.dart";
import 'pages/auth/authloader.dart';
import 'pages/crag/main.dart';
import 'pages/crag/add.dart';
import 'pages/auth/profile.dart';
import 'pages/climb/add.dart';
import 'pages/climb/list.dart';
import 'package:camera/camera.dart';






void main() async{
  WidgetsFlutterBinding.ensureInitialized();




  runApp(const App());
}



class App extends StatelessWidget {
  const App({
    Key? key,

  }) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/authloader",
      theme:  ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
              titleSpacing: 10.0,
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 60.0
          )
      ),
      routes: {
        "/authloader": (context) => const AuthLoader(),
        "/addcrag": (context) => const AddCrag(),
        "/home": (context) => const CragMainView(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/profile": (context) => const ProfileView(),
        "/cragdetail": (context) => const CragDetailView(),
        "/addclimb": (context) => const AddClimb(),
        "/climbinglist": (context) => const ClimbList(),
        "/climbingdetail": (context) => const ClimbDetail(),
        "/climbaddsend": (context) => const AddSendView(),
        "/climbcamera": (context) =>  const CameraView()
      },
    );
  }
}




