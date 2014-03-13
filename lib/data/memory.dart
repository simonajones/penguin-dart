//
// Provide a simple API for CRUD operations on Queues and Stories
// in memory.
//
//
part of penguin;

class PenguinStore {

  List<Queue> _queues = []; //new List<Queue>();
  int _id = 0;
  int _storyId = 0;

  List<Queue> findQueues() {
    return _queues;
  }

  String findQueuesAsJson() {
    return JSON.encode(_queues);
  }

  Queue createQueue(String name) {
    Queue newQ = new Queue(id: _id++, name: name);
    _queues.add(newQ);
    return newQ;
  }

  Queue findQueue(final int id) {
    return _queues[id];
  }

  Story createStory(int queueId,
                    String reference,
                    String title,
                    String author) {
    Story newStory = new Story(reference, title, author);
    newStory.id = _storyId++;
    Queue queue = findQueue(queueId);
    queue.addStory(newStory);
    return newStory;
  }
}

/*
/*
 * In-memory data layer.
 */

exports.updateQueue = function(queue, callback) {
  queues[queue._id - 1] = queue;
  callback(true);
};

exports.deleteQueue = function(id, callback) {
  // TODO: remove queue from array
  callback(true);
};

exports.findStory = function(queueId, id, callback) {
  // TODO: implement
  callback(null);
};

exports.updateStory = function(queueId, story, callback) {
  // TODO: implement
  callback(false);
};

exports.deleteStory = function(queueId, id, callback) {
  // TODO: implement
  callback(false);
};

exports.mergeStory = function(queueId, id, callback) {
  // TODO: implement
  callback(false);
};

exports.unmergeStory = function(queueId, id, callback) {
  // TODO: implement
  callback(false);
};
*/
