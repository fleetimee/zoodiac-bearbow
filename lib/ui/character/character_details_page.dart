import 'dart:math';

import 'package:fleetime_genshin/cubit/character_detail/character_detail_cubit.dart';
import 'package:fleetime_genshin/data/model/characters/character_response_model.dart';
import 'package:fleetime_genshin/ui/character/character_more_information_page.dart';
import 'package:fleetime_genshin/ui/character/widget/character_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

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
  late int _index;
  late int _auxIndex;
  double? _percent;
  double? _auxPercent;
  late bool _isScrolling;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();

    context
        .read<CharacterDetailCubit>()
        .getCharacterDetail(widget.characterName);

    _pageController = PageController();

    _index = 0;
    _auxIndex = _index + 1;
    _percent = 0.0;
    _auxPercent = 1.0 - _percent!;
    _isScrolling = false;
  }

  @override
  void dispose() {
    _pageController!
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  void _pageListener() {
    _index = _pageController!.page!.floor();
    _auxIndex = _index + 1;
    _percent = (_pageController!.page! - _index).abs();
    _auxPercent = 1.0 - _percent!;

    _isScrolling = _pageController!.page! % 1.0 != 0;
    setState(() {});
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
      body: Center(
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
                  index: _index,
                  auxIndex: _auxIndex,
                  percent: _percent!,
                  auxPercent: _auxPercent!,
                  isScrolling: _isScrolling,
                  pageController: _pageController!,
                );
              },
              error: (message) => Center(
                child: Text(message),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CharacterDetail extends StatelessWidget {
  const _CharacterDetail({
    required this.character,
    required this.characterName,
    required this.index,
    required this.auxIndex,
    required this.percent,
    required this.auxPercent,
    required this.isScrolling,
    required this.pageController,
  });

  final Character character;
  final String characterName;

  final int index;
  final int auxIndex;
  final double percent;
  final double auxPercent;
  final bool isScrolling;
  final PageController pageController;

  void _openDetail(
      BuildContext context, Character superhero, String characterName) {
    Navigator.push(
      context,
      PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: GenshinCharacterMoreInformationPage(
              superhero: superhero,
              characterName: characterName,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const angleRotate = -pi * .5;
    return Stack(
      children: [
        AnimatedPositioned(
          duration: kThemeAnimationDuration,
          top: 0,
          bottom: 0,
          right: isScrolling ? 10 : 0,
          left: isScrolling ? 10 : 0,
          child: Stack(
            children: [
              //----------------
              // Back Card
              //----------------
              Transform.translate(
                offset: Offset(0, 50 * auxPercent),
                child: SuperheroCard(
                  superhero: character,
                  factorChange: auxPercent,
                  characterName: characterName,
                ),
              ),
              //----------------
              // Front Card
              //----------------
              Transform.translate(
                offset: Offset(-800 * percent, 100 * percent),
                child: Transform.rotate(
                  angle: angleRotate * percent,
                  child: SuperheroCard(
                    superhero: character,
                    factorChange: percent,
                    characterName: characterName,
                  ),
                ),
              )
            ],
          ),
        ),
        PageView.builder(
          itemCount: 1,
          controller: pageController,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _openDetail(
                context,
                character,
                characterName,
              ),
            );
          },
        )
      ],
    );
  }
}
