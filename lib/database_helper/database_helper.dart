import 'package:book_store/model/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  String databaseName = 'bookstore.db';
  String tableName = 'book';

  String column_id = 'id';
  String column_book_name = 'bookName';
  String column_author_name = 'authorName';
  String column_price = 'price';

  Future<Database> getDatabase() async {
    var dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, databaseName),
      version: 1,
      onCreate: createDatabase,
    );
  }

  createDatabase(Database db, int version) async {
    String sql =
        'CREATE TABLE $tableName ($column_id INTEGER PRIMARY KEY AUTOINCREMENT, $column_book_name TEXT,$column_author_name TEXT, $column_price INTEGER)';
    await db.execute(sql);
  }

  Future<int> insertBook(Book book) async {
    Database db = await getDatabase();
    return db.insert(tableName, book.toMap());
  }

  Future<List<Book>> getAllBook() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> listmap = await db.query(tableName);
    // List<Book> listbook = [];
    // for (Map<String, dynamic> map in listmap) {
    //   listbook.add(Book.fromMap(map));
    // }
    // return listbook;
    return listmap.map((e) => Book.fromMap(e)).toList();
  }

  Future<int> updateBook(Book book, id) async {
    Database db = await getDatabase();
    return db.update(
      tableName,
      book.toMap(),
      where: '$column_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteBook(id) async {
    Database db = await getDatabase();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
