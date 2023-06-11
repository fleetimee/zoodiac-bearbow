import 'package:fleetime_genshin/common/constant/api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenshinConst', () {
    test('baseUrl should be correct', () {
      expect(GenshinConst.baseUrl, 'https://api.genshin.dev/');
    });

    test('getEndpointUrl should return correct url for EndPoint.characters',
        () {
      expect(GenshinConst.getEndpointUrl(EndPoint.characters),
          'https://api.genshin.dev/characters/');
    });

    test('getEndpointUrl should return correct url for EndPoint.weapons', () {
      expect(GenshinConst.getEndpointUrl(EndPoint.weapons),
          'https://api.genshin.dev/weapons/');
    });

    test('getEndpointUrl should throw ArgumentError for invalid EndPoint', () {
      expect(() => GenshinConst.getEndpointUrl(EndPoint.error),
          throwsArgumentError);
    });
  });
}
