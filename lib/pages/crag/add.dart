import 'package:flutter/material.dart';
import 'package:pitcher/models/climber.dart';
import 'package:pitcher/reusables/button.dart';
import 'package:pitcher/models/crag.dart';
import 'package:pitcher/models/location.dart' as model_location;
import 'package:pitcher/util/main.dart';
import 'package:location/location.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AddCrag extends StatefulWidget {
  const AddCrag({Key? key}) : super(key: key);
  @override
  _AddCragState createState() => _AddCragState();
}

class _AddCragState extends State<AddCrag> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool valid = false;
  bool loading = true;
  late LocationData _locationData;

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

    _initLocation();
    super.initState();
  }



  void _navigateBack(){
    Navigator.pop(context);
  }

  void _submitCrag() async{
    var crag = Crag(
        creator: Climber.returnMockClimber(),
        name: _nameController.text,
        description: _descriptionController.text,
        location: model_location.Location(
            lat: _locationData.latitude!,
            long: _locationData.longitude!
        )
    );
    await crag.insert();
    _navigateBack();
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
                            "Create a new crag",
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
                                  "Name of the crag"
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
                            margin: const EdgeInsets.all(20.0),
                          ),
                          FullWidthButton(
                            buttonText: "Save crag",
                            action: _submitCrag,
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



