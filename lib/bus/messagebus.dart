

library penguin.bus;

/*
 * A message with a payload to be sent to unknown consumers.
 */
class Message<T> {
  T _payload = null;

  Message(this._payload);
  T get payload => _payload;
}