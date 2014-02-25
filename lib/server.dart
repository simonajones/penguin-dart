// Simple HTTP server to receive requests
// and pass them onto data/memory.dart

library penguin;

import 'dart:io';
import 'dart:convert' show HTML_ESCAPE, JSON, LineSplitter, UTF8;

part 'model/queue.dart';
part 'model/story.dart';
part 'data/memory.dart';

/* A simple server stolen from Chris Buckett's JSON web-service article
 * and modified for purposes of this tutorial sample.
 *
 * Provides CORS headers, so can be accessed from any other page
 */

final HOST = '127.0.0.1'; // eg: localhost
final PORT = 4040;        // a port, must match the client program

PenguinStore myPenguin = new PenguinStore();

void start() {
  HttpServer.bind(HOST, PORT).then(gotMessage, onError: printError);
}

void gotMessage(_server) {
  _server.listen((HttpRequest request) {
    try {
      switch (request.method) {
        case 'GET':
          handleGet(request);
          break;
        case 'POST':
          handlePost(request);
          break;
        case 'OPTIONS':
          handleOptions(request);
          break;
        default: defaultHandler(request);
      }
    } catch (exception, stacktrace) {
      print("Error: " + exception);
      print(stacktrace);
    }
  },
  onError: printError); // .listen failed
  print('Penguin Listening for GET and POST on http://$HOST:$PORT');
}

/**
 * Handle GET requests
 */
void handleGet(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);

  res.headers.add(HttpHeaders.CONTENT_TYPE, 'application/json');

  switch (req.uri.path) {
    case '/queues':
      var answer = myPenguin.findQueuesAsJson();
      res.write(answer);
      break;
    default: defaultHandler(req);
  }

  res.close();
}


/**
 * Handle POST requests
 */
void handlePost(HttpRequest req) {
  HttpResponse res = req.response;

  addCorsHeaders(res);
  var postMap = null;

  req.listen((List<int> buffer) {
    postMap = decodePostData(buffer);

    switch (req.uri.path) {

      case '/queue/create':
        var createQueue = myPenguin.createQueue(postMap["name"]);
        res.write(createQueue.toJson());
        break;

      case '/queue/addstory':
        var createStory = myPenguin.createStory(
            int.parse(postMap['qid']), postMap['ref'], postMap['title'], postMap['author']);
        res.write(createStory.toJson());
        break;

      default: defaultHandler(req);
    }
    res.close();
  },
  onError: printError);
}

/*
 * Simple postData to map conversion.
 * TODO: There's probably a transform to do this?
 */
Map<String, String> decodePostData(List<int> buffer) {

  List<String> _postData = UTF8.decode(buffer).replaceAll("+", " ").split("&");
  Map<String, String> _postMap = {};
  for (String s in _postData) {
    var split = s.split("=");
    _postMap[split[0]] = split[1];
  }
  return _postMap;
}



/**
 * Add Cross-site headers to enable accessing this server from pages
 * not served by this server
 *
 * See: http://www.html5rocks.com/en/tutorials/cors/
 * and http://enable-cors.org/server.html
 */
void addCorsHeaders(HttpResponse res) {
  res.headers.add('Access-Control-Allow-Origin', '*, ');
  res.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
}

void handleOptions(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);
  print('${req.method}: ${req.uri.path}');
  res.statusCode = HttpStatus.NO_CONTENT;
  res.close();
}

void defaultHandler(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);
  res.statusCode = HttpStatus.NOT_FOUND;
  res.write('Not found: ${req.method}, ${req.uri.path}');
  res.close();
}

void printError(error) => print(error);
