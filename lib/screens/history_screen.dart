import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:route_finder/models/search_history.dart';
import 'result_screen.dart';
extension StringExtension on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<SearchHistory> historyBox = Hive.box<SearchHistory>('searchHistory');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search History'),
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, Box<SearchHistory> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No search history yet.'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                SearchHistory history = box.getAt(index)!;
                return Card(
                  color: Colors.blue,
                  elevation: 1,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),

                    title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5,),
                            Text(history.startRoute.capitalize(),style: const TextStyle(color: Colors.white),),
                          ],
                        ),

                        const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: 5,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(history.endRoute.capitalize(),style: const TextStyle(color: Colors.white),),
                          Text(history.timeStamp.toString(),style: const TextStyle(color: Colors.white),),
                        ],)


                      ]),

                      ],
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                           builder: (context) => ResultScreen(startLocation: history.startRoute, endLocation: history.endRoute),

                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
