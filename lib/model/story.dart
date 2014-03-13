//
// My first dart class
//

part of penguinmodel;

class Story extends Serialisable {

  int _id = null;
  String _reference = null;
  String _title = null;
  String _author = null;
  bool _merged = false;

  // Constructor
  Story(this._reference, this._title, this._author); // Empty constructor body, nice.

  // Parse JSON to create a Story
  Story.fromJson(String json) {
    super.fromJson(json);
  }

  Story.fromMap(Map<String, Object> aMap) {
    super.fromMap(aMap);
  }

  // Getters & Setters
  int get id => _id;
  void set id(int id) {_id = id;}

  String get ref => _reference;
  void set ref(String ref) {_reference = ref;}

  String get title => _title;
  void set title(String title) {_title = title;}

  String get author => _author;
  void set author(String author) {_author = author;}

  bool get merged => _merged;
  void set merged(bool merged) {_merged = merged;}

  String toString() {
    return "Story: ${id} ref:${_reference} title:${_title} author:${author} isMerged:${_merged}";
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
