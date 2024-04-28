
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateCustom extends StatefulWidget {
  const CreateCustom({super.key});

  @override
  State<CreateCustom> createState() => CreateCustomState();
}

class CreateCustomState extends State<CreateCustom> {
  var customTopicName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            Text('Hello'),
            // Container(
            //   width: 2*(MediaQuery.sizeOf(context).width)/3,
            //   child: Expanded(child: TextField()),
            // )
          ],
        ),
      ),
    );
  }
}