import 'package:fleetime_genshin/ui/character/character_details_page.dart';
import 'package:fleetime_genshin/ui/character/character_home_page.dart';
import 'package:go_router/go_router.dart';

enum RouteName {
  characterDetail,
  characterHome,
  characterList,
  characterSearch,
  home,
  splash,
}

final routerSettings = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GenshinCharacterHomePage(),
    ),
    GoRoute(
      path: '/characters/:characterName',
      builder: (context, state) => GenshinCharacterDetailPage(
        characterName: state.pathParameters['characterName']!,
      ),
    ),
  ],
);
