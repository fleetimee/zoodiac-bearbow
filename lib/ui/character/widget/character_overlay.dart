import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleetime_genshin/common/constant/api.dart';
import 'package:fleetime_genshin/data/model/characters/character_response_model.dart';
import 'package:flutter/material.dart';

class SuperheroCard extends StatelessWidget {
  const SuperheroCard({
    super.key,
    required this.superhero,
    required this.factorChange,
    required this.characterName,
  });

  final Character superhero;
  final double? factorChange;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final separation = size.height * .24;
    return OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: size.height,
      child: Stack(
        children: [
          //--------------------------------------------
          // Color bg with rounded corners
          //--------------------------------------------
          Positioned.fill(
            top: separation,
            child: Hero(
              tag: 'bg',
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          //-----------------------------------
          // Superhero image
          //-----------------------------------
          Positioned(
            left: 20,
            right: 20,
            top: separation * factorChange!,
            bottom: size.height * .35,
            child: Opacity(
              opacity: 1.0 - factorChange!,
              child: Transform.scale(
                scale: lerpDouble(1, .4, factorChange!),
                child: Hero(
                  tag: 'yeh',
                  child: CachedNetworkImage(
                    imageUrl: GenshinConst.getPortraitUrl(characterName),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            right: 100,
            top: size.height * .55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //----------------------------------
                // Superhero Name
                //----------------------------------
                FittedBox(
                  child: Hero(
                    tag: 'name',
                    child: Text(
                      superhero.name!.toUpperCase(),
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ),
                //----------------------------------
                // Superhero Secret Identity Name
                //----------------------------------
                Hero(
                  tag: superhero.name!,
                  child: Text(
                    superhero.title!.toLowerCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //----------------------------------
                // Superhero Description
                //----------------------------------
                Hero(
                  tag: 'description',
                  child: Text(
                    superhero.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 25),
                const Text.rich(
                  TextSpan(
                    text: 'learn more',
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.arrow_right_alt,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
