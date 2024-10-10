import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noon/common/shared_widgets/custom_bottom_nav_bar.dart';

class AppRouter {
  static final appRouter = GoRouter(routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: CustomBottomNavBar(),
      ),
    ),
  ]);
}
