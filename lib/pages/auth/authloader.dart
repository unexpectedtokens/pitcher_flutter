





import 'package:flutter/material.dart';
import 'dart:async';

import 'package:loading_indicator/loading_indicator.dart';

class AuthLoader extends StatefulWidget{


  const AuthLoader({Key? key}) : super(key: key);

  @override
  State<AuthLoader> createState () => _AuthLoaderState();
}



class _AuthLoaderState extends State<AuthLoader>{



  void simulateAuthAttempt() async {
    Timer(const Duration(seconds: 3), ()=> setState(() {
      navigateToAuth();
    }));

  }

  void navigateToAuth(){
    Navigator.pushReplacementNamed(context, "/login");
  }

  void navigateToApp(){
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void initState(){
    simulateAuthAttempt();
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