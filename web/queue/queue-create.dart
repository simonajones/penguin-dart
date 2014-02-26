

import 'dart:html';
import 'package:polymer/polymer.dart';

/**
 * A Polymer element to create Penguin Queues
 */
@CustomTag('queue-create')
class QueueCreate extends FormElement with Polymer, Observable {

  @published String name = "test-name";
  @published String result = null;

  QueueCreate.created() : super.created() {
  }

  HttpRequest request = null;

  void createQueue(Event e, var detail, Node target) {
    e.preventDefault(); // Don't do the default submit.

    request = new HttpRequest();

    request.onReadyStateChange.listen(onData);

    // POST the data to the server.
    var url = 'http://127.0.0.1:4040/queue/create';
    request.open('POST', url, async: false);
    request.send("name="+name);
  }

  void onData(_) {
    if (request.readyState == HttpRequest.DONE &&
        request.status == 200) {
      // Data saved OK.
      result = 'Server Sez: ' + request.responseText;
    } else if (request.readyState == HttpRequest.DONE &&
        request.status == 0) {
      // Status is 0...most likely the server isn't running.
      result = 'No server';
    }
  }

}

