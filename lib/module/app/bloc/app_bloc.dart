import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../service/app_service.dart';

import 'bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  KiwiContainer container = KiwiContainer();

  AppBloc() : super(AppInitState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    final AppService service = container<AppService>();

    // 初始化
    if (event is AppInitEvent) {
      final AppDoneState resultState = await service.init();
      yield resultState;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    print(stackTrace);

    super.onError(error, stackTrace);
  }
}
