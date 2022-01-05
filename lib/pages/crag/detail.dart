import 'package:pitcher/models/crag.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:location/location.dart';
import 'package:pitcher/reusables/button.dart';
import 'package:pitcher/pages/climb/list.dart' as climbinglist;
import 'package:pitcher/reusables/content_title.dart';
import 'package:pitcher/reusables/creator_title.dart';

class WidgetArguments {
  final Crag? crag;

  WidgetArguments({
    required this.crag,
  });
}

class CragDetailView extends StatefulWidget {
  const CragDetailView({Key? key}) : super(key: key);

  @override
  _CragDetailViewState createState() => _CragDetailViewState();
}

class _CragDetailViewState extends State<CragDetailView> {
  bool initialLoad = true;
  bool distanceLoaded = false;
  bool _likedByUser = false;
  double distance = 0;
  late Crag crag;
  int routeCount = 0;
  int boulderCount = 0;
  late MapboxMapController _controller;

  void _getDistance() async {
    const ll.Distance distance = ll.Distance();
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          distanceLoaded = true;
        });
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          distanceLoaded = true;
        });
        return;
      }
    }
    var _locationData = await location.getLocation();

    var meter = distance(
        ll.LatLng(_locationData.latitude!, _locationData.longitude!),
        ll.LatLng(crag.location.lat, crag.location.long));
    setState(() {
      distanceLoaded = true;
      this.distance = meter;
    });
  }

  Future _loadClimbs() async {
    await crag.loadClimbs();
    setState(() {
      crag = crag;
    });
    return;
  }

  Future _calculateClimbTypeCount() async {
    crag.setClimbCount();
    setState(() {
      routeCount = crag.routeCount;
      boulderCount = crag.boulderCount;
    });
    return;
  }

  void _addClimb() async {
    await Navigator.pushNamed(context, "/addclimb",
        arguments: WidgetArguments(crag: crag));
    setState(() {
      crag = crag;
    });
    await _calculateClimbTypeCount();
  }

  void _showRoutes() {
    var climbs = crag.getRoutes();
    if (climbs.isNotEmpty) {
      Navigator.pushNamed(context, "/climbinglist",
          arguments: climbinglist.PageArgs(climbs: climbs));
    } else {
      const snackBar = SnackBar(
        content: Text('There are no routes in this crag yet'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _showBoulders() {
    var climbs = crag.getBoulders();
    if (climbs.isNotEmpty) {
      Navigator.pushNamed(context, "/climbinglist",
          arguments: climbinglist.PageArgs(climbs: climbs));
    } else {
      const snackBar = SnackBar(
        content: Text('There are no boulders in this crag yet'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _getDistance();
      await _loadClimbs();
      await _calculateClimbTypeCount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (initialLoad) {
      final args =
          ModalRoute.of(context)!.settings.arguments as WidgetArguments;
      var initialCrag = args.crag!;
      setState(() {
        initialLoad = false;
        crag = initialCrag;
      });
    }

    var location = crag.location;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.transparent,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/placeholdercrag.png"),
            Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 40.0, 60.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContentTitle(title: crag.name),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          CreatorText(
                            username: crag.creator.username,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                          child: IconButton(
                            icon: Icon(_likedByUser
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () {
                              setState(() {
                                _likedByUser = !_likedByUser;
                              });
                            },
                            color: Colors.redAccent,
                          ),
                        ),
                        Text("${crag.likes.length}",
                            style: const TextStyle(
                              fontSize: 20.0,
                            )),
                      ],
                    )
                  ],
                )),
            Container(
              height: 5,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(crag.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 15.0,
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: _showBoulders,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Boulders"),
                                Container(
                                    child: Text("$boulderCount"),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                        5.0, 0, 0, 0)),
                                const Icon(Icons.chevron_right),
                              ],
                            )),
                        OutlinedButton(
                            onPressed: _showRoutes,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Routes"),
                                Container(
                                    child: Text("$routeCount"),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                        5.0, 0, 0, 0)),
                                const Icon(Icons.chevron_right),
                              ],
                            )),
                        FullWidthButton(
                            buttonText: "add climb to crag",
                            action: () {
                              _addClimb();
                            },
                            active: distanceLoaded && distance < 50)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 300,
              child: MapboxMap(
                accessToken:
                    "pk.eyJ1IjoiZGFubnlib3k2OSIsImEiOiJja3dqbjBxaXUxN2tmMzFwYjh3djNqcWtqIn0.1lFMkFQYnV4gh2UgbXZtZA",
                styleString:
                    "mapbox://styles/dannyboy69/cky1slv64hu0n15qzs6dxgdc6",
                initialCameraPosition: CameraPosition(
                  target: LatLng(location.lat, location.long),
                  zoom: 11,
                ),
                onStyleLoadedCallback: () async {
                  await _controller.addSymbol(SymbolOptions(
                    iconImage: "assets/logo.png",
                    iconOpacity: 0.8,
                    textField: crag.name,
                    textAnchor: "bottom",
                    textOffset: const Offset(0, 2),
                    iconSize: 0.2,
                    geometry: LatLng(crag.location.lat, crag.location.long),
                    draggable: false,
                  ));
                },
                onMapCreated: (MapboxMapController controller) {
                  _controller = controller;
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
