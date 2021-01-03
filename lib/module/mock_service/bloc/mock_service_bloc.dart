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

    // 启动服务/关闭服务
    if (event is MockServiceToggleServiceEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view = await service.toggleService(nowState.view);
      yield MockServiceDoneState(view: view);
    }

    // 重载
    if (event is MockServiceReloadEvent) {
      final MockServiceView view = await service.reload();
      yield MockServiceDoneState(view: view);
    }

    // 改变项目值
    if (event is MockServiceChangeItemValueEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          service.changeItemValue(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 改变列表值
    if (event is MockServiceChangeListValueEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.changeListValue(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 更新模拟服务信息
    if (event is MockServiceUpdateInfoEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.updateItem(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }
  }
}
