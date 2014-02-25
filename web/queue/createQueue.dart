

import 'dart:html';
import 'package:polymer/polymer.dart';

/**
 * A Polymer element to create Penguin Queues
 */
@CustomTag('create-queue')
class CreateQueue extends FormElement with Polymer, Observable {

  @published String name = null;
  @published String result = null;

  CreateQueue.created() : super.created() {
  }

  HttpRequest request;

  void createQueue(Event e, var detail, Node target) {
    e.preventDefault(); // Don't do the default submit.

    request = new HttpRequest();

    request.onReadyStateChange.listen(onData);

    // POST the data to the server.
    var url = 'http://127.0.0.1:4040';
    request.open('POST', url);
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

