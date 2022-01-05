





import 'package:flutter/material.dart';
import 'dart:async';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:pitcher/models/climber.dart';

class AuthLoader extends StatefulWidget{


  const AuthLoader({Key? key}) : super(key: key);

  @override
  State<AuthLoader> createState () => _AuthLoaderState();
}



class _AuthLoaderState extends State<AuthLoader>{




  void authAttempt() async {
    var loggedIn = await Climber.checkIfLogin();
    if (loggedIn){
      navigateToAuth();
    }else{
      navigateToApp();
    }
  }

  void navigateToAuth(){
    Navigator.pushReplacementNamed(context, "/login");
  }

  void navigateToApp(){
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void initState(){
    authAttempt();
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return const Scaffold(
      body:  Center(
        child: LoadingIndicator(
            indicatorType: Indicator.ballScale,

        ),
      ),
    );

  }

}