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

    // 保存
    if (event is MockServiceSaveEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view = await service.save(nowState.view);
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
          await service.updateFromDetail(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 全部响应返回OK
    if (event is MockServiceAllResponseOKEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.allResponseOK(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 全部使用默认目标主机
    if (event is MockServiceAllUseDefaultTargetHostEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.allUseDefaultTargetHost(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 全部使用模拟服务
    if (event is MockServiceAllUseMockServiceEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view =
          await service.allUseMockService(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 搜索
    if (event is MockServiceSearchEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view = service.search(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 接收Go端通知
    if (event is MockServiceNotifiedEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view = service.notify(nowState.view, event);
      yield MockServiceDoneState(view: view);
    }

    // 显示/隐藏通知
    if (event is MockServiceShowNotificationEvent) {
      final MockServiceDoneState nowState = state as MockServiceDoneState;
      final MockServiceView view = service.showNotification(nowState.view);
      yield MockServiceDoneState(view: view);
    }
  }
}
