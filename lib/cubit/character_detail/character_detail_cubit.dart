import 'package:fleetime_genshin/data/datasources/character/character_datasource.dart';
import 'package:fleetime_genshin/data/model/characters/character_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_detail_state.dart';
part 'character_detail_cubit.freezed.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  final CharacterDatasource _characterDatasource;

  CharacterDetailCubit(this._characterDatasource)
      : super(const CharacterDetailState.initial());

  Future<void> getCharacterDetail(String characterId) async {
    emit(const CharacterDetailState.loading());
    final result = await _characterDatasource.getCharacter(characterId);
    result.fold(
      (l) => emit(CharacterDetailState.error(
        message: l.toString(),
      )),
      (r) => emit(CharacterDetailState.loaded(character: r)),
    );
  }

  // Future<void> getCharacterIcon(String characterId) async {
  //   emit(const CharacterDetailState.loading());
  //   final result = await _characterDatasource.getCharacterIcon(characterId);
  //   result.fold(
  //     (l) => emit(CharacterDetailState.error(
  //       message: l.toString(),
  //     )),
  //     (r) => emit(CharacterDetailState.loaded(character: r)),
  //   );
  // }
}
