import 'package:go_router/go_router.dart';
import 'package:task_manager/features/tasks/presentation/pages/add_task_page.dart';
import 'package:task_manager/features/tasks/presentation/pages/task_list_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TaskListPage(),
    ),
    GoRoute(
      path: '/addTask',
      builder: (context, state) => const AddTaskPage(),
    ),
  ],
);
