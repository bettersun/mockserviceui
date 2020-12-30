import 'package:equatable/equatable.dart';

import 'mock_service_info_view.dart';

/// 模拟服务View
class MockServiceView extends Equatable {
  /// 运行时信息
  /// 不同于模拟服务信息(MockServiceInfo)
  final String info;

  /// 目标主机列表
  final List<String> targetHostList;

  /// 默认目标主机
  final String defaultTargetHost;

  /// 全部使用模拟服务标志
  final bool useMockServiceAll;

  /// 模拟服务信息View列表
  final List<MockServiceInfoView> infoList;

  /// 服务运行中
  final bool isRunning;

  const MockServiceView({
    this.info = '',
    this.targetHostList = const [],
    this.defaultTargetHost = '',
    this.useMockServiceAll = false,
    this.infoList = const [],
    this.isRunning = false,
  });

  @override
  List<Object> get props => [
        info,
        targetHostList,
        defaultTargetHost,
        useMockServiceAll,
        infoList,
        isRunning
      ];

  MockServiceView copyWith({
    String info,
    List<String> targetHostList,
    String defaultTargetHost,
    bool useMockServiceAll,
    List<MockServiceInfoView> infoList,
    bool isRunning,
  }) {
    return MockServiceView(
      info: info ?? this.info,
      targetHostList: targetHostList ?? this.targetHostList,
      defaultTargetHost: defaultTargetHost ?? this.defaultTargetHost,
      useMockServiceAll: useMockServiceAll ?? this.useMockServiceAll,
      infoList: infoList ?? this.infoList,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
