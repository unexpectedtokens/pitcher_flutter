import "package:flutter/material.dart";
import "package:pitcher/reusables/button.dart";






class RegisterPage extends StatefulWidget{

  const RegisterPage({Key? key}) : super(key: key);


  @override
  State<RegisterPage> createState () => _RegisterState();

}


class _RegisterState extends State<RegisterPage>{

  final _usernameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  void attemptRegister(){
    _usernameController.text = "yes";
  }

  @override
  Widget build(BuildContext build){
    return SafeArea(child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Create an account", style: TextStyle(fontSize: 20.0),),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextField(decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Username"),
                ),
                  controller: _usernameController,
                )
            ),
             Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextField(decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password")
                ),
                  obscureText: true,
                  controller: _passwordController,
                )
            ),
            Padding(
                padding:  const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child:  FullWidthButton(
                    buttonText: "Create account",
                    action: (){
                      Navigator.pushReplacementNamed(context, "/home");
                    }
                )
            ),
            Container(
              child:
              TextButton(
                child: const Text("I already have an account"),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/login");
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



