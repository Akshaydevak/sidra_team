 import 'dart:async';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_address_picker/models/location_result.dart';
import 'package:share_plus/share_plus.dart';

import '../../common_widgets/gradient_button.dart';



class NewGoogleMap extends StatefulWidget {

  const NewGoogleMap({Key? key, }) : super(key: key);

  @override
  State<NewGoogleMap> createState() => _NewGoogleMapState();
}

class _NewGoogleMapState extends State<NewGoogleMap> {
  bool isLive=false;


  Completer<GoogleMapController> mapController = Completer();
  Position? _currentPosition;
  LatLng? _lastMapPosition;
  MapType? selectedMapType;
  BitmapDescriptor ?customIcon;

  _share(double logitude,double latitude){
   Share.share('https://www.google.com/maps/search/?api=1&query=$latitude,$logitude');
   print('https://www.google.com/maps/search/?api=1&query=$latitude,$logitude');
  }
  final Set<Marker> _markers = {

  };
  LocationResult? locationResult;

  // this also checks for location permission.
  Future<void> _initCurrentLocation() async {
    await _checkGeolocationPermission();
    Position? currentPosition;
    try {
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      currentPosition = null;
      // print(e);
    }

    if (mounted && currentPosition != null) {
      setState(() => _currentPosition = currentPosition);
    }
    if (currentPosition != null || _currentPosition != null) {
      _lastMapPosition = currentPosition == null
          ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
          : LatLng(currentPosition.latitude, currentPosition.longitude);
      setState(() {
        _markers.add(Marker(
          icon: customIcon!,
          markerId:const MarkerId("defaultMarker"),
          position: currentPosition == null
              ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
              : LatLng(currentPosition.latitude, currentPosition.longitude),
        ));
      });
    }

    if (_currentPosition != null){
      await moveToCurrentLocation(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude));}
  }

  Future moveToCurrentLocation(LatLng currentLocation) async {
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLocation, zoom: 16),
    ));
  }

  bool automaticallyAnimateToCurrentLocation = true;
  bool requiredGPS = true;
  LatLng initialCenter = const LatLng(28.612925, 77.229512);
  String address = 'turn on location';

  @override
  void initState() {
    if (automaticallyAnimateToCurrentLocation && !requiredGPS) {
      _initCurrentLocation();
    }
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(90, 90)),
        'assets/images/img.png')
        .then((d) {
      customIcon = d;
    });

    super.initState();
  }

  Future<void> getAddressFromLatLong(var position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    address = '${place.postalCode}, ${place.locality},${place.subLocality}';
    // Assets.deliveryAddress = address;
    // if (Variables.defaultAddress == "") {
    //   Variables.defaultAddress = address;
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    selectedMapType ??= MapType.normal;
    // final bool layersButtonEnabled = true;
    if (requiredGPS) {
      _checkGeolocationPermission();
      if (_currentPosition == null && automaticallyAnimateToCurrentLocation) {
        _initCurrentLocation();
      }
    }
    bool darkIcons = ((selectedMapType == MapType.hybrid) ||
        (selectedMapType == MapType.satellite));
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
          darkIcons ? Brightness.light : Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: darkIcons ? Colors.white : null,
        ),
        centerTitle: true,
        title:const Text(
          "Location",
          style: TextStyle(color: Colors.black),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        // color: Colors.grey,
        width: w,
        height: h,
        child: Stack(
          children: [
            GoogleMap(
              mapType: selectedMapType ?? MapType.normal,
              initialCameraPosition: CameraPosition(
                target: initialCenter,
                zoom: 200,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);

                _markers.add(Marker(
                  markerId:const MarkerId("defaultMarker"),
                  position: initialCenter,
                  icon: customIcon!,
                ));

                _lastMapPosition = initialCenter;
              },
              markers: _markers,
              onTap: (argument) {
                _lastMapPosition = argument;

                setState(() {
                  getAddressFromLatLong(_lastMapPosition);
                  _markers.add(Marker(
                    markerId:const MarkerId("defaultMarker"),
                    position: argument,
                    icon: customIcon!,
                  ));
                });
              },
              onLongPress: (argument) {
                _lastMapPosition = argument;

                setState(() {
                  getAddressFromLatLong(_lastMapPosition);
                  _markers.add(Marker(
                    markerId:const MarkerId("defaultMarker"),
                    position: argument,
                    icon: customIcon!,
                  ));
                });
              },
              onCameraIdle: () async {
                getAddressFromLatLong(_lastMapPosition);
                // print("onCameraIdle#_lastMapPosition = $_lastMapPosition");
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              padding:const EdgeInsets.only(
                bottom: kBottomNavigationBarHeight + 60,
              ),
            ),

            Positioned(
                bottom: 0,
                left: 0,
                child: Column(
                  children: [
                    Container(
                      padding:const EdgeInsets.only(right: 20,bottom: 20),
                      // margin: EdgeInsets.only(right: 20,bottom: 10),
                      width: w,
                      alignment: Alignment.bottomRight,

                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 0.2,
                        onPressed: _initCurrentLocation,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        mini: true,
                        heroTag: "layers2",
                        child: const Icon(Icons.gps_fixed,color: Colors.black,),
                      ),
                    ),

                    Container(
                       padding: EdgeInsets.only(top: 30),
                      width: w,
                      height: h / 4,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child:isLive? Column(
                        children: [

                          Container(
                            padding: EdgeInsets.only(left: 16,right:16),
                            child: GradientButton(
                                color:Color(0xfffe5762) ,
                                onPressed: () {


                                },
                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
                                child: Text(
                                  "Share this Location",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          SizedBox(height: 10,),


                        ],
                      ): Column(
                        children: [

                          Container(
                            padding: EdgeInsets.only(left: 16,right:16),
                            child: GradientButton(
                              color:Color(0xfffe5762) ,
                                onPressed: () {
                                  print("LATITUDE${_lastMapPosition?.latitude}");
                                  print("${_lastMapPosition?.longitude}");
                                  _share(_currentPosition?.latitude??0.0,_currentPosition?.longitude??0.0);

                                },
                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
                                child: Text(
                                  "Share this Location",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 16,right:16),
                            child: GradientButton(
                                color:Color(0xfffe5762) ,
                                onPressed: () {
                                  print("LATITUDE${_lastMapPosition?.latitude}");
                                  print("${_lastMapPosition?.longitude}");
                                  _share(_lastMapPosition?.latitude??0.0,_lastMapPosition?.longitude??0.0);
                                },
                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Colors.white,  Colors.white]),
                                child: Text(
                                  "Share Live Location",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),

                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  var dialogOpen;

  Future _checkGeolocationPermission() async {
    await Geolocator.requestPermission();
    final geolocationStatus = await Geolocator.checkPermission();
    // print("geolocationStatus = $geolocationStatus");

    if (geolocationStatus == LocationPermission.denied && dialogOpen == null) {
      dialogOpen = _showDeniedDialog();
    } else if (geolocationStatus == LocationPermission.deniedForever &&
        dialogOpen == null) {
      dialogOpen = _showDeniedForeverDialog();
    } else if (geolocationStatus == LocationPermission.whileInUse ||
        geolocationStatus == LocationPermission.always) {
      // print('GeolocationStatus.granted');

      if (dialogOpen != null) {
        Navigator.of(context, rootNavigator: true).pop();
        dialogOpen = null;
      }
    }
  }

  Future _showDeniedDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
            return true;
          },
          child: AlertDialog(
            title:const Text('Access to location denied'),
            content:const Text('Allow access to the location services.'),
            actions: <Widget>[
              TextButton(
                child:const Text('Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  _initCurrentLocation();
                  dialogOpen = null;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _showDeniedForeverDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
            return true;
          },
          child: AlertDialog(
            title:const Text(
              'Access to location permanently denied',
            ),
            content:const Text(
              'Allow access to the location services for this App using the device settings.',
            ),
            actions: <Widget>[
              TextButton(
                child:const Text('Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Geolocator.openAppSettings();
                  dialogOpen = null;
                },
              ),
            ],
          ),
        );
      },
    );

  }
}
