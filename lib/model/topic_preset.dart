import "package:flutter_application_1/model/topic.dart";

var sample = Topic("Hollywood Movies", ['A','B','Stack']);
var sampleA = Topic("Bollywood Movies", ['A','B','C']);
var custom = Topic ("Custom",[]);

List<Topic> topicLists = [
  sample.createList(),
  sampleA.createList(),
  custom.createList()
  ];