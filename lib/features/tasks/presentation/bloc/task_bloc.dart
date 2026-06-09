import 'package:bloc/bloc.dart';
import 'package:task_manager/features/tasks/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/get_task_usecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/update_task_usecase.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTaskUsecase getTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final AddTaskUsecase addTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;

  TaskBloc({
    required this.getTaskUsecase,
    required this.updateTaskUsecase,
    required this.addTaskUsecase,
    required this.deleteTaskUsecase,
  }) : super(TaskLoading()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddNewTaskEvent>(_onAddTask);
    on<UpdateExistingTaskEvent>(_onUpdateTask);
    on<DeleteExistingTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final tasks = await getTaskUsecase();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError('Failed to load tasks: $e'));
    }
  }

  Future<void> _onAddTask(
    AddNewTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await addTaskUsecase(event.task);
      add(LoadTasksEvent()); // refreshing the entire list
    } catch (e) {
      emit(TaskError('Failed to Add the task: $e'));
    }
  }

  Future<void> _onUpdateTask(
    UpdateExistingTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await updateTaskUsecase(event.task);
      add(LoadTasksEvent());
    } catch (e) {
      emit(TaskError('Failed to Update the task: $e'));
    }
  }

  Future<void> _onDeleteTask(
    DeleteExistingTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await deleteTaskUsecase(event.id);
      add(LoadTasksEvent());
    } catch (e) {
      emit(TaskError('Failed to Delete the task : $e'));
    }
  }
}
