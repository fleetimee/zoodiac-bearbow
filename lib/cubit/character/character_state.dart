part of 'character_cubit.dart';

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.initial() = _Initial;
  const factory CharacterState.loading() = _Loading;
  const factory CharacterState.loaded(List<String> characterList) = _Loaded;
  const factory CharacterState.error(String message) = _Error;
}
