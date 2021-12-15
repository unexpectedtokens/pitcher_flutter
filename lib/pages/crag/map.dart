import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pitcher/models/crag.dart';

import 'detail.dart';

class CragMapView extends StatefulWidget {

  final List<Crag> crags;
  const CragMapView({
    Key? key,
    required this.crags,
  }) : super(key: key);

  @override
  _CragMapViewState createState() => _CragMapViewState();
}

class _CragMapViewState extends State<CragMapView> {

  late MapboxMapController _controller;


  void _onSymbolTapped(Symbol symbol){

    var id = int.parse(symbol.data!["id"].toString());
    var crag = widget.crags.singleWhere((element) => element.id == id );
    print("tapped!");
    Navigator.pushNamed(
      context,
      "/cragdetail",
      arguments: WidgetArguments(crag: crag),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: "pk.eyJ1IjoiZGFubnlib3k2OSIsImEiOiJja3dqbjBxaXUxN2tmMzFwYjh3djNqcWtqIn0.1lFMkFQYnV4gh2UgbXZtZA",
      styleString: "mapbox://styles/dannyboy69/ck1gql4tc3emw1dnwb2x5zcxc",
      initialCameraPosition: const CameraPosition(
        target: LatLng(52.377956, 4.897070),
        zoom: 2,


      ),

      onMapCreated: (MapboxMapController controller){
        _controller = controller;
        _controller.onSymbolTapped.add(_onSymbolTapped);

      },

      onStyleLoadedCallback: ()async{
        for(var c in widget.crags){
          await _controller.addSymbol(
              SymbolOptions(

                iconImage: "assets/logo.png",
                iconOpacity: 0.8,
                //textField: c.name,
                textAnchor: "bottom",
                textOffset: const Offset(
                    0, 2
                ),
                iconSize: 0.2,
                geometry: LatLng(
                    c.location.lat,
                    c.location.long
                ),
                draggable: false,
                zIndex: 1,

              ),
            {
                "id": c.id
            },

          );


        }
      },
    );
  }
}
