/*
 * Tests for the Penguin Store class(es).
 */

import 'package:unittest/unittest.dart';
import 'package:penguin/server.dart';

main() {

  test('Create new PenguinStore', () {
    PenguinStore store = new PenguinStore();

    expect(store.findQueues(), equals([]));
   });

  test('Create and retreive a Queue', () {
    PenguinStore store = new PenguinStore();

    var createdQueue = store.createQueue("first");
    expect(createdQueue.name, equals("first"));
    expect(createdQueue.id, equals(0));

    var findQueue = store.findQueue(0);
    expect(findQueue, equals(createdQueue));

    var nextQueue = store.createQueue("second");
    findQueue = store.findQueue(1);
    expect(findQueue, equals(nextQueue));
  });

  test('findAll Queues', () {
    PenguinStore store = new PenguinStore();

    var queue1 = store.createQueue("first");
    var queue2 = store.createQueue("second");

    var queues = store.findQueues();
    expect(queue1, isIn(queues));
    expect(queue2, isIn(queues));
  });

  test('createStory and retreive from queue', (){
    PenguinStore store = new PenguinStore();
    Queue queue = store.createQueue("test queue");
    Story createdStory = store.createStory(0, "story ref", "title", "author");

    expect(createdStory.ref, equals("story ref"));
    expect(createdStory.author, equals("author"));
    expect(createdStory.title, equals("title"));
    expect(createdStory.id, equals(0));
    expect(createdStory.merged, equals(false));

    Queue findQueue = store.findQueue(0);
    expect(createdStory, isIn(findQueue.stories));
  });

}
