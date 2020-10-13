import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapTemplate extends StatefulWidget {
  GoogleMapTemplate({Key key}) : super(key: key);

  @override
  _GoogleMapTemplateState createState() => _GoogleMapTemplateState();
}

class _GoogleMapTemplateState extends State<GoogleMapTemplate> {
  GoogleMapController _googleMapController;
  LatLng _yourLocation;
  LatLng _destination;
  bool isOpenPermission = false;
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  Set<Circle> circles = {};

  void moveCameraTo(LatLng des) async {
    await _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(des.latitude, des.longitude),
          zoom: 12.0,
        ),
      ),
    );
  }

  //GEOLOCATOR
  Future<LatLng> _getCurrentLocation() async {
    Position _position;
    await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _position = position;
    }).catchError((e) {
      print(e);
    });

    setState(() => isOpenPermission = true);
    return LatLng(_position.latitude, _position.longitude);
  }

  void checkYourPosition() async {
    _yourLocation = await _getCurrentLocation();
    if (_yourLocation != _destination) {
      addCircle(_yourLocation);
      moveCameraTo(_yourLocation);
    }
  }

  @override
  void initState() {
    _destination = _yourLocation = const LatLng(11.562450, 104.916010);
    addMarker(location: _destination, title: "Destination");
    moveCameraTo(_destination);
    addCircle(_destination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "ផែនទី"),
      body: Stack(
        children: [
          GoogleMap(
            mapType: _currentMapType ?? MapType.normal,
            compassEnabled: true,
            markers: _markers,
            circles: circles,
            myLocationButtonEnabled: false,
            myLocationEnabled: isOpenPermission,
            onMapCreated: (controller) => setState(
              () => _googleMapController = controller,
            ),
            initialCameraPosition: CameraPosition(
              target: _destination,
              zoom: 11.0,
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: buttonCard(
              icon: Icons.location_pin,
              onPressed: () => moveCameraTo(_destination),
            ),
          ),
          Positioned(
            top: 12.0 * (1 + 4),
            right: 12,
            child: buttonCard(
              icon: Icons.gps_fixed,
              onPressed: checkYourPosition,
            ),
          ),
          Positioned(
            top: 12.0 * (5 + 4),
            right: 12,
            child: buttonCard(
              icon: Icons.map,
              onPressed: () {
                setState(() {
                  if (_currentMapType != MapType.satellite)
                    _currentMapType = MapType.satellite;
                  else
                    _currentMapType = MapType.normal;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Container buttonCard({IconData icon, Function onPressed}) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 1,
          spreadRadius: 0,
          offset: Offset(0, 0.1),
        )
      ]),
      child: FlatButton(
        highlightColor: Colors.grey.withOpacity(0.2),
        hoverColor: Colors.transparent,
        focusColor: Colors.grey,
        color: Colors.white.withOpacity(0.8),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Icon(
          icon,
          color: Colors.black.withOpacity(0.6),
          size: 18,
        ),
      ),
    );
  }

  void addCircle(LatLng location) {
    circles = Set.from(
      [
        Circle(
          circleId: CircleId(location.toString()),
          radius: 500,
          center: _yourLocation,
          strokeColor: Palette.sky,
          fillColor: Palette.sky.withOpacity(0.3),
          strokeWidth: 1,
        ),
      ],
    );
  }

  void addCircles() async {
    _yourLocation = await _getCurrentLocation();
  }

  void addMarker(
      {LatLng location, String title, String snippet, bool isDes = false}) {
    setState(
      () {
        _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(location.toString()),
            position: location,
            infoWindow: InfoWindow(
              title: title,
              snippet: location.latitude.toString() +
                  ", " +
                  location.longitude.toString(),
              onTap: () {},
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      },
    );
  }

  PreferredSize buildAppBar(BuildContext context, String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        title: Text(title, textAlign: TextAlign.start),
      ),
    );
  }
}
