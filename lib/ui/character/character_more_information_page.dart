// ignore_for_file: unused_field, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleetime_genshin/common/constant/api.dart';
import 'package:fleetime_genshin/data/model/characters/character_response_model.dart';
import 'package:flutter/material.dart';

class GenshinCharacterMoreInformationPage extends StatefulWidget {
  const GenshinCharacterMoreInformationPage(
      {super.key, required this.superhero, required this.characterName});

  @override
  State<GenshinCharacterMoreInformationPage> createState() =>
      _GenshinCharacterMoreInformationPageState();

  final Character superhero;
  final String characterName;
}

class _GenshinCharacterMoreInformationPageState
    extends State<GenshinCharacterMoreInformationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;
  late Animation<double> _colorGradientValue;
  late Animation<double> _whiteGradientValue;

  late bool _changeToBlack;
  late bool _enableInfoItems;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _colorGradientValue = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
        parent: _controller!,
      ),
    );

    _whiteGradientValue = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
        parent: _controller!,
      ),
    );

    _changeToBlack = false;
    _enableInfoItems = false;

    Future.delayed(const Duration(milliseconds: 600), () {
      _controller!.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _changeToBlack = true;
        });
      });
    });

    _controller!.addStatusListener(_statusListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!
      ..removeStatusListener(_statusListener)
      ..dispose();
    super.dispose();
  }

  //----------------------------------------
  // Status Listener
  //----------------------------------------
  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _enableInfoItems = true;
      });
    }
  }

  //-----------------------
  // On Back Button Tap
  //-----------------------
  Future<void> _backButtonTap() async {
    setState(() {
      _enableInfoItems = false;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _changeToBlack = false;
      });
    });
    _controller!.reverse().then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: '${widget.superhero.name}backdrop',
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (_, __) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Theme.of(context).primaryColor, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          _colorGradientValue.value,
                          _whiteGradientValue.value
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SafeArea(
                  child: Hero(
                    tag: '${widget.superhero.name}image',
                    child: CachedNetworkImage(
                      imageUrl: GenshinConst.getPortraitUrl(
                        widget.characterName,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //--------------------------
                      // Superhero name
                      //--------------------------
                      Align(
                        heightFactor: .7,
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          child: Hero(
                            tag: widget.superhero.name!,
                            child: AnimatedDefaultTextStyle(
                              duration: kThemeAnimationDuration,
                              style: textTheme.displayMedium!.copyWith(
                                color: _changeToBlack
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              child: Text(
                                widget.superhero.name!
                                    .replaceAll(' ', '\n')
                                    .toLowerCase(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //---------------------------------------
                          // Superhero Secret Identity Name
                          //---------------------------------------
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Hero(
                                tag: widget.superhero.name!,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: AnimatedDefaultTextStyle(
                                    duration: kThemeAnimationDuration,
                                    style: textTheme.headlineSmall!.copyWith(
                                      color: _changeToBlack
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    child: Text(
                                      widget.superhero.name!.toLowerCase(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                      //---------------------------------------
                      // Animated Superhero Description
                      //---------------------------------------
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        transform: Matrix4.translationValues(
                          0,
                          _enableInfoItems ? 0 : 50,
                          0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _enableInfoItems ? 1.0 : 0.0,
                          child: Text(
                            widget.superhero.description!,
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Divider(height: 30),
                      //----------------------------------
                      // Section Movies Title
                      //----------------------------------
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        transform: Matrix4.translationValues(
                          0,
                          _enableInfoItems ? 0 : 50,
                          0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _enableInfoItems ? 1.0 : 0.0,
                          child: Text(
                            'movies',
                            style: textTheme.headlineSmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 0,
            child: SafeArea(
              child: Hero(
                tag: 'back.button.tag',
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: _backButtonTap,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
