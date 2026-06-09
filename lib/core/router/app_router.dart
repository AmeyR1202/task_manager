import 'package:go_router/go_router.dart';
import 'package:task_manager/features/tasks/presentation/pages/add_task_page.dart';
import 'package:task_manager/features/tasks/presentation/pages/task_list_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/taskList',
      builder: (context, state) => const TaskListPage(),
    ),
    GoRoute(
      path: '/add-task',
      builder: (context, state) => const AddTaskPage(),
    ),
  ],
);
