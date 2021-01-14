import '../vm/vm.dart';

/// 模拟服务Event
abstract class MockServiceEvent {}

/// 初始化Event
class MockServiceInitEvent extends MockServiceEvent {
  @override
  String toString() => 'MockServiceInitEvent';
}

/// 改变项目值Event
class MockServiceChangeItemValueEvent extends MockServiceEvent {
  /// Key
  final String key;

  /// 最新值
  final dynamic newVal;

  MockServiceChangeItemValueEvent({this.key, this.newVal});

  @override
  String toString() => 'MockServiceChangeItemValueEvent';
}

/// 改变列表值Event
class MockServiceChangeListValueEvent extends MockServiceEvent {
  /// 模拟服务信息 View
  final MockServiceInfoView infoView;

  /// Key
  final String key;

  /// 最新值
  final dynamic newVal;

  MockServiceChangeListValueEvent({this.infoView, this.key, this.newVal});

  @override
  String toString() => 'MockServiceChangeListValueEvent';
}

/// 运行服务/关闭服务Event
class MockServiceToggleServiceEvent extends MockServiceEvent {
  MockServiceToggleServiceEvent();

  @override
  String toString() => 'MockServiceToggleServiceEvent';
}

/// 重新加载(配置及输入文件)Event
class MockServiceReloadEvent extends MockServiceEvent {
  MockServiceReloadEvent();

  @override
  String toString() => 'MockServiceReloadEvent';
}

/// 保存(配置及输入文件)Event
class MockServiceSaveEvent extends MockServiceEvent {
  MockServiceSaveEvent();

  @override
  String toString() => 'MockServiceSaveEvent';
}

/// 更新模拟服务信息Event
class MockServiceUpdateInfoEvent extends MockServiceEvent {
  ///
  final MockServiceInfoView infoView;

  MockServiceUpdateInfoEvent({this.infoView});

  @override
  String toString() => 'MockServiceUpdateInfoEvent';
}

/// 全部响应返回OK Event
class MockServiceAllResponseOKEvent extends MockServiceEvent {
  MockServiceAllResponseOKEvent();

  @override
  String toString() => 'MockServiceAllResponseOKEvent';
}

/// 全部使用默认目标主机Event
class MockServiceAllUseDefaultTargetHostEvent extends MockServiceEvent {
  /// 全部使用默认目标主机
  final bool allUseDefaultTargetHost;

  MockServiceAllUseDefaultTargetHostEvent({this.allUseDefaultTargetHost});

  @override
  String toString() => 'MockServiceAllUseDefaultTargetHostEvent';
}

/// 全部使用模拟服务Event
class MockServiceAllUseMockServiceEvent extends MockServiceEvent {
  /// 全部使用模拟服务
  final bool allUseMockService;

  MockServiceAllUseMockServiceEvent({this.allUseMockService});

  @override
  String toString() => 'MockServiceAllUseMockServiceEvent';
}

/// 搜索Event
class MockServiceSearchEvent extends MockServiceEvent {
  ///  搜索关键字
  final String keyword;

  MockServiceSearchEvent({this.keyword});

  @override
  String toString() => 'MockServiceSearchEvent';
}

/// 接收Go端通知表示信息Event
class MockServiceNotifiedEvent extends MockServiceEvent {
  ///  通知
  final String notification;

  MockServiceNotifiedEvent({this.notification});

  @override
  String toString() => 'MockServiceNotifiedEvent';
}

/// 接收Go端通知添加新的模拟服务信息Event
class MockServiceAddMockServiceInfoEvent extends MockServiceEvent {
  ///  模拟服务信息Map
  final Map info;

  MockServiceAddMockServiceInfoEvent({this.info});

  @override
  String toString() => 'MockServiceAddMockServiceInfoEvent';
}

/// 显示通知Event
class MockServiceShowNotificationEvent extends MockServiceEvent {
  MockServiceShowNotificationEvent();

  @override
  String toString() => 'MockServiceShowNotificationEvent';
}
