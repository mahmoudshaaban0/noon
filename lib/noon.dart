import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noon/common/navigation/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:noon/common/theme/app_theme.dart';
import 'package:noon/features/home/cubit/cart_cubit.dart';

import 'generated/l10n.dart';

class Noon extends StatelessWidget {
  const Noon({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => CartCubit())],
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Noon',
        theme: AppTheme.getApplicationTheme(),
        routerConfig: AppRouter.appRouter,
      ),
    );
  }
}
