import 'dart:async';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/display_score.dart';
import 'package:flutter_application_1/model/topic.dart';
import 'package:sensors_plus/sensors_plus.dart';
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
  Timer? _timer;
  Color bgcolor = Colors.blueAccent;
  int _remainingSeconds = 10;
  var i = 0;
  String deviceType = ''; 
  @override
  void initState() {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    

    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_remainingSeconds <= 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });

    super.initState();
    // ignore: deprecated_member_use
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Update the _accelerometerValues list with the latest event
        _accelerometerValues = [event];
      });
    });
  }

  Widget _pass(iterList, valueRec) {
    _bgcolor('red');
    i++;
    _scoreUpdate(iterList, valueRec);
    Future.delayed(Durations.long4).then((value) => _bgcolor("blue"));
    return const Text("Pass");
  }

  Widget _match(iterList, valueRec)  {
    _bgcolor('green');
    i++;
    _scoreUpdate(iterList, valueRec);
    Future.delayed(Durations.long4).then((value) => _bgcolor("blue"));
    return const Text('Match');
  }


  @override
  void dispose() {
    // Cancel the accelerometer event subscription to prevent memory leaks
    _accelerometerSubscription.cancel();
    _timer?.cancel();
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
    var topic = widget.topicList;
    var iterList = topic.topicList;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color : bgcolor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if ( i < iterList.length && _remainingSeconds != 0)
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Text('$_remainingSeconds'.toString()),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(iterList[i].keys.first.toString()),
                      )
                    ],
                  ),
                ),
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
                  if (_accelerometerValues.isNotEmpty && _accelerometerValues[0].z > 6 && i < iterList.length && _remainingSeconds != 0)
                    _pass(iterList[i], 0)
                  else if (_accelerometerValues.isNotEmpty && _accelerometerValues[0].z <-6 && i < iterList.length && _remainingSeconds != 0)
                    _match(iterList[i], 1)
                  else
                    FloatingActionButton(
                      onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=> DisplayScore(topic)));
                      },
                      child: const Text('Got To Scores')
                    ),
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
}