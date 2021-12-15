import 'package:flutter/material.dart';
import 'package:pitcher/models/climber.dart';
import 'package:pitcher/reusables/button.dart';
import 'package:pitcher/models/crag.dart';
import 'package:pitcher/models/climb.dart';
import 'package:pitcher/models/location.dart' as model_location;
import 'package:pitcher/util/main.dart';
import 'package:location/location.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pitcher/pages/crag/detail.dart';

class AddClimb extends StatefulWidget {
  const AddClimb({Key? key}) : super(key: key);
  @override
  _AddClimbState createState() => _AddClimbState();
}

class _AddClimbState extends State<AddClimb> {



  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String climbType = "Boulder";
  double sliderIndex = 0;
  bool valid = false;
  bool loading = true;
  late LocationData _locationData;
  late Crag _parentCrag;

  void _initLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState((){
          loading = false;
        });
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState((){
          loading = false;
        });
        return;
      }
    }
    var _locationData = await location.getLocation();
    setState((){
      this._locationData = _locationData;
      loading = false;
    });
  }


  @override
  void initState(){
    Future.delayed(Duration.zero, (){
      final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;
      setState((){
        _parentCrag = args.crag!;
      });
    });
    _initLocation();
    super.initState();
  }



  void _navigateBack(){
    Navigator.pop(context);
  }

  void _submitClimb() async{
    var newCrag = _parentCrag;
    var climb = Climb(
        name: _nameController.text,
        description: _descriptionController.text,
        location: model_location.Location(
            lat: _locationData.latitude!,
            long: _locationData.longitude!),
        grade: Climb.grades[sliderIndex.toInt()],
        typeOfClimb: climbType == "Boulder" ? ClimbType.boulder : ClimbType.route
    );
    var creator = await Climber.getCurUser();
    climb.climber = creator;
    await newCrag.addClimb(climb);
    Navigator.pop(context);
  }

  void _handleInputChange(String str){
    if(Util.inputFieldIsValid(_nameController.text) &&
        Util.inputFieldIsValid(_descriptionController.text)){
      setState((){
        valid = true;
      });
    }else{
      setState((){
        valid = false;
      });
    }
  }

  @override
  void dispose(){
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                  Icons.arrow_back
              ),
              onPressed: _navigateBack,
            ),
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: constraints.maxHeight
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100.0,
                          horizontal: 50.0
                      ),
                      child: loading ? const LoadingIndicator(indicatorType: Indicator.ballPulse):
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            const Text(
                              "Add a new climb to the crag",
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                            ),
                            TextField(
                              controller: _nameController,
                              onChanged: _handleInputChange,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                label: Text(
                                    "Name of the climb"
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10.0),
                            ),
                            TextField(
                              controller: _descriptionController,
                              onChanged: _handleInputChange,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                label: Text(
                                    "Description"
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("What type of climb is it?"),
                                    DropdownButton<String>(

                                        value: climbType,
                                        onChanged: (newValue) {
                                          setState(() {
                                            climbType = newValue!.toString();
                                          });
                                        },
                                        items: <String>[
                                          "Boulder",
                                          "Route",
                                        ].map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e)
                                        )
                                        ).toList()),
                                  ]
                              ),
                            ),
                            Slider(
                              min: 0,
                              max: Climb.grades.length.toDouble() - 1,
                              value: sliderIndex,
                              onChanged: (double d){
                                setState((){
                                  sliderIndex = d;
                                });
                              },
                              activeColor: Colors.black87,
                              label: Climb.grades[sliderIndex.toInt()],
                              thumbColor: Colors.black87,
                              divisions: Climb.grades.length,

                            ),

                            Container(
                              margin: const EdgeInsets.all(20.0),
                            ),
                            FullWidthButton(
                              buttonText: "Save climb",
                              action: _submitClimb,
                              icon: const Icon(Icons.add, color: Colors.white,),
                              active: valid,
                            ),
                          ]
                      ),
                    ),
                  ),
                );
              })
      );
  }
}



