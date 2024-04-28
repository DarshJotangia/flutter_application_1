import "package:flutter_application_1/model/topic.dart";

var sample = Topic("Sample", ['A','B','Stack']);
var sampleA = Topic("Sample_A", ['A','B','C']);

List<Topic> topicLists = [
  sample.createList(),
  sampleA.createList()
  ];