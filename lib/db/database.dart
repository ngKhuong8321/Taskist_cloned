import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskist_clone/models/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE tasks (
  ${TaskFields.id} $idType,
  ${TaskFields.taskName} $textType, 
  ${TaskFields.done} $boolType,
)

''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;

    final json = task.toJson();
    final columns =
        '${TaskFields.id}, ${TaskFields.taskName}, ${TaskFields.done}';
    final values =
        '${json[TaskFields.taskName]}, ${json[TaskFields.taskName]}, ${json[TaskFields.done]}';
    final id =
        await db.rawInsert('INSERT INTO tasks ($columns) VALUES ($values)');
    return task.copy(id: id);
  }

  Future<Task> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'tasks',
      columns: TaskFields.values,
      where: '$TaskFields.id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Task.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;

    final orderBy = '${TaskFields.id} ASC';

    final result = await db.query('tasks', orderBy: orderBy);

    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<int> update(Task task) async {
    final db = await instance.database;

    return db.update(
      'tasks',
      task.toJson(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'tasks',
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
