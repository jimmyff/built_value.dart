// Copyright (c) 2018, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:built_value/serializer.dart';
import 'package:test/test.dart';

void main() {
  final serializers = new Serializers();

  group('Duration with known specifiedType', () {
    final data = new Duration(
        days: 1,
        hours: 2,
        minutes: 3,
        seconds: 4,
        milliseconds: 5,
        microseconds: 6);
    final serialized = 1 * 1000 * 1000 * 60 * 60 * 24 +
        2 * 1000 * 1000 * 60 * 60 +
        3 * 1000 * 1000 * 60 +
        4 * 1000 * 1000 +
        5 * 1000 +
        6;
    final specifiedType = const FullType(Duration);

    test('can be serialized', () {
      expect(serializers.serialize(data, specifiedType: specifiedType),
          serialized);
    });

    test('can be deserialized', () {
      expect(serializers.deserialize(serialized, specifiedType: specifiedType),
          data);
    });
  });

  group('Duration with unknown specifiedType', () {
    final data = new Duration(
        days: 1,
        hours: 2,
        minutes: 3,
        seconds: 4,
        milliseconds: 5,
        microseconds: 6);
    final serialized = [
      'Duration',
      1 * 1000 * 1000 * 60 * 60 * 24 +
          2 * 1000 * 1000 * 60 * 60 +
          3 * 1000 * 1000 * 60 +
          4 * 1000 * 1000 +
          5 * 1000 +
          6,
    ];
    final specifiedType = FullType.unspecified;

    test('can be serialized', () {
      expect(serializers.serialize(data, specifiedType: specifiedType),
          serialized);
    });

    test('can be deserialized', () {
      expect(serializers.deserialize(serialized, specifiedType: specifiedType),
          data);
    });
  });
}
