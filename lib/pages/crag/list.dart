

import 'package:flutter/material.dart';
import 'package:pitcher/models/crag.dart';
import 'package:pitcher/pages/crag/detail.dart';

class CragListView extends StatelessWidget {

  final List<Crag> crags;

  const CragListView({
    Key? key,
    required this.crags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(


      itemCount: crags.length,

      itemBuilder: (BuildContext context, int index){
        var crag = crags[index];
        return Container(

          margin: EdgeInsets.fromLTRB(
            20.0,
            20.0,
            30.0,
            index + 1 == crags.length ? 100 : 10,
          ),
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(
                context,
                "/cragdetail",
                arguments: WidgetArguments(crag: crag),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/placeholdercrag.png"),
                            fit: BoxFit.cover,
                            alignment: Alignment.center
                        )
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  //padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    crag.name,
                                    maxLines: 2,

                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        overflow: TextOverflow.fade
                                    ),
                                  ),
                                ),

                                Text(
                                    "Created by ${crag.creator.username}",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    )
                                ),

                              ]
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:  [

                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0
                                      ),
                                      child: const Icon(
                                          Icons.favorite_border,
                                          size: 20.0
                                      ),
                                    ),

                                    const Text(
                                      "39",
                                      style: TextStyle(
                                          fontSize: 15.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child:Row(
                                        children: [

                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                            child: Image.asset(
                                                "assets/carabiner.png",
                                                width: 15
                                            ),
                                          ),
                                          const Text("46"),
                                        ]
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 0.0
                                    ),
                                  ),

                                  Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                          child: Image.asset(
                                            "assets/asteroid.png",
                                            width: 15,),
                                        ),
                                        const Text("46"),
                                      ]
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],

                    ),
                  ),
                ),

              ],
            ),
          ),
          //Text(crag.name),
          height: 260,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [BoxShadow(
                blurRadius: 20.0,
                color: Colors.black12,
              )]
          ),
        );
      },
    );
  }
}
//
