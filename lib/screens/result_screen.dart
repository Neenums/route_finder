// screens/results_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:route_finder/screens/helpers/location_service.dart';
import '../models/search_history.dart';

class ResultScreen extends StatefulWidget {
  final String startLocation;
  final String endLocation;

  const ResultScreen({super.key, required this.startLocation, required this.endLocation});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  MapboxMapController? mapController;
  final LocationService locationService=LocationService();
  LatLng?startLatLng;
  LatLng?endLatLng;
  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }
  Future<void>_fetchLocations() async{
    final startLocation= await locationService.getLocationFromAddress(widget.startLocation);
    final endLocation= await locationService.getLocationFromAddress(widget.endLocation);
    if(startLocation!=null && endLocation!=null) {
      setState(() {
        startLatLng = LatLng(startLocation.latitude, startLocation.longitude);
        endLatLng = LatLng(endLocation.latitude, endLocation.longitude);
      });
      mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(startLatLng!, 12.0));
      _drawRoute();

    }
    else{
      Get.snackbar('Error','Failed to fetch locations');
    }
  }

  Future<void>_drawRoute() async{
    if(startLatLng!=null && endLatLng!=null){
      final routeCoordinates=[startLatLng!,endLatLng!];
      mapController?.addLine(LineOptions(geometry: routeCoordinates,lineColor: "#FF0000",lineWidth: 2.0));
    }
  }
  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;

  }

  void _saveSearch() async {
    var box = await Hive.openBox<SearchHistory>('searchHistory');
    box.add(SearchHistory(widget.startLocation, widget.endLocation, DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(
        child: Column(children: [
          const Card(
            color: Colors.blueAccent,
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Center(
                      child: Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Robert Doe",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("robertdoe@gmail.com",style: TextStyle(fontSize: 13),)],)
                ],
              ),
            )),startLatLng==null || endLatLng==null?const Align(alignment:Alignment.center,child: CircularProgressIndicator(),) :Column(
          children: [
            Expanded(
              child: MapboxMap(
                accessToken: 'sk.eyJ1IjoiYWtoaWxsZXZha3VtYXIiLCJhIjoiY2x4MDcxM3JlMGM5YTJxc2Q1cHc4MHkyZSJ9.awWNy5HErR8ooOddFDR6Gg',
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 12.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _saveSearch,
              child: const Text('Save'),
            ),
          ],
        ),
        ],),
      )

    );
  }
}
