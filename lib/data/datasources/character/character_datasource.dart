import 'package:dartz/dartz.dart';
import 'package:fleetime_genshin/common/constant/api.dart';
import 'package:fleetime_genshin/common/singleton/dio_singleton.dart';
import 'package:fleetime_genshin/data/model/characters/character_response_model.dart';
import 'package:logger/logger.dart';

enum CharacterImageType {
  card,
  portrait,
  iconBig,
}

extension CharacterImageTypeExtension on CharacterImageType {
  String toUrl() {
    switch (this) {
      case CharacterImageType.card:
        return '/card';
      case CharacterImageType.portrait:
        return '/portrait';
      case CharacterImageType.iconBig:
        return '/icon-big';
      default:
        return '';
    }
  }
}

class CharacterDatasource {
  final endpoint = EndPoint.characters;

  Future<Either<Exception, List<String>>> getCharacterList() async {
    try {
      final response = await DioSingleton.instance
          .get(GenshinConst.getEndpointUrl(endpoint));
      final data = List<String>.from(response.data);

      return Right(data);
    } on Exception catch (e) {
      Logger().e('CharacterDatasource.getCharacterList: $e');
      return Left(e);
    }
  }

  Future<Either<Exception, Character>> getCharacter(String name) async {
    try {
      final response = await DioSingleton.instance
          .get(GenshinConst.getEndpointUrl(endpoint) + name);
      final data = Character.fromJson(response.data);

      return Right(data);
    } on Exception catch (e) {
      Logger().e('CharacterDatasource.getCharacter: $e');
      return Left(e);
    }
  }

  Future<Either<Exception, String>> getCharacterIcon(String name) async {
    try {
      final response = await DioSingleton.instance.get(
          GenshinConst.getEndpointUrl(endpoint) +
              name +
              CharacterImageType.iconBig.toUrl());
      final data = response.data;

      return Right(data);
    } on Exception catch (e) {
      Logger().e('CharacterDatasource.getCharacterIcon: $e');
      return Left(e);
    }
  }
}
