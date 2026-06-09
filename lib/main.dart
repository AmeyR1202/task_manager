import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/router/app_router.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_manager/injection_container.dart';
import 'package:task_manager/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TaskBloc>()..add(LoadTasksEvent())),
      ],
      child: MaterialApp.router(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark, // Force dark mode to match the design
      ),
    );
  }
}
