import "package:flutter/material.dart";
import 'package:pitcher/models/climber.dart';
import "package:pitcher/reusables/button.dart";
import 'package:pitcher/util/main.dart';






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
  var active = false;
  @override void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }


  void _handleChange(String str){
    if(
    Util.inputFieldIsValid(_usernameController.text) &&
        Util.inputFieldIsValid(_firstnameController.text) &&
        Util.inputFieldIsValid(_lastnameController.text) &&
        Util.inputFieldIsValid(_emailController.text) &&
        Util.inputFieldIsValid(_passwordController.text)
    ){
      setState(() {
        active = true;
      });
    }else{
      setState((){
        active = false;
      });
    }
  }

  void attemptRegister() async{
    var climber = Climber(
        username: _usernameController.text,
        email: _emailController.text,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        password: _passwordController.text
    );
    var id = await climber.register();
    climber.id = id;
    await climber.authenticate();
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext build){
    return SafeArea(child:
    Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints){
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: constraints.maxHeight
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Create an account",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                  child: TextField(
                                    onChanged: _handleChange,

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
                                    onChanged: _handleChange,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Email"),
                                    ),
                                    controller: _emailController,
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                  child: TextField(
                                    onChanged: _handleChange,

                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("First name"),
                                    ),
                                    controller: _firstnameController,
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                  child: TextField(
                                    onChanged: _handleChange,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Last name"),
                                    ),
                                    controller: _lastnameController,
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                  child: TextField(
                                    onChanged: _handleChange,
                                    decoration: const InputDecoration(
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
                                    action: attemptRegister,
                                    active: active,
                                  )
                              ),
                              Container(
                                child:
                                TextButton(
                                    child: const Text("I already have an account"),
                                    onPressed: (){
                                      Navigator.pushReplacementNamed(context, "/login");
                                    }
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                              ),
                            ],
                          )
                      )
                  );

                }
            )
        )),
    );


  }
}





