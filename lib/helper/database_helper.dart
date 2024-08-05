// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../model/database_model.dart';
//
// class DatabaseHelper {
//   static Database? _db;
//
//   Future<Database> get db async {
//     if (_db != null) return _db!;
//     _db = await initDb();
//     return _db!;
//   }
//
//   initDb() async {
//     String path = join(await getDatabasesPath(), 'quotes.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE quotes (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             quote TEXT,
//             author TEXT,
//             like INTEGER,
//             category TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<void> insertQuote(QuoteModel quote) async {
//     final dbClient = await db;
//     await dbClient.insert(
//       'quotes',
//       quote.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<QuoteModel>> getLikedQuotes() async {
//     final dbClient = await db;
//     final List<Map<String, dynamic>> maps =
//     await dbClient.query('quotes', where: 'like = ?', whereArgs: [1]);
//
//     return List.generate(maps.length, (i) {
//       return QuoteModel.fromMap(maps[i]);
//     });
//   }
//
//
//   Future<void> deleteLikedQuote(QuoteModel quote) async {
//     try {
//       final dbClient = await db;
//       await dbClient.delete(
//         'quotes',
//         where: 'quote = ? AND author = ? AND category = ?',
//         whereArgs: [quote.quote, quote.author, quote.category],
//       );
//     } catch (e) {
//       print('Error deleting liked quote: $e');
//     }
//   }
// }

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
    print('Database path: $path');  // Check database path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating database tables');  // Confirm table creation
        await db.execute('''
          CREATE TABLE quotes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
    try {
      final dbClient = await db;
      await dbClient.insert(
        'quotes',
        quote.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Quote inserted: ${quote.toMap()}');  // Confirm insertion
    } catch (e) {
      print('Error inserting quote: $e');
    }
  }

  Future<List<QuoteModel>> getLikedQuotes() async {
    try {
      final dbClient = await db;
      final List<Map<String, dynamic>> maps = await dbClient.query(
        'quotes',
        where: 'like = ?',
        whereArgs: [1],
      );
      print('Fetched liked quotes: $maps');  // Confirm data retrieval
      return List.generate(maps.length, (i) {
        return QuoteModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error fetching liked quotes: $e');
      return [];
    }
  }

  Future<void> deleteLikedQuote(QuoteModel quote) async {
    try {
      final dbClient = await db;
      await dbClient.delete(
        'quotes',
        where: 'quote = ? AND author = ? AND category = ?',
        whereArgs: [quote.quote, quote.author, quote.category],
      );
      print('Quote deleted: ${quote.toMap()}');  // Confirm deletion
    } catch (e) {
      print('Error deleting liked quote: $e');
    }
  }
}
