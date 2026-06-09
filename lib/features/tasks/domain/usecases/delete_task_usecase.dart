import 'package:task_manager/features/tasks/domain/repositories/task_repository.dart';

class DeleteTaskUsecase {
  final TaskRepository repository;

  DeleteTaskUsecase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTask(id);
  }
}
