
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CharacterDatabase {
  static final CharacterDatabase _instance = CharacterDatabase._internal();
  factory CharacterDatabase() => _instance;

  static Database? _database;

  CharacterDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'characters.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute("""
          CREATE TABLE characters (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            status TEXT NOT NULL,
            species TEXT NOT NULL,
            type TEXT,
            gender TEXT NOT NULL,
            image TEXT NOT NULL,
            url TEXT NOT NULL,
            created TEXT NOT NULL
          );
        """);


        await db.execute("""
          CREATE TABLE favorites (
            character_id INTEGER PRIMARY KEY,
            FOREIGN KEY(character_id) REFERENCES characters(id) ON DELETE CASCADE
          );
        """);
      },
    );
  }


  Future<void> insertCharacters(List<CharacterModel> characters) async {
    final db = await database;
    Batch batch = db.batch();

    for (var character in characters) {
      batch.insert(
        'characters',
        character.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> insertCharacter(CharacterModel character) async {
    final db = await database;
    await db.insert(
      'characters',
      character.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('characters');

    return List.generate(maps.length, (i) {
      return CharacterModel.fromJson(maps[i]);
    });
  }

  Future<void> deleteCharacter(int id) async {
    final db = await database;
    await db.delete(
      'characters',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> addFavorite(int characterId) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'character_id': characterId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }


  Future<void> removeFavorite(int characterId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'character_id = ?',
      whereArgs: [characterId],
    );
  }


  Future<List<int>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return maps[i]['character_id'] as int;
    });
  }


  Future<bool> isFavorite(int characterId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'character_id = ?',
      whereArgs: [characterId],
    );

    return result.isNotEmpty;
  }
}
