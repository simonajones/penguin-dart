/*
 * Tests for the Queue/Story model classes.
 */

import 'package:unittest/unittest.dart';
import 'package:penguin/model/model.dart';

main() {
  test('Encode Queue as JSON with no stories', () {
    Queue queue = new Queue(id: 1, name: "queue one");
    var qjson = queue.toJson();
    expect(qjson, equals('{"id":1,"name":"queue one","stories":[]}'));
   });

  test('Encode Story as JSON', () {
    Story story = new Story("ref1", "my title", "an author");
    var sjson = story.toJson();
    expect(sjson, equals('{"ref":"ref1","title":"my title","author":"an author","merged":false,"id":null}'));
   });

  test('Encode Queue as JSON with 1 story', () {
    Queue queue = new Queue(id: 13, name: "queue one");
    queue.addStory(new Story("sref", "stitle", "sauthor"));
    var qjson = queue.toJson();
    expect(qjson, equals(
        '{"id":13,"name":"queue one","stories":'+
          '[{"ref":"sref","title":"stitle","author":"sauthor","merged":false,"id":null}]}'));
   });

  test('Create Queue from JSON - no stories', () {
    Queue queue = new Queue.fromJson('{"id":1,"name":"queue one","stories":[]}');
    expect(queue.id, equals(1));
    expect(queue.name, equals("queue one"));
    expect(queue.stories, equals([]));
   });

  test('Create List of Queues from JSON with Stories', () {
    List<Queue> queues = Queue.listFromJson(
        '[{"id":1,"name":"queue one","stories":[{"ref":"sref","title":"stitle","author":"sauthor","merged":false,"id":null}]}'+
        ',{"id":2,"name":"queue two","stories":[]}]');
    expect(queues[0].id, equals(1));
    expect(queues[0].name, equals("queue one"));
    // TODO: Matcher error? expect(queues[0].stories, equals([new Story("sref", "stitle", "sauthor")]));
    // TODO: Matcher error? expect(queues[0].stories, contains(new Story("sref", "stitle", "sauthor")));
    expect(queues[1].id, equals(2));
    expect(queues[1].name, equals("queue two"));
    expect(queues[1].stories, equals([]));
   });

  test('Create Story from JSON', () {
    Story story = new Story.fromJson('{"ref":"ref1","title":"my title","author":"an author"}');
    expect(story.ref, equals("ref1"));
    expect(story.title, equals("my title"));
    expect(story.author, equals("an author"));
   });

}