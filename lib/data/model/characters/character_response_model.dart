// https://api.genshin.dev/characters/<character_name>

import 'dart:convert';

class Character {
  String? name;
  String? title;
  String? vision;
  String? weapon;
  String? nation;
  String? affiliation;
  int? rarity;
  String? constellation;
  String? birthday;
  String? description;
  List<SkillTalent>? skillTalents;
  List<Constellation>? passiveTalents;
  List<Constellation>? constellations;
  String? visionKey;
  String? weaponType;

  Character({
    this.name,
    this.title,
    this.vision,
    this.weapon,
    this.nation,
    this.affiliation,
    this.rarity,
    this.constellation,
    this.birthday,
    this.description,
    this.skillTalents,
    this.passiveTalents,
    this.constellations,
    this.visionKey,
    this.weaponType,
  });

  factory Character.fromRawJson(String str) =>
      Character.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        name: json["name"],
        title: json["title"],
        vision: json["vision"],
        weapon: json["weapon"],
        nation: json["nation"],
        affiliation: json["affiliation"],
        rarity: json["rarity"],
        constellation: json["constellation"],
        birthday: json["birthday"],
        description: json["description"],
        skillTalents: json["skillTalents"] == null
            ? []
            : List<SkillTalent>.from(
                json["skillTalents"]!.map((x) => SkillTalent.fromJson(x))),
        passiveTalents: json["passiveTalents"] == null
            ? []
            : List<Constellation>.from(
                json["passiveTalents"]!.map((x) => Constellation.fromJson(x))),
        constellations: json["constellations"] == null
            ? []
            : List<Constellation>.from(
                json["constellations"]!.map((x) => Constellation.fromJson(x))),
        visionKey: json["vision_key"],
        weaponType: json["weapon_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "vision": vision,
        "weapon": weapon,
        "nation": nation,
        "affiliation": affiliation,
        "rarity": rarity,
        "constellation": constellation,
        "birthday": birthday,
        "description": description,
        "skillTalents": skillTalents == null
            ? []
            : List<dynamic>.from(skillTalents!.map((x) => x.toJson())),
        "passiveTalents": passiveTalents == null
            ? []
            : List<dynamic>.from(passiveTalents!.map((x) => x.toJson())),
        "constellations": constellations == null
            ? []
            : List<dynamic>.from(constellations!.map((x) => x.toJson())),
        "vision_key": visionKey,
        "weapon_type": weaponType,
      };
}

class Constellation {
  String? name;
  String? unlock;
  String? description;
  int? level;

  Constellation({
    this.name,
    this.unlock,
    this.description,
    this.level,
  });

  factory Constellation.fromRawJson(String str) =>
      Constellation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Constellation.fromJson(Map<String, dynamic> json) => Constellation(
        name: json["name"],
        unlock: json["unlock"],
        description: json["description"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "unlock": unlock,
        "description": description,
        "level": level,
      };
}

class SkillTalent {
  String? name;
  String? unlock;
  String? description;
  List<Upgrade>? upgrades;
  String? type;

  SkillTalent({
    this.name,
    this.unlock,
    this.description,
    this.upgrades,
    this.type,
  });

  factory SkillTalent.fromRawJson(String str) =>
      SkillTalent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SkillTalent.fromJson(Map<String, dynamic> json) => SkillTalent(
        name: json["name"],
        unlock: json["unlock"],
        description: json["description"],
        upgrades: json["upgrades"] == null
            ? []
            : List<Upgrade>.from(
                json["upgrades"]!.map((x) => Upgrade.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "unlock": unlock,
        "description": description,
        "upgrades": upgrades == null
            ? []
            : List<dynamic>.from(upgrades!.map((x) => x.toJson())),
        "type": type,
      };
}

class Upgrade {
  String? name;
  String? value;

  Upgrade({
    this.name,
    this.value,
  });

  factory Upgrade.fromRawJson(String str) => Upgrade.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Upgrade.fromJson(Map<String, dynamic> json) => Upgrade(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
