//
// My second dart class
//

part of penguinmodel;

class Queue extends Serialisable {

  int _id = null;
  String _name = null;
  List<Story> _stories = [];

  // Constructors
  Queue({int id, String name}) {
    _id = id;
    _name = name;
  }

  // Parse JSON to create a queue
  Queue.fromJson(String json) {
    fromJson(json);
  }

  Queue.fromMap(Map aMap) {
    fromMap(aMap);
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

  static List<Queue> listFromJson(String queuesAsJson) {
    List<Map<String, Object>> decoded = JSON.decode(queuesAsJson);
    List<Queue> answer = [];
    for (var i in decoded) {
      Queue queue = new Queue.fromMap(i);
      answer.add(queue);
    }
    return answer;
  }
}
