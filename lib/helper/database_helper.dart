import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/database_model.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'quotes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE quotes (
            quote TEXT,
            author TEXT,
            liked INTEGER,
            category TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertQuote(QuoteModel quote) async {
    final dbClient = await db;
    await dbClient.insert(
      'quotes',
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QuoteModel>> getLikedQuotes() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps =
        await dbClient.query('quotes', where: 'liked = ?', whereArgs: [1]);

    return List.generate(maps.length, (i) {
      return QuoteModel.fromMap(maps[i]);
    });
  }
}
