

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:penguin/model/model.dart';

/**
 * A Polymer element to create Penguin Queues
 */
@CustomTag('queue-list')
class QueueList extends PolymerElement with Polymer, Observable {

  @published List<Queue> queues = null;
  @published var result = null;

  QueueList.created() : super.created() {}

  HttpRequest request = null;

  void refresh(Event e, var detail, Node target) {
    e.preventDefault(); // Don't do the default submit.

    request = new HttpRequest();

    request.onReadyStateChange.listen(onData);

    // POST the data to the server.
    var url = 'http://127.0.0.1:4040/queues';
    request.open('GET', url, async: true);
    request.send();
  }

  void onData(_) {
    if (request.readyState == HttpRequest.DONE &&
        request.status == 200) {
      // Data loaded OK.
      String data = request.responseText;
      queues = Queue.listFromJson(data);
      result = "Done";
    } else if (request.readyState == HttpRequest.DONE &&
        request.status == 0) {
      // Status is 0...most likely the server isn't running.
      result = 'No server';
    }
  }

}
