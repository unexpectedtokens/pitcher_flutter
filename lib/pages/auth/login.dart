import "package:flutter/material.dart";
import "package:pitcher/reusables/button.dart";






class LoginPage extends StatefulWidget{

  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState () => _LoginState();

}


class _LoginState extends State<LoginPage>{

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              child: TextField(decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Username"),

              ),
              controller: _usernameController
              )
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: TextField(decoration: const InputDecoration(
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
              action: (){
                Navigator.pushReplacementNamed(context, "/home");
              }
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
      ))
    );

  }
}



