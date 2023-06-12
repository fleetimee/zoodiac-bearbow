import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:fleetime_genshin/common/constant/api.dart';
import 'package:fleetime_genshin/cubit/character_detail/character_detail_cubit.dart';
import 'package:fleetime_genshin/data/model/characters/character_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

enum CharacterDetailImage {
  icon,
  card,
}

class GenshinCharacterDetailPage extends StatefulWidget {
  const GenshinCharacterDetailPage({
    super.key,
    required this.characterName,
  });

  final String characterName;

  @override
  State<GenshinCharacterDetailPage> createState() =>
      _GenshinCharacterDetailPageState();
}

class _GenshinCharacterDetailPageState
    extends State<GenshinCharacterDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<CharacterDetailCubit>()
        .getCharacterDetail(widget.characterName);
  }

  @override
  Widget build(BuildContext context) {
    Logger().d('Character Name: ${widget.characterName}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.characterName),
        centerTitle: true,
        leading: Hero(
          tag: 'back.button.tag',
          child: Material(
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (character) {
                  return _CharacterDetail(
                    character: character,
                    characterName: widget.characterName,
                  );
                },
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CharacterDetail extends StatelessWidget {
  const _CharacterDetail({
    required this.character,
    required this.characterName,
  });

  final Character character;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sizes.height,
      width: context.sizes.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            GenshinConst.getCardUrl(characterName),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
