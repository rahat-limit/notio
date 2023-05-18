import 'package:project/models/Note.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class LocalStorage {
  Future<sql.Database> init() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, text TEXT, category INTEGER, date datetime)');
    }, version: 1);

    return db;
  }

  Future insert({required Note note}) async {
    final db = await init();
    await db.insert('user_notes', {
      'id': note.id,
      'text': note.text,
      'category': note.category.index,
      'date': note.datetime.toString()
    });
  }

  Future<List<Note>> getData() async {
    final db = await init();
    final data = await db.query('user_notes', orderBy: "date DESC");
    final List<Note> notes = data.map((row) {
      Category? category;
      for (var elem in Category.values) {
        if (row['category'] == elem.index) {
          category = elem;
        }
      }
      return Note(
          id: row['id'] as String,
          text: row['text'] as String,
          category: category ?? Category.simple,
          datetime: DateTime.parse(row['date'] as String));
    }).toList();
    return notes;
  }

  Future deleteRow(String id) async {
    final db = await init();
    await db.delete('user_notes', where: 'id = ?', whereArgs: [id]);
  }

  Future updateRow({required Note note}) async {
    final db = await init();
    await db.rawDelete('DELETE FROM user_notes WHERE id = ?', [note.id]);
    await insert(note: note);
  }

  Future deleteAll() async {
    final db = await init();
    await db.delete('user_notes');
  }
}
