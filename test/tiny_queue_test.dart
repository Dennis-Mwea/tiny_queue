import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_queue/tiny_queue.dart';

void main() {
  List data = [];
  for (var i = 0; i < 100; i++) {
    data.add((100 * Random().nextDouble()).floor());
  }
  List sorted = List.of(data)..sort((a, b) => a - b);

  group('TinyQueue tests', () {
    test('maintains a priority queue', () {
      final queue = TinyQueue();
      for (var i = 0; i < data.length; i++) {
        queue.push(data[i]);
      }

      expect(queue.peek(), equals(sorted[0]));

      final result = [];
      while (queue.length > 0) {
        result.add(queue.pop());
      }
      expect(result, equals(sorted));
    });

    test('accepts data in constructor', () {
      final queue = TinyQueue(data: data);

      final result = [];
      while (queue.length > 0) {
        result.add(queue.pop());
      }

      expect(result, equals(sorted));
    });

    test('handles edge cases with few elements', () {
      final queue = TinyQueue();
      queue.push(2);
      queue.push(1);
      queue.pop();
      queue.pop();
      queue.pop();
      queue.push(2);
      queue.push(1);
      expect(queue.pop(), equals(1));
      expect(queue.pop(), equals(2));
      expect(queue.pop(), equals(null));
    });

    test('handles init with empty array', () {
      final queue = TinyQueue(data: []);

      expect(queue.data, equals([]));
    });
  });
}
