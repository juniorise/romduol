import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:geolocator/geolocator.dart';
import 'package:romduol/widget/theme/theme.dart';

class GoogleMapTemplate extends StatefulWidget {
  GoogleMapTemplate({Key key, this.maplocation, this.buslocation})
      : super(key: key);
  final GeoPoint maplocation, buslocation;
  @override
  _GoogleMapTemplateState createState() => _GoogleMapTemplateState();
}

class _GoogleMapTemplateState extends State<GoogleMapTemplate> {
  GoogleMapController _googleMapController;
  LatLng _yourLocation;
  LatLng _maplocation, _buslocation;
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
    if (_yourLocation != _maplocation) {
      moveCameraTo(_yourLocation);
    }
  }

  @override
  void initState() {
    _maplocation = _yourLocation =
        LatLng(widget.maplocation.latitude, widget.maplocation.longitude);
    _buslocation = widget.buslocation != null
        ? LatLng(widget.buslocation.latitude, widget.buslocation.longitude)
        : null;

    addMarker(location: _maplocation, title: "Destination");
    addCircle(_maplocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "ផែនទី"),
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
              target: _maplocation,
              zoom: 11.0,
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: buttonCard(
              icon: Icons.location_pin,
              onPressed: () {
                addCircle(_maplocation);
                moveCameraTo(_maplocation);
              },
            ),
          ),
          Positioned(
            top: 12.0 * (1 + 4 * 1),
            right: 12,
            child: buttonCard(
              icon: Icons.gps_fixed,
              onPressed: checkYourPosition,
            ),
          ),
          Positioned(
            top: 12.0 * (1 + 4 * 2),
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
          ),
          widget.buslocation != null
              ? Positioned(
                  top: 12.0 * (1 + 4 * 3),
                  right: 12,
                  child: buttonCard(
                    icon: Icons.bus_alert,
                    onPressed: () {
                      addMarker(
                        location: _buslocation,
                        title: "Bus location",
                        snippet: "Open Google Map for direction to bus stop",
                      );
                      moveCameraTo(_buslocation);
                      addCircle(_buslocation);
                    },
                  ),
                )
              : SizedBox()
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
    Circle circle = Circle(
      circleId: CircleId(location.toString()),
      radius: 500,
      center: location,
      strokeColor: Palette.sky,
      fillColor: Palette.sky.withOpacity(0.3),
      strokeWidth: 1,
    );

    if (!circles.contains(circle)) circles.add(circle);
  }

  void addCircles() async {
    _yourLocation = await _getCurrentLocation();
  }

  void addMarker({LatLng location, String title, String snippet}) {
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
}
