//
// My second dart class
//

part of penguinmodel;

class Queue {

  int _id = null;
  String _name = null;
  List<Story> _stories = [];

  // Constructors
  Queue({int id, String name}) {
    _id = id;
    _name = name;
  }

  Queue.fromJson(Map aMap) {
    _id = aMap['id'];
    _name = aMap['name'];
    aMap['stories'].forEach((Map<String, Object> aMap){
      _stories.add(new Story.fromJson(aMap));
    });
  }

  // JSON SUPPORT: encode as Json Map - Used to support Lists and Maps of queues.
  Map toJson() {
    Map aMap = {};
    aMap['id'] = _id;
    aMap['name'] = _name;
    aMap['stories'] = [];
    _stories.forEach((Story s){
      aMap['stories'].add(s.toJson());
    });
    return aMap;
  }

  Queue addStory(Story story) {
    _stories.add(story);
    return this;
  }

  // Getters and Setters
  int get id => _id;
  void set id(int id) {_id = id;}

  String get name => _name;
  void set name(String name) {_name = name;}

  List<Story> get stories => _stories;
  void set stories(List<Story> stories) {_stories = stories;}

  String toString() => "Queue '${_name}' with ${_stories.length} stories";

  static List<Queue> listFromJson(List<Map<String, Object>> jsonList) {
    List<Queue> answer = [];
    for (var i in jsonList) {
      Queue queue = new Queue.fromJson(i);
      answer.add(queue);
    }
    return answer;
  }
}
