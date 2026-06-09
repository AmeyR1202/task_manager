import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:task_manager/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUsecase {
  final TaskRepository repository;

  UpdateTaskUsecase(this.repository);

  Future<void> call(TaskEntity updatedTask) async {
    return await repository.updateTask(updatedTask);
  }
}
