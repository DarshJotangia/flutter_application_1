
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/topic.dart';

class DisplayScore extends StatefulWidget{
  
  final Topic topic;
  const DisplayScore(this.topic, {super.key});
  
  @override
  DisplayScoreState createState() => DisplayScoreState(); 
}

class DisplayScoreState extends State<DisplayScore>{

  var displayList = [];
  var displayScore = [];
  var iconState = [];
  var totalScore = 0;
  @override
  Widget build(BuildContext context){
    var topic = widget.topic.topicList;
    for (Map<String, dynamic> element in topic){
      if (element['visited'] == 'Yes'){
        var name = element.keys.first;
        var score = element.values.first;
        displayList.add(name);
        displayScore.add(score);
        if (score == 1){
          iconState.add(const Icon(
            Icons.done,
            color: Colors.greenAccent,
            ));
            totalScore++;
        }
        else{
          iconState.add(const Icon(
            Icons.close,
            color: Colors.redAccent,
            ));
        }
      }
    }
    return Scaffold(
      body: Column(
        children: [
          Text(totalScore.toString()),
          Expanded(
            child: ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: iconState[index],
                  title: Text(displayList[index].toString()),
                  );
              }),
          ),
          FloatingActionButton(
            heroTag: "Home",
            onPressed:() {
              Navigator.push(
               context , 
                MaterialPageRoute(builder: (context) => const MyApp()));
          },
            child: const Text("Back to Home"))
        ],
      ),
    );
  }
}