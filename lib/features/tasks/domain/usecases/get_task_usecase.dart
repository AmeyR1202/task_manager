import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:task_manager/features/tasks/domain/repositories/task_repository.dart';

class GetTaskUsecase {
  final TaskRepository repository;

  GetTaskUsecase(this.repository);

  Future<List<TaskEntity>> call() async {
    return await repository.getTasks();
  }
}
