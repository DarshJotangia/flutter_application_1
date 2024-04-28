import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/display_score.dart';
import 'package:flutter_application_1/model/topic_preset.dart';
import 'package:flutter_application_1/new_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // void _newpage(){
  //   Navigator.push(
  //     context as BuildContext, 
  //     MaterialPageRoute(builder: (context) => const NewPage()));
  // }

  @override
  Widget build(BuildContext context) {
    // print(topicLists.first);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  
      ListView.builder(
        itemCount: topicLists.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: () {
            Navigator.push(
              context, 
              // MaterialPageRoute(builder: (context)=> DisplayScore(topicLists[index])));
              MaterialPageRoute(builder: (context)=> NewPage(topicLists[index])));
            },
            title: Text(topicLists[index].topicName) ,
          );

          // return FloatingActionButton(
          //   onPressed: () {
          //   Navigator.push(
          //     context, 
          //     MaterialPageRoute(builder: (context)=> DisplayScore(topicLists[index])));
          //   },
          //   child: Text(topicLists[index].topicName));
        }),
    );
  }


}

// List<Widget> _render(List<Topic> topicLists, BuildContext context) {
//   List<Widget> topics = [];
//   for (int i = 0; i< topicLists.length; ){
//       topics.add(
//         FloatingActionButton(
//           onPressed: () {
//              Navigator.push(
//                context, 
//                MaterialPageRoute(builder: (context)=> DisplayScore(topicLists[i])));
//              },
//           child: Text(topicLists[i].topicName)));
//   }
//   return topics;
// }
