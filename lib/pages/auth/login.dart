import "package:flutter/material.dart";
import 'package:pitcher/models/climber.dart';
import "package:pitcher/reusables/button.dart";
import 'package:pitcher/util/main.dart';





class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState () => _LoginState();
}

class _LoginState extends State<LoginPage>{

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var valid = false;

  @override void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void handleChange(String string){
    if(Util.inputFieldIsValid(_usernameController.text)
        && Util.inputFieldIsValid(_passwordController.text)
    ){
      setState((){
        valid = true;
      });
    }
  }

  void attemptLogin() async{
    var uid = await Climber.login(
        _usernameController.text,
        _passwordController.text
    );
    var climber = Climber.returnMockClimber();
    climber.id = uid ;
    await climber.authenticate();
    Navigator.pushReplacementNamed(
        context,
        "/home"
    );
  }

  @override
  Widget build(BuildContext build){
    return SafeArea(child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0),child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Log in", style: TextStyle(fontSize: 20.0),),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextField(
                  onChanged: handleChange,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Username"),

                  ),
                  controller: _usernameController,
                )
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextField(
                    onChanged: handleChange,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password")
                    ),
                    obscureText: true,
                    controller: _passwordController
                )
            ),
            Padding(
                padding:  const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child:  FullWidthButton(
                    buttonText: "Log in",
                    action: attemptLogin,
                    active: valid
                )
            ),
            Container(
              child:
              TextButton(
                child: const Text("I don't have an account yet"),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/register");
                },
              ),
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
            ),
          ],
        ),
        )
    )

    );
  }
}
