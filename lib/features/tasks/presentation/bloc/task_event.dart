import 'package:equatable/equatable.dart';
import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddNewTaskEvent extends TaskEvent {
  final TaskEntity task;
  const AddNewTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateExistingTaskEvent extends TaskEvent {
  final TaskEntity task;
  const UpdateExistingTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteExistingTaskEvent extends TaskEvent {
  final String id;
  const DeleteExistingTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}
