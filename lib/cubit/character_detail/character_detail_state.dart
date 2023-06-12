part of 'character_detail_cubit.dart';

@freezed
class CharacterDetailState with _$CharacterDetailState {
  const factory CharacterDetailState.initial() = _Initial;
  const factory CharacterDetailState.loading() = _Loading;
  const factory CharacterDetailState.loaded({
    required Character character,
  }) = _Loaded;
  const factory CharacterDetailState.error({
    required String message,
  }) = _Error;
}
