import 'package:flutter/material.dart';
import 'package:pitcher/models/climber.dart';
import 'package:pitcher/reusables/button.dart';
import 'package:pitcher/reusables/content_title.dart';
import 'package:pitcher/reusables/counter.dart';
import 'package:pitcher/models/send.dart';
import 'package:pitcher/reusables/input.dart';


class AddSendView extends StatefulWidget {
  const AddSendView({Key? key}) : super(key: key);

  @override
  _AddSendViewState createState() => _AddSendViewState();
}

class _AddSendViewState extends State<AddSendView> {
  int count = 1;
  bool initialLoad = true;
  int climbid = 0;
  void _addTry(){
    setState(() {
      count += 1;
    });
  }

  void _removeTry(){
    var num = count;
    if (count <= 1){
      num = 1;
    }else {
      num -= 1;
    }
    setState(() {
      count = num;
    });
  }

  void _submit() async{
    var curUser = await Climber.getCurUser();
    var send = Send(
      tries: count,
      sender: curUser,
    );
    await send.insert(climbid);
    Navigator.pop(context);

  }

  void _initialize(BuildContext context){
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = int.parse(args["id"]!.toString());
    setState((){
      climbid = id;
      initialLoad = false;
    });
  }

  @override
  Widget build(BuildContext context){
    if(initialLoad){
      _initialize(context);
    }
    return Scaffold(
      body: SafeArea(


        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ContentTitle(
                  title: "Add a send to this climb"
              ),
              const Text(
                  "How many tries did it take?"
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 40
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Counter(
                          add: _addTry,
                          remove: _removeTry,
                          count: count
                      ),

                    ]
                ),
              ),
              FullWidthButton(
                active: true,
                buttonText: "Add send",
                action: _submit,
              ),

              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




