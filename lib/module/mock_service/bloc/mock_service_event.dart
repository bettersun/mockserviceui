/// 模拟服务Event
abstract class MockServiceEvent {}

/// 初始化Event
class MockServiceInitEvent extends MockServiceEvent {
  @override
  String toString() => 'MockServiceInitEvent';
}

/// 改变项目值Event
class MockServiceChangeItemValueEvent extends MockServiceEvent {
  // Key
  final String key;
  // 最新值
  final dynamic newVal;

  MockServiceChangeItemValueEvent({this.key, this.newVal});

  @override
  String toString() => 'MockServiceChangeItemValueEvent';
}

/// 改变列表值Event
class MockServiceChangeListValueEvent extends MockServiceEvent {
  // 下标
  final int index;
  // Key
  final String key;
  // 最新值
  final dynamic newVal;

  MockServiceChangeListValueEvent({this.index, this.key, this.newVal});

  @override
  String toString() => 'MockServiceChangeListValueEvent';
}

/// 运行服务Event
class MockServiceRunEvent extends MockServiceEvent {
  MockServiceRunEvent();

  @override
  String toString() => 'MockServiceRunEvent';
}

/// 重新加载运行时模拟服务信息Event
class MockServiceReloadEvent extends MockServiceEvent {
  MockServiceReloadEvent();

  @override
  String toString() => 'MockServiceReloadEvent';
}

/// 关闭服务Event
class MockServiceCloseEvent extends MockServiceEvent {
  MockServiceCloseEvent();

  @override
  String toString() => 'MockServiceCloseEvent';
}
