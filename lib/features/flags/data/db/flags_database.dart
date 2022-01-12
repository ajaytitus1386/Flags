import 'dart:async';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/utils/utils.dart';

class FlagsDatabase {
  static final FlagsDatabase db = FlagsDatabase._init();
  static Database? _database;
  FlagsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'flags_db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Country(
        name TEXT,
        cca3 TEXT,
        capital TEXT,
        region TEXT,
        flag_url TEXT ,
        UNIQUE(cca3)
        );
        ''');
  }

  final columns = 'name, cca3, capital, region, flag_url';

  insertCountry(CountryModel country) async {
    final database = await db.database;
    // Insert the country's details

    // final json = country.toJson();
    // final values =
    //     '${json["name"]}, ${json["cca3"]}, ${json["capital"]}, ${json["region"]}, ${json["flag_url"]}';

    final values =
        '"${country.name}", "${country.cca3}", "${country.capital}", "${country.region}", "${country.flagUrl}"';

    try {
      final id = await database
          .rawInsert('INSERT INTO Country ($columns) VALUES ($values)');
    } on Exception {
      throw Exception('Not Unique');
    }

    // final id = await database.insert('Country', country.toJson());

    // For each of the country's borders, insert the cca3 pairs into Borders Association table
    // country.borders.map((borderCountryCode) async {
    //   final border = {'cca3': country.cca3, 'border_cca3': borderCountryCode};
    //   await database.insert('Border', border);
    // });
  }

  Future<CountryModel> readCountry(String cca3) async {
    final database = await db.database;

    final maps = await database
        .rawQuery('SELECT $columns FROM Country WHERE cca3 = $cca3');

    if (maps.isNotEmpty) {
      return CountryModel.fromJson(maps.first);
    } else {
      throw Exception('ID $cca3 was not found');
    }
  }

  Future<List<CountryModel>> readCountriesByRegion(String region) async {
    final database = await db.database;
    const orderBy = 'name DESC';

    final result = await database.query(
      'Country',
      where: 'region = ?',
      whereArgs: [region],
      orderBy: orderBy,
    );

    return result.map((json) => CountryModel.fromJson(json)).toList();
  }

  Future<List<CountryModel>> readAllCountries() async {
    final database = await db.database;
    const orderBy = 'name DESC';

    final result = await database.query(
      'Country',
      orderBy: orderBy,
    );

    return result.map((json) => CountryModel.fromJson(json)).toList();
  }

  Future<int?> readRowCount() async {
    final database = await db.database;
    final result = await database.rawQuery('SELECT COUNT(*) FROM Country');
    int? count = firstIntValue(result);
    return count;
  }

  Future<int?> deleteAllCountries() async {
    final database = await db.database;
    final result = await database.rawDelete('DELETE FROM Country');
    return result;
  }

  Future close() async {
    final database = await db.database;
    database.close();
  }
}
