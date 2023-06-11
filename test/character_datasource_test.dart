import 'package:fleetime_genshin/data/datasources/character/character_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

// IMPORT DARTZ

void main() {
  group('CharacterDatasource', () {
    final characterDatasource = CharacterDatasource();

    test('getCharacterList returns Right with valid response', () async {
      final result = await characterDatasource.getCharacterList();

      expect(result.isRight(), true);
    });
  });
}
