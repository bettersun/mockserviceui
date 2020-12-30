import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../service/service.dart';
import '../vm/vm.dart';
import 'bloc.dart';

/// 模拟服务Bloc
class MockServiceBloc extends Bloc<MockServiceEvent, MockServiceState> {
  KiwiContainer container = KiwiContainer();

  MockServiceBloc() : super(MockServiceInitState());

  @override
  Stream<MockServiceState> mapEventToState(
    MockServiceEvent event,
  ) async* {
    final MockServiceService service = container<MockServiceService>();

    // 初始化
    if (event is MockServiceInitEvent) {
      final MockServiceView view = await service.init();
      yield MockServiceDoneState(view: view);
    }

    if (event is MockServiceRunEvent) {
      final MockServiceView view = await service.run();
      yield MockServiceDoneState(view: view);
    }

    if (event is MockServiceCloseEvent) {
      final MockServiceView view = await service.close();
      yield MockServiceDoneState(view: view);
    }

    /// 改变项目值
    if (event is MockServiceChangeItemValueEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.changeItemValue(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    /// 改变列表值
    if (event is MockServiceChangeListValueEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.changeListValue(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }
  }
}
