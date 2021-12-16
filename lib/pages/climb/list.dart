import 'package:flutter/material.dart';
import 'package:pitcher/models/climb.dart';
import 'package:pitcher/models/climber.dart';
import 'package:pitcher/pages/climb/detail.dart';

class PageArgs{
  final List<Climb> climbs;

  PageArgs({
    required this.climbs
  });
}

class ClimbList extends StatelessWidget {

  const ClimbList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final args = ModalRoute.of(context)!.settings.arguments as PageArgs;
    var climbs = args.climbs;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },

          ),
        ),
        body: ListView.builder(
            itemCount: climbs.length,

            itemBuilder: (BuildContext context, int index){
              var climb = climbs[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 30.0
                  ),
                  subtitle: Text(
                      "Created by ${climb.climber.username}"
                  ),
                  title: Text(
                      climb.name
                  ),
                  trailing: Text(
                      climb.grade
                  ),
                  tileColor: Colors.white,

                  onTap: (){
                    Navigator.pushNamed(context, "/climbingdetail", arguments: ClimbDetailArgs(
                      climb: climb,
                    ));
                  },

                ),
              );
            }
        )
    );
  }


}

