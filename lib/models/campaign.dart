class CampaignModel {
  static const String table = 'campaigns';

  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String theme = 'theme';

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = "TEXT NOT NULL";
  static const String boolType = "BOOLEAN NOT NULL";
  static const String intType = "INTEGER NOT NULL";

  static const List<String> fields = [id, name, description, theme];
}

class Campaign {
  final int? id;
  final String name;
  final String description;
  final String theme;

  const Campaign(
      {this.id,
      required this.name,
      required this.description,
      required this.theme});

  Campaign copy({
    int? id,
    String? name,
    String? description,
    String? theme,
  }) =>
      Campaign(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        theme: theme ?? this.theme,
      );

  static Campaign fromJson(Map<String, dynamic> json) => Campaign(
        id: json[CampaignModel.id] as int?,
        name: json[CampaignModel.name] as String,
        description: json[CampaignModel.description] as String,
        theme: json[CampaignModel.theme] as String,
      );

  Map<String, Object?> toJson() => {
        CampaignModel.id: id,
        CampaignModel.name: name,
        CampaignModel.description: description,
        CampaignModel.theme: theme,
      };
}
