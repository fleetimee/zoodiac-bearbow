import 'package:fleetime_genshin/data/datasources/character/character_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_state.dart';
part 'character_cubit.freezed.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterDatasource _characterDatasource;

  CharacterCubit(
    this._characterDatasource,
  ) : super(const CharacterState.initial());

  Future<void> getCharacterList() async {
    emit(const CharacterState.loading());
    final result = await _characterDatasource.getCharacterList();
    result.fold(
      (l) => emit(CharacterState.error(l.toString())),
      (r) => emit(CharacterState.loaded(r)),
    );
  }
}
