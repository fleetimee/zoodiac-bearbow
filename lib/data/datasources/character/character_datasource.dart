import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fleetime_genshin/common/constant/api.dart';
import 'package:logger/logger.dart';

class CharacterDatasource {
  final dio = Dio();

  final endpoint = EndPoint.characters;

  Future<Either<Exception, List<String>>> getCharacterList() async {
    try {
      final response = await dio.get(GenshinConst.getEndpointUrl(endpoint));
      final data = List<String>.from(response.data);

      Logger().d('CharacterDatasource.getCharacterList: $data');

      return Right(data);
    } on Exception catch (e) {
      Logger().e('CharacterDatasource.getCharacterList: $e');
      return Left(e);
    }
  }
}
