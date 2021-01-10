import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'module/app/bloc/bloc.dart';
import 'module/mock_service/mock_service_page.dart';

/// 主程序
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            home: BlocProvider(
              create: (_) => AppBloc(),
              // child: AppPage(),
              child: MockServicePage(),
            ),
          );
        },
      ),
    );
  }
}
