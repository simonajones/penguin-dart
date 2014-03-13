/*
 * Tests for the Queue/Story model classes.
 */

import 'package:unittest/unittest.dart';
import 'package:penguin/model/model.dart';
import 'package:penguin/bus/messagebus.dart';

main() {
  test('Add and retreive payloads on a message', () {
    Queue queue = new Queue(id: 1, name: "queue one");
    Message<Queue> message = new Message<Queue>(queue);

    expect(message.payload, equals(queue));

   });
}