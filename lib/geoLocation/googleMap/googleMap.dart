import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheet_widget_demo/geoLocation/googleMap/choosePlacePage/choosedestinationPage.dart';
import 'package:sheet_widget_demo/geoLocation/googleMap/choosePlacePage/yourLocationPage.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Set<Marker> markers = Set();
  Position _currentPosition;
  String _currentAddress;
  GoogleMapController mapController;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String _placeDistance;
  String yourLocation;
  String chooseLocation;

  @override
  void initState() {
    _getCurrentLocation();
    // _getAddressFromLatLng();
    polylinePoints = PolylinePoints();
    super.initState();
  }

  setPolylines(startLat, startLon, desLat, desLon) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyB_kIX5UrOzY9KC14LVNRAIsZCkx3xBXeA",
        PointLatLng(startLat, startLon),
        PointLatLng(desLat, desLon));
    print("result-->" + result.status);
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: darkBlue,
            points: polylineCoordinates));
      });
    }
  }

  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(yourLocation);
      List<Location> destinationPlacemark =
          await locationFromAddress(chooseLocation);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = yourLocation == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = yourLocation == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: yourLocation,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: chooseLocation,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      await setPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    print("currant page -->$runtimeType");
    return Scaffold(
        body: (_currentPosition?.latitude == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    child: GoogleMap(
                        myLocationEnabled: true,
                        markers: markers,
                        polylines: _polylines,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference(0, 17),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(_currentPosition?.latitude,
                                _currentPosition?.longitude),
                            zoom: 10,
                            tilt: 20)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50.0, left: 10, right: 10),
                    child: Container(
                      height: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: grey.shade100),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.adjust,
                                    color: themeColor,
                                  ),
                                  Icon(
                                    Icons.height,
                                    color: grey,
                                    size: 30,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: red,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    String choosePlace = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChoosePlacePage(),
                                        ));
                                    yourLocation = choosePlace;
                                    setState(() {});
                                    print(choosePlace);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: grey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text((yourLocation == "" ||
                                                  yourLocation == null)
                                              ? "Your Location"
                                              : yourLocation)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () async {
                                    String chooseDestination =
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChooseDestinationPage(),
                                            ));
                                    chooseLocation = chooseDestination;
                                    setState(() {});
                                    print(chooseDestination);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: grey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text((chooseLocation == "" ||
                                                  chooseLocation == null)
                                              ? "Choose destination"
                                              : chooseLocation)),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      if (markers.isNotEmpty) markers.clear();
                                      if (_polylines.isNotEmpty)
                                        _polylines.clear();
                                      if (polylineCoordinates.isNotEmpty)
                                        polylineCoordinates.clear();
                                      _placeDistance = null;
                                      _calculateDistance();
                                      setState(() {});
                                    },
                                    color: themeColor,
                                    child: Text("route"))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];
      print(place.country);
      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() async {
    EasyLoading.show();
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        EasyLoading.dismiss();
        _currentPosition = position;
        print(_currentPosition);
        _getAddressFromLatLng();
        markers.add(Marker(
            markerId: MarkerId("1"),
            position:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            infoWindow: InfoWindow(title: _currentAddress)));
      });
    }).catchError((e) {
      EasyLoading.dismiss();
      print(e);
    });
    setState(() {});
  }
}
