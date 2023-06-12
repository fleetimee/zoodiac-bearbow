import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleetime_genshin/cubit/character/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class GenshinCharacterHomePage extends StatefulWidget {
  const GenshinCharacterHomePage({super.key});

  @override
  State<GenshinCharacterHomePage> createState() =>
      _GenshinCharacterHomePageState();
}

class _GenshinCharacterHomePageState extends State<GenshinCharacterHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterCubit>().getCharacterList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          //----------------------------------
          // Get Character List
          //----------------------------------
          child: BlocBuilder<CharacterCubit, CharacterState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (characterList) {
                  //----------------------------------
                  // Fetch Character Icon
                  //----------------------------------
                  return _CharacterCard(characterList);
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

class _CharacterCard extends StatelessWidget {
  const _CharacterCard(
    this.characterList,
  );

  final List<String> characterList;

  String iconLink(String characterName) {
    switch (characterName) {
      case 'traveler-anemo':
        return 'https://api.genshin.dev/characters/traveler-anemo/icon-big-lumine';
      case 'traveler-geo':
        return 'https://api.genshin.dev/characters/traveler-geo/icon-big-aether';
      case 'traveler-electro':
        return 'https://api.genshin.dev/characters/traveler-electro/icon-big-lumine';
      case 'traveler-dendro':
        return 'https://api.genshin.dev/characters/traveler-dendro/icon-big-aether';
      default:
        return 'https://api.genshin.dev/characters/$characterName/icon-big';
    }
  }

  List<String> formattedCharacterList(List<String> characterList) {
    final formattedCharacterList = <String>[];
    for (final character in characterList) {
      formattedCharacterList.add(character.replaceAll(' ', '-'));
    }
    return formattedCharacterList;
  }

  Widget _buildCharacterCard(String characterName, ImageProvider imageProvider,
      BuildContext context, int index) {
    return InkWell(
      onTap: () {
        final routePath =
            Uri(path: '/characters/${characterList[index]}').toString();

        context.push(Uri(path: routePath).toString());

        Logger().d('Route Path: $routePath');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 200,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            characterName,
            style: context.textStyles.titleSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String characterName, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 200,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/icons/question_mark.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.5)
                : Colors.white.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          characterName,
          style: context.textStyles.titleSmall,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: characterList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          placeholder: (context, url) {
            return _buildErrorCard(
              formattedCharacterList(
                characterList,
              )[index]
                  .replaceAll('-', ' ')
                  .toUpperCase(),
              context,
            );
          },
          errorWidget: (context, url, error) {
            return _buildErrorCard(
              formattedCharacterList(
                characterList,
              )[index]
                  .replaceAll('-', ' ')
                  .toUpperCase(),
              context,
            );
          },
          imageUrl: iconLink(characterList[index]),
          imageBuilder: (context, imageProvider) {
            return _buildCharacterCard(
              formattedCharacterList(
                characterList,
              )[index]
                  .replaceAll('-', ' ')
                  .toUpperCase(),
              imageProvider,
              context,
              index,
            );
          },
        );
      },
    );
  }
}
