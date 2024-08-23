/// Listens to a stream while handling backpressure.
/// It should not read the stream faster than it can process the data.
Future<void> listenToStreamWithBackpressure({
  required Stream<int> stream,
  required Future<void> Function(int) onData,
}) async {
  await for (final data in stream) {
    await onData(data);
  }
}
