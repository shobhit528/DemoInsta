import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:get/get.dart';



class MyGeoLocation extends StatefulWidget {
  MyGeoLocation({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyGeoLocationState createState() => _MyGeoLocationState();
}

class _MyGeoLocationState extends State<MyGeoLocation> {
  TextEditingController latitudeController = new TextEditingController();
  TextEditingController longitudeController = new TextEditingController();
  TextEditingController radiusController = new TextEditingController();

  String geofenceStatus = '';
  bool isReady = false;
  Coordinate? coordinate;
  @override
  void initState() {
    super.initState();
    Geofence.initialize();
    Geofence.requestPermissions();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter pointed latitude'),
            ),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter pointed longitude'),
            ),
            TextField(
              controller: radiusController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter radius in meter'),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("Start"),
                  onPressed: () {
                    print("starting geoFencing Service");
                    Geofence.getCurrentLocation().then((coordinate) {
                      print("Your latitude is ${coordinate?.latitude} and longitude ${coordinate?.longitude}");
                      setState((){
                        coordinate=coordinate;
                        latitudeController.text="${coordinate?.latitude}";
                        longitudeController.text="${coordinate?.longitude}";
                      });
                    });
                    Geofence.addGeolocation(Geolocation(latitude: coordinate?.latitude??0.000, longitude: coordinate?.longitude??0.0000, radius: 1, id: "id"), GeolocationEvent.entry).then((onValue) {
                      Get.snackbar("Georegion added", "Your geofence has been added!");
                      setState((){
                        geofenceStatus="started";
                      });
                    }).catchError((error) {
                      print("failed with $error");
                    });

                    Geofence.startListening(GeolocationEvent.entry, (entry) {
                      Get.snackbar("Entry of a georegion", "Welcome to: ${entry.id}");
                    });
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  child: Text("Stop"),
                  onPressed: () {
                    print("stop");
                    Geofence.removeGeolocation(Geolocation(latitude: coordinate?.latitude??0.000, longitude: coordinate?.longitude??0.0000, radius: 1, id: "id"), GeolocationEvent.entry).then((onValue) {
                      Get.snackbar("Georegion removed", "Your geofence has been removed!");
                      setState((){
                        geofenceStatus="stopped";
                      });
                    }).catchError((error) {
                      print("failed with $error");
                    });

                  },
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "Geofence Status: \n\n\n" + geofenceStatus,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    radiusController.dispose();
    super.dispose();
  }
}
