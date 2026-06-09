import 'package:equatable/equatable.dart';
import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  const TaskLoaded({this.tasks = const []});

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;
  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
