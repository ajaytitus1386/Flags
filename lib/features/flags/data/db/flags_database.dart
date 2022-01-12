import 'dart:async';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/utils/utils.dart';

class FlagsDatabase {
  static final FlagsDatabase db = FlagsDatabase._init();
  static Database? _database;
  FlagsDatabase._init();

  /// Initializes database if not already `null`
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

  /// Creates Country Table on initialization of database
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

  /// Inserts a new `CountryModel` into database
  ///
  /// Returns `id` of new record
  Future<int> insertCountry(CountryModel country) async {
    final database = await db.database;
    // Insert the country's details
    final values =
        '"${country.name}", "${country.cca3}", "${country.capital}", "${country.region}", "${country.flagUrl}"';

    try {
      final id = await database
          .rawInsert('INSERT INTO Country ($columns) VALUES ($values)');
      return id;
    } on Exception {
      throw Exception('Not Unique');
    }
  }

  Future<void> insertCountries(List<CountryModel> result) async {
    for (var country in result) {
      await FlagsDatabase.db.insertCountry(country);
    }
  }

  /// Returns a `CountryModel` from database by its cca3 code
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

  /// Returns `List<CountryModel>` from database by its region
  Future<List<CountryModel>> readCountriesByRegion(String region) async {
    final database = await db.database;
    const orderBy = 'name ASC';

    final result = await database.query(
      'Country',
      where: 'region = ?',
      whereArgs: [region],
      orderBy: orderBy,
    );

    return result.map((json) => CountryModel.fromJson(json)).toList();
  }

  /// Returns a `List<CountryModel>` of all countries in database
  Future<List<CountryModel>> readAllCountries() async {
    final database = await db.database;
    const orderBy = 'name ASC';

    final result = await database.query(
      'Country',
      orderBy: orderBy,
    );

    return result.map((json) => CountryModel.fromJson(json)).toList();
  }

  /// Returns `count` of rows in Country table
  Future<int?> readRowCount() async {
    final database = await db.database;
    final result = await database.rawQuery('SELECT COUNT(*) FROM Country');
    int? count = firstIntValue(result);
    return count;
  }

  /// Deletes all records in Country Table
  ///
  /// Returns `count` of deleted rows
  Future<int?> deleteAllCountries() async {
    final database = await db.database;
    final count = await database.rawDelete('DELETE FROM Country');
    return count;
  }

  /// Closes Database connection
  Future close() async {
    final database = await db.database;
    database.close();
  }
}
