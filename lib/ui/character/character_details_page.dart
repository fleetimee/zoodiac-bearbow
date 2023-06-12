import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GenshinCharacterDetailPage extends StatelessWidget {
  const GenshinCharacterDetailPage({
    super.key,
    required this.characterName,
  });

  final String characterName;

  @override
  Widget build(BuildContext context) {
    Logger().d('Character Name: $characterName');

    return Scaffold(
      appBar: AppBar(
        title: Text(characterName),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text('Character Detail'),
        ),
      ),
    );
  }
}
