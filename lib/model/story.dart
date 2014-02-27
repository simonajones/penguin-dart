//
// My first dart class
//

part of penguinmodel;

class Story {

  int _id = null;
  String _reference = null;
  String _title = null;
  String _author = null;
  bool _merged = false;

  // Constructor
  Story(this._reference, this._title, this._author); // Empty constructor body, nice.

  // Parse JSON to create a Story
  Story.fromJson(String json) {
    var decoded = JSON.decode(json);
    _reference = decoded["ref"];
    _title = decoded["title"];
    _author = decoded["author"];
  }

  Story.fromMap(Map<String, Object> storyMap) {
    _reference = storyMap["ref"];
    _title = storyMap["title"];
    _author = storyMap["author"];
  }

  // Can't get JSON encoder to navigate List<Story> correclty from a Queue, so
  // I use Maps.
  Map toMap() {
    return {"ref": _reference, "title": _title, "author": _author, "merged": _merged, "id": _id};
  }

  String toJson() {
    return JSON.encode(toMap());
  }

  int get id => _id;
  void set id(final int id) {_id = id;}
  String get ref => _reference;
  String get title => _title;
  String get author => _author;
  bool get merged => _merged;

  String toString() {
    return "Story: ${_id} ref:${_reference} title:${_title} author:${author} isMerged:${_merged}";
  }

  static List<Story> listFromMap(List<Map<String, Object>> storyList) {
    List<Story> answer = [];
    for (var i in storyList) {
      Story story = new Story.fromMap(i);
      answer.add(story);
    }
    return answer;
  }

}
