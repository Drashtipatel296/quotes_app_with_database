import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/database_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quotes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      // onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quote TEXT,
        author TEXT,
        category TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE liked_quotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quote_id INTEGER,
        FOREIGN KEY (quote_id) REFERENCES quotes (id)
      )
    ''');
  }

  // Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     await db.execute('''
  //       CREATE TABLE liked_quotes (
  //         id INTEGER PRIMARY KEY AUTOINCREMENT,
  //         quote_id INTEGER,
  //         FOREIGN KEY (quote_id) REFERENCES quotes (id)
  //       )
  //     ''');
  //   }
  // }

  Future<void> addCategoryColumn() async {
    final db = await database;

    var result = await db.rawQuery("PRAGMA table_info(quotes)");
    bool columnExists = result.any((column) => column['name'] == 'category');

    if (!columnExists) {
      await db.execute('''
        ALTER TABLE quotes
        ADD COLUMN category TEXT
      ''');
    }
  }

  Future<void> insertQuote(Quote quote) async {
    final db = await database;

    await db.insert(
      'quotes',
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> likeQuote(int quoteId) async {
    final db = await database;
    await db.insert('liked_quotes', {'quote_id': quoteId});
  }

  Future<void> unlikeQuote(int quoteId) async {
    final db = await database;
    await db.delete('liked_quotes', where: 'quote_id = ?', whereArgs: [quoteId]);
  }

  Future<List<Quote>> fetchLikedQuotes() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT quotes.* FROM quotes
      INNER JOIN liked_quotes ON quotes.id = liked_quotes.quote_id
    ''');
    return result.map((json) => Quote.fromMap(json)).toList();
  }

  Future<List<Quote>> fetchQuotes() async {
    final db = await database;
    final result = await db.query('quotes');
    return result.map((json) => Quote.fromMap(json)).toList();
  }
}