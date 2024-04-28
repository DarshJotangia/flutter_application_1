import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/topic.dart';

class DisplayScore extends StatefulWidget{
  
  final Topic topic;
  const DisplayScore(this.topic, {super.key});
  
  @override
  DisplayScoreState createState() => DisplayScoreState(); 
}

class DisplayScoreState extends State<DisplayScore>{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: ListView.builder(
        itemCount: widget.topic.topicList.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(widget.topic.topicList[index].keys.toString()),
            subtitle: Text(widget.topic.topicList[index].values.toString()),
            );
        }),
    );
  }
}