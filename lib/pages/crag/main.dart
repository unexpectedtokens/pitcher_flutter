import 'package:flutter/material.dart';
import 'package:pitcher/models/crag.dart';
import 'package:pitcher/models/climber.dart';
import 'map.dart';
import 'list.dart';

class CragMainView extends StatefulWidget{

  const CragMainView({Key? key}) : super(key: key);

  @override
  State<CragMainView> createState() => _CragMainState();
}



class _CragMainState extends State<CragMainView>{


  late List<Crag> _crags;
  late bool _loading = true;
  late bool _error = false;


  void _getCurUser() async{

    var climber = await Climber.getCurUser();

  }

  void _loadCrags() async{
    try{
      var crags = await Crag.getList();
      setState((){
        _crags = crags;
        _loading = false;
      });
    }catch(e){
      setState((){
        //_loading = false;
        _error = true;
      });
    }
  }


  @override
  void initState(){
    _loadCrags();

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: const Text(
                "Pitcher",
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      child: const Icon(
                          Icons.person_outlined,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, "/profile");
                      },
                      style: ButtonStyle(

                        shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder()
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            //Colors.blue
                          Colors.black87
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                            //Colors.lightBlue
                          Colors.black12
                        ),
                      ),

                    )),
              ],
              leading: Padding(
                  padding: const EdgeInsets.all(10.0),

                  child: CircleAvatar(
                    radius: 2.0,
                    child: Image.asset(
                        "assets/logo.png"
                    ),
                  )
              ),
              bottom: const TabBar(
                  indicatorColor: Colors.black87,
                  tabs: <Widget>[
                    Tab(
                        icon: Icon(Icons.map_outlined)
                    ),
                    Tab(
                      icon: Icon(Icons.view_list_rounded ),
                    )
                  ]
              ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black87,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  await Navigator.pushNamed(context, "/addcrag");
                  print("loading crags again:");
                  _loadCrags();
                }
            ),
            body: _loading ? const Center(child: Text("loading...")):TabBarView(
              physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Center(
                    child: CragMapView(crags: _crags),
                  ),
                  Center(
                    child: CragListView(crags: _crags),
                  )
                ])
        ));
  }
}