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

  // JSON SUPPORT: Construct from a Json Map
  Story.fromJson(Map<String, Object> aMap) {
    _reference = aMap['ref'];
    _title = aMap['title'];
    _author = aMap['author'];
    _merged = aMap['merged'];
  }

  // JSON SUPPORT: encode as Json Map to support Lists and Maps
  Map toJson() {
    Map aMap = {};
    aMap['id'] = _id;
    aMap['ref'] = _reference;
    aMap['title'] = _title;
    aMap['author'] = _author;
    aMap['merged'] = _merged;
    return aMap;
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

}
