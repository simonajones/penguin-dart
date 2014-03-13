library penguinmodel;

import 'dart:convert' show HTML_ESCAPE, JSON, LineSplitter, UTF8;
import 'dart:mirrors';

part 'queue.dart';
part 'story.dart';

abstract class Serialisable {

  InstanceMirror mirror = null;

  fromMap(Map<String, Object> aMap) {
    mirror = reflect(this);
    ClassMirror classMirror = mirror.type;

    Iterable<DeclarationMirror> decls = classMirror.declarations.values.where(
        (dm) => dm is MethodMirror && dm.isSetter);

    decls.forEach((MethodMirror mm) {
      String method = MirrorSystem.getName(mm.simpleName);
      String key = method.split("=")[0];
      var value = aMap[key];
      if (value != null) {
        if (value is List) {
          var list = fromList(mm, value);
          mirror.setField(new Symbol(key), list);
        } else {
          mirror.setField(new Symbol(key), value);
        }
      }
    });
  }

  //
  // Convert a List<Map<String, Object>> into a List<E>
  //
  List fromList(MethodMirror mm, List value) {
    ParameterMirror parameter = mm.parameters[0];
    // Create the list
    List list = [];
    value.forEach((Map item) {
      ClassMirror classm = findClassMirror(parameter.type.typeArguments.single.simpleName.toString());
      var newInstance = classm.newInstance(#fromMap, [item]).reflectee;
      list.add(newInstance);
      print("Added ot list: " + newInstance.toString());
    });

    return list;
  }

  // TODO: Generics needed for library name.
  ClassMirror findClassMirror(String name) {
    var myClasses = currentMirrorSystem().findLibrary(#penguinmodel).declarations.values.where(
        (dm) => dm is ClassMirror);
    var cm = myClasses.firstWhere((cm){
      return cm.simpleName.toString().endsWith(name);
    });
    return cm;
  }

  fromJson(String json) {
    Map decoded = JSON.decode(json);
    fromMap(decoded);
  }

  // Can't get JSON encoder to navigate List<Story> correclty from a Queue, so
  // I'll use the mirror/serialisation API to encode/decode Lists.
  Map toMap() {
    mirror = reflect(this);
    ClassMirror classMirror = mirror.type;

    Iterable<DeclarationMirror> decls = classMirror.declarations.values.where(
        (dm) => dm is MethodMirror && dm.isGetter);

    Map<String, Object> answer = {};

    decls.forEach((MethodMirror mm) {
      String method = MirrorSystem.getName(mm.simpleName);
      var value = mirror.getField(mm.simpleName).reflectee;
      //print(method + " = " + value.toString());
      if (value is List) {
        List<Map<String, Object>> list = [];
        for (var item in value) {
          list.add(item.toMap());
        }
        answer[method] = list;
      } else {
        answer[method] = value;
      }
    });

    return answer;
  }

  Map toJson() {
    return toMap();
  }

  String toJsonString() {
    return JSON.encode(toMap());
  }

}
