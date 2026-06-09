import 'package:task_manager/core/database/app_database.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskTableData>> getTasks();
  Future<void> addTask(TaskTableCompanion task);
  Future<void> updateTask(TaskTableCompanion task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final AppDatabase database;
  TaskLocalDataSourceImpl(this.database);

  @override
  Future<List<TaskTableData>> getTasks() async {
    return await database.select(database.taskTable).get();
  }

  @override
  Future<void> addTask(TaskTableCompanion task) async {
    await database.into(database.taskTable).insert(task);
  }

  @override
  Future<void> updateTask(TaskTableCompanion task) async {
    await database.update(database.taskTable).replace(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await (database.delete(
      database.taskTable,
    )..where((t) => t.id.equals(id))).go();
  }
}
