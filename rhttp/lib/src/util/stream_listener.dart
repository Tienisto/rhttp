const _bufferSize = 1024; // 1 KB

/// Listens to a stream while handling backpressure.
/// It should not read the stream faster than it can process the data.
Future<void> listenToStreamWithBackpressure({
  required Stream<int> stream,
  required Future<void> Function(List<int>) onData,
  required Future<void> Function() onDone,
}) async {
  List<int> buffer = [];
  await for (var data in stream) {
    buffer.add(data);

    while (buffer.length > _bufferSize) {
      final complete = buffer.sublist(0, _bufferSize);
      final remaining = buffer.sublist(_bufferSize);

      await onData(complete);
      buffer = remaining;
    }
  }

  if (buffer.isNotEmpty) {
    await onData(buffer);
  }

  await onDone();
}
