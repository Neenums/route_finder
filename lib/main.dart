import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:route_finder/screens/home_screen.dart';
import 'models/search_history.dart';

void main() async{
  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(SearchHistoryAdapter().typeId)){
    Hive.registerAdapter(SearchHistoryAdapter());
    await Hive.openBox<SearchHistory>('searchHistory');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen()
    );
  }
}


