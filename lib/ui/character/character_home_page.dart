import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleetime_genshin/cubit/character/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Center(
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
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard(
    this.characterList,
  );

  final List<String> characterList;

  String iconLink(String characterName) {
    return 'https://api.genshin.dev/characters/${characterName.toLowerCase()}/icon-big';
  }

  Widget _buildCharacterCard(
      String characterName, ImageProvider imageProvider) {
    return Column(
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
            color: Colors.blue,
          ),
        ),
        Text(
          characterName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorCard(String characterName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 200,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
          ),
          child: const Icon(Icons.error),
        ),
        Text(
          characterName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
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
          errorWidget: (context, url, error) {
            return _buildErrorCard(
              characterList[index],
            );
          },
          imageUrl: iconLink(characterList[index]),
          imageBuilder: (context, imageProvider) {
            return _buildCharacterCard(
              characterList[index],
              imageProvider,
            );
          },
        );
      },
    );
  }
}
