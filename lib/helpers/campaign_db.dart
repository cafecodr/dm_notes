import 'package:dm_notes/models/campaign.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CampaignDatabase {
  static final CampaignDatabase instance = CampaignDatabase._init();

  static Database? _database;

  CampaignDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("campaign.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("""
        CREATE TABLE ${CampaignModel.table} (
          ${CampaignModel.id} ${CampaignModel.idType},
          ${CampaignModel.name} ${CampaignModel.textType},
          ${CampaignModel.description} ${CampaignModel.textType},
          ${CampaignModel.theme} ${CampaignModel.textType}
        )
    """);
  }

  Future<Campaign> create(Campaign campaign) async {
    final db = await instance.database;
    final id = await db.insert(CampaignModel.table, campaign.toJson());

    return campaign.copy(id: id);
  }

  Future<Campaign> readCampaign(int id) async {
    final db = await instance.database;

    final maps = await db.query(CampaignModel.table,
        columns: CampaignModel.fields,
        where: '${CampaignModel.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Campaign.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Campaign>> readAllCampaigns() async {
    final db = await instance.database;
    const orderBy = '${CampaignModel.name} ASC';

    final result = await db.query(CampaignModel.table, orderBy: orderBy);

    return result.map((json) => Campaign.fromJson(json)).toList();
  }

  Future<int> update(Campaign campaign) async {
    final db = await instance.database;

    return await db.update(CampaignModel.table, campaign.toJson(),
        where: '${CampaignModel.id} = ?', whereArgs: [campaign.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(CampaignModel.table,
        where: '${CampaignModel.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
