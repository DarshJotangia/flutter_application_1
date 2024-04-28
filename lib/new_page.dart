import 'dart:async';
import 'dart:js_interop_unsafe';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/topic.dart';
import 'package:flutter_application_1/model/topic_preset.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'display_score.dart';

class NewPage extends StatefulWidget {
  final Topic topicList;
  const NewPage(this.topicList, {super.key});

  @override
  NewPageState createState() => NewPageState();
}

class NewPageState extends State<NewPage> {
  List<AccelerometerEvent> _accelerometerValues = [];

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  Color bgcolor = Colors.blueAccent;

  var i = 0;
  @override
  void initState() {

    if (_accelerometerValues.isNotEmpty) {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    }


    super.initState();
    // ignore: deprecated_member_use
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Update the _accelerometerValues list with the latest event
        _accelerometerValues = [event];
      });
    });
  }

  Widget _pass(iterList, value){
    _bgcolor('red');
    i++;
    _scoreUpdate(iterList, value);
    return const Text('Pass');
  }

  Widget _match(iterList, value){
    _bgcolor('green');
    i++;
    _scoreUpdate(iterList, value);
    return const Text('Match');
  }

  Widget _next(){
    _bgcolor('blue');
    return const Text('No data available', style: TextStyle(fontSize: 16));
  }

  @override
  void dispose() {
    // Cancel the accelerometer event subscription to prevent memory leaks
    _accelerometerSubscription.cancel();
    super.dispose();
  }
void _bgcolor(value){
  if(value == 'red'){
    setState(() {
      bgcolor = Colors.redAccent;
    }); 
  }else if (value == 'green'){
    setState(() {
      bgcolor = Colors.greenAccent;
    });
  }else if (value == 'blue'){
    setState(() {
      bgcolor = Colors.blueAccent;
    });
  }
}
String deviceType = ''; 
String checkDeviceType(DeviceInfoPlugin deviceInfom){
  deviceInfom.deviceInfo.then((value){
      if (value.data.keys.contains("utsname.sysname")){
          deviceType = "iOS";
      }else if (value.data.keys.contains("supportedAbis")){
          deviceType = 'Android';
      }
    });
  return deviceType;
}

  @override
  Widget build(BuildContext context) {
    var Topic = widget.topicList;
    var iterList = Topic.topicList;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color : bgcolor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if ( i < iterList.length)
                SizedBox(
                  height: 20,
                  child: Text(iterList[i].toString()),
                )
              else
                FloatingActionButton(
                  onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> DisplayScore(Topic)));
                  },
                  child: const Text('Got To Scores')),
              if (checkDeviceType(deviceInfo) == '')  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "Pass",
                      child: const Text("Pass"),
                      onPressed: (){
                      setState(() {
                        _pass(iterList[i], 0);
                      });
                    }),
                    FloatingActionButton(
                      heroTag: "Match",
                      child: const Text("Match"),
                      onPressed: (){
                        setState(() {
                          _match(iterList[i], 1);
                        });
                    }),
                  ],
                )
              else
                if (_accelerometerValues.isNotEmpty && _accelerometerValues[0].z > 3)
                  _pass(iterList[i], 0)
                else if (_accelerometerValues.isNotEmpty && _accelerometerValues[0].z <-5)
                  _match(iterList[i], 1)
            ],
          ),
        ),
      ),
    );
  }
}

void _scoreUpdate(Map iterList, int recvalue) {
  for (var element in iterList.keys) { 
      if (element == 'visited'){
        iterList.update(element, (value) => 'Yes');
      }else{
        iterList.update(element, (value) => recvalue);
      }
    }
  print(iterList);
}