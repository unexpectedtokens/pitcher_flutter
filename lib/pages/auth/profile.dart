import 'package:flutter/material.dart';
import 'package:pitcher/models/climber.dart';
import 'package:pitcher/reusables/button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

 late Future<Climber> climber = Climber.getCurUser();
  void _navigateBack(){
    Navigator.pop(context);
  }

  Future<Climber> getCurUser(){
    return Future.value(Climber.getCurUser());
  }


  void _logOut(){
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              "Profile"
          ),
          leading: IconButton(
            onPressed: _navigateBack,
            icon: const Icon(
                Icons.arrow_back
            ),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                FutureBuilder<Climber>(
                    future: getCurUser(),
                    builder: (BuildContext context, AsyncSnapshot<Climber> snapshot){
                      if(snapshot.hasData){
                        return Column(
                          children: [
                            Text(
                              "Username: ${snapshot.data!.username}",
                            ),
                            Text(
                              "Email: ${snapshot.data!.email}",
                            ),
                            Text(
                              "Name: ${snapshot.data!.firstname} ${snapshot.data!.lastname}",
                            )
                          ],
                        );
                      } else if(snapshot.hasError){
                        return const Text(
                            "Something went wrong fetching your information. "
                                "Please try again later"
                        );
                      }else{
                        return const CircularProgressIndicator();
                      }
                    }
                ),

                FullWidthButton(
                  buttonText: "Log out",
                  action: _logOut,
                  active: true
              ),
              ]
            )
        )
    );
  }
}
