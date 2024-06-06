
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/topic.dart';
import 'package:flutter_application_1/model/topic_preset.dart';

class CreateCustom extends StatefulWidget {
  final Topic topicList;
  const CreateCustom(this.topicList, {super.key, });

  @override
  State<CreateCustom> createState() => CreateCustomState();
}

class CreateCustomState extends State<CreateCustom> {
  var customTopicName = TextEditingController();
  var controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 2*(MediaQuery.sizeOf(context).width)/3,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(controller: controller)),
                    FloatingActionButton(
                      heroTag: const Text("Add"),
                    
                      onPressed: (){
                        topicLists.add(controller as Topic);
                    })
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: topicLists.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(topicLists[index].topicName),
                );
              }),
          ],
        ),
      ),
    );
  }
}