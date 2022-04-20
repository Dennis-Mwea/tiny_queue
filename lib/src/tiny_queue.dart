library tiny_queue;

class TinyQueue {
  final List<dynamic> data;
  int length;
  int Function(dynamic a, dynamic b) compare;

  TinyQueue({List<dynamic>? data, this.compare = _defaultCompare})
      : data = data ?? [],
        length = data?.length ?? 0 {
    if (length > 0) {
      for (var i = (length >> 1) - 1; i >= 0; i--) {
        _down(i);
      }
    }
  }

  push(item) {
    data.add(item);
    _up(length++);
  }

  pop() {
    if (length == 0) return null;

    var top = data[0];
    var bottom = data.removeLast();

    if (--length > 0) {
      data[0] = bottom;
      _down(0);
    }

    return top;
  }

  peek() => data[0];

  _up(pos) {
    var data = this.data;
    var compare = this.compare;
    var item = data[pos];

    while (pos > 0) {
      var parent = (pos - 1) >> 1;
      var current = data[parent];
      if (compare(item, current) >= 0) break;
      data[pos] = current;
      pos = parent;
    }

    data[pos] = item;
  }

  _down(pos) {
    var data = this.data;
    var compare = this.compare;
    var halfLength = length >> 1;
    var item = data[pos];

    while (pos < halfLength) {
      var bestChild = (pos << 1) + 1; // initially it is the left child
      var right = bestChild + 1;

      if (right < length && compare(data[right], data[bestChild]) < 0) {
        bestChild = right;
      }
      if (compare(data[bestChild], item) >= 0) break;

      data[pos] = data[bestChild];
      pos = bestChild;
    }

    data[pos] = item;
  }

  @override
  String toString() => 'TinyQueue(data: $data, length: $length)';
}

int _defaultCompare(dynamic a, dynamic b) {
  return a < b
      ? -1
      : a > b
          ? 1
          : 0;
}
