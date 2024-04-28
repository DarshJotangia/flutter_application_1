
import 'package:flutter/material.dart';
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
    return const MaterialApp(
      title: 'HeaD\'s Up',
      // theme: ThemeData(
      //   scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: MyHomePage(title: 'HeaD\'s Up'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body:  
      ListView.builder(
        itemCount: topicLists.length ,
        itemBuilder: (context, index){
          // if (index >= topicLists.length){
          //   return ListTile(
          //     onTap: () {
          //     Navigator.push(
          //       context, 
          //       MaterialPageRoute(builder: (context)=> const CreateCustom()));
          //     },
          //     title: const Text("Custom"),
          //   );
          // }
          return ListTile(
            onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> NewPage(topicLists[index])));
            },
            title: Text(topicLists[index].topicName),
          );
        }),
    );
  }
}

