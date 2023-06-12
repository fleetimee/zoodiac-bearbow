import 'package:fleetime_genshin/cubit/character/character_cubit.dart';
import 'package:fleetime_genshin/cubit/character_detail/character_detail_cubit.dart';
import 'package:fleetime_genshin/data/datasources/character/character_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterCubit>(
          create: (_) => CharacterCubit(
            CharacterDatasource(),
          ),
        ),
        BlocProvider<CharacterDetailCubit>(
          create: (_) => CharacterDetailCubit(
            CharacterDatasource(),
          ),
        ),
      ],
      child: child,
    );
  }
}
