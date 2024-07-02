import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:route_finder/models/search_history.dart';
import 'package:route_finder/screens/history_screen.dart';
import 'package:route_finder/screens/result_screen.dart';


class HomeScreen extends StatelessWidget {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
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
                      )),
              
                    Container(padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _startController,
                        decoration: const InputDecoration(
                          prefixIcon:    Icon(Icons.location_on_outlined),
                          labelText: 'Start Location',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
              
                    Container(padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _endController,
                        decoration: const InputDecoration(
                          prefixIcon:    Icon(Icons.location_on_outlined),
                          labelText: 'End Location',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
              
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String start = _startController.text;
                      String end = _endController.text;
                      if (start.isNotEmpty && end.isNotEmpty) {
                        Box<SearchHistory> historyBox =
                        Hive.box<SearchHistory>('searchHistory');
                        historyBox.add(SearchHistory(
                          start,
                          end,
                          DateTime.now(),
                        ));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(startLocation: _startController.text, endLocation: _endController.text),

                            ) );
                      }
                    },
                    child: const Text('Navigate'),
                  ),
                  ElevatedButton(
                      onPressed:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HistoryScreen(),

                            ) );
                      },child:const Text("Saved"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
