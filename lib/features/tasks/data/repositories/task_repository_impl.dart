import 'package:drift/drift.dart';
import 'package:task_manager/core/database/app_database.dart';
import 'package:task_manager/features/tasks/data/datasource/task_local_datasource.dart';
import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:task_manager/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<TaskEntity>> getTasks() async {
    final tasksData = await localDataSource.getTasks();

    return tasksData.map((data) => _fromDriftDataToEntity(data)).toList();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    await localDataSource.addTask(_fromEntityToDriftCompanion(task));
  }

  @override
  Future<void> updateTask(TaskEntity updatedTask) async {
    await localDataSource.updateTask(_fromEntityToDriftCompanion(updatedTask));
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }

  // this maps our drift db to the domain entity
  TaskEntity _fromDriftDataToEntity(TaskTableData data) {
    return TaskEntity(
      id: data.id,
      title: data.title,
      description: data.description,
      dueDate: data.dueDate,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == data.priority,
        orElse: () => TaskPriority.medium,
      ),
      isCompleted: data.isCompleted,
    );
  }

  // this maps our domain entity to the drift companion entity
  TaskTableCompanion _fromEntityToDriftCompanion(TaskEntity entity) {
    return TaskTableCompanion(
      id: Value(entity.id),
      title: Value(entity.title),
      description: Value(entity.description),
      dueDate: Value(entity.dueDate),
      priority: Value(entity.priority.name),
      isCompleted: Value(entity.isCompleted),
    );
  }
}
