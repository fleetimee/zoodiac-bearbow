enum EndPoint { characters, weapons, error }

enum CharacterImageType {
  icon,
  iconBig,
  card,
  portrait,
  side,
  full,
  error,
  gachaSplash
}

class GenshinConst {
  static const baseUrl = 'https://api.genshin.dev/';

  static String getEndpointUrl(EndPoint endPoint) {
    switch (endPoint) {
      case EndPoint.characters:
        return '${baseUrl}characters/';
      case EndPoint.weapons:
        return '${baseUrl}weapons/';
      default:
        throw ArgumentError('Invalid EndPoint');
    }
  }

  static String getImageUrl(CharacterImageType imageType, String name) {
    switch (imageType) {
      case CharacterImageType.icon:
        return '${getEndpointUrl(EndPoint.characters)}$name/${CharacterImageType.icon}';
      case CharacterImageType.iconBig:
        return '${getEndpointUrl(EndPoint.characters)}$name/${CharacterImageType.iconBig}';
      case CharacterImageType.card:
        return '${getEndpointUrl(EndPoint.characters)}$name/card';
      case CharacterImageType.portrait:
        return '${getEndpointUrl(EndPoint.characters)}$name/portrait';
      case CharacterImageType.gachaSplash:
        return '${getEndpointUrl(EndPoint.characters)}$name/gacha-splash';
      case CharacterImageType.full:
        return '${getEndpointUrl(EndPoint.characters)}$name/${CharacterImageType.full}';
      default:
        throw ArgumentError('Invalid CharacterImageType');
    }
  }

  static String getCardUrl(String name) =>
      getImageUrl(CharacterImageType.card, name);

  static String getPortraitUrl(String name) =>
      getImageUrl(CharacterImageType.portrait, name);

  static String getGachaSplashUrl(String name) =>
      getImageUrl(CharacterImageType.gachaSplash, name);
}
