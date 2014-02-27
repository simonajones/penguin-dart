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

  Queue.fromMap(Map queue) {
    _id = queue["id"];
    _name = queue["name"];
    _stories = Story.listFromMap(queue["stories"]);
  }

  // Parse JSON to create a queue
  Queue.fromJson(String json) {
    var decoded = JSON.decode(json);
    _id = decoded["id"];
    _name = decoded["name"];
    _stories = Story.listFromMap(decoded["stories"]);
  }

  Queue addStory(Story story) {
    _stories.add(story);
    return this;
  }

  // TODO: There must be a better way to do this? The
  // List<Story> gets encoded as a single Json string
  // instead of an array of Story objects.
  // I'd like this map to work: return {"id": _id, "name": _name, "stories": _stories}
  Map toMap() {
    Map queueAsMap = {"id": _id, "name": _name};
    queueAsMap["stories"] = listAsMap(_stories);
    return queueAsMap;
  }

  String toJson() {
    return JSON.encode(toMap());
  }

  int get id => _id;
  String get name => _name;
  List<Story> get stories => _stories;
  String toString() => "Queue '${_name}' with ${_stories.length} stories";

  //
  // Some static helpers... Again, there must be a better way
  // to convert List<Queue> (and it's List<Story> member) to and from JSON?
  //
  static List<Map<String, Object>> listAsMap(final List<Object> list) {
    List<Map<String, Object>> listOfMaps = new List();
    for (final Object o in list) {
      Map<String, Object> anObject = o.toMap();
      listOfMaps.add(anObject);
    }
    return listOfMaps;
  }

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
