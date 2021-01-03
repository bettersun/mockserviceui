import 'package:mockserviceui/module/mock_service/vm/vm.dart';

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
  /// 下标
  final int index;

  /// Key
  final String key;

  /// 最新值
  final dynamic newVal;

  MockServiceChangeListValueEvent({this.index, this.key, this.newVal});

  @override
  String toString() => 'MockServiceChangeListValueEvent';
}

/// 运行服务/关闭服务Event
class MockServiceToggleServiceEvent extends MockServiceEvent {
  MockServiceToggleServiceEvent();

  @override
  String toString() => 'MockServiceToggleServiceEvent';
}

/// 重新加载(运行时各种配置及输入文件)Event
class MockServiceReloadEvent extends MockServiceEvent {
  MockServiceReloadEvent();

  @override
  String toString() => 'MockServiceReloadEvent';
}

/// 更新模拟服务信息Event
class MockServiceUpdateInfoEvent extends MockServiceEvent {
  ///
  final MockServiceInfoView infoView;

  MockServiceUpdateInfoEvent({this.infoView});

  @override
  String toString() => 'MockServiceUpdateInfoEvent';
}
