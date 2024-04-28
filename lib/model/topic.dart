class Topic{
  var topicName = '';
  var topicScore = 0;
  var topicList = [];

  Topic(this.topicName, this.topicList);

  Topic createList() {
    var topicDict = [];
    for (int i = 0; i < topicList.length; i++){
      topicDict.add({
        topicList[i].toString() : topicScore,
        'visited': 'No'
      });
    }
    return Topic(topicName, topicDict);
  }
}