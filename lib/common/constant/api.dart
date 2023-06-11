enum EndPoint { characters, weapons, error }

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
}
