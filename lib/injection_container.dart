import 'package:get_it/get_it.dart';
import 'package:task_manager/core/database/app_database.dart';
import 'package:task_manager/features/tasks/data/datasource/task_local_datasource.dart';
import 'package:task_manager/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:task_manager/features/tasks/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/get_task_usecase.dart';
import 'package:task_manager/features/tasks/domain/usecases/update_task_usecase.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance; // sl => Service Locator

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => TaskBloc(
      getTaskUsecase: sl(),
      updateTaskUsecase: sl(),
      addTaskUsecase: sl(),
      deleteTaskUsecase: sl(),
    ),
  );

  // init of domain layer
  sl.registerLazySingleton(() => GetTaskUsecase(sl()));
  sl.registerLazySingleton(() => AddTaskUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));

  // data layer repository and datasources
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(sl()),
  );

  // database of core folder
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
}
