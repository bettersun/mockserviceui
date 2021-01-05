import 'package:equatable/equatable.dart';

/// 模拟服务信息View
class MockServiceInfoView extends Equatable {
  // /// 默认目标主机
  // final String defaultTargetHost;

  /// 使用默认目标主机
  final bool useDefaultTargetHost;

  /// 目标主机
  final String targetHost;

  /// 当前使用的目标主机
  /// 使用默认目标主机为true时，表示默认目标主机
  /// 使用默认目标主机为false时，表示当前的目标主机
  final String currentTargetHost;

  /// URI
  final String uri;

  /// 使用模拟服务
  final bool useMockService;

  /// 响应文件
  final String responseFile;

  const MockServiceInfoView({
    // this.defaultTargetHost = '',
    this.useDefaultTargetHost = false,
    this.targetHost = '',
    this.currentTargetHost = '',
    this.uri = '',
    this.useMockService = false,
    this.responseFile = '',
  });

  @override
  List<Object> get props => [
        // defaultTargetHost,
        useDefaultTargetHost,
        targetHost,
        currentTargetHost,
        uri,
        useMockService,
        responseFile
      ];

  MockServiceInfoView copyWith({
    String defaultTargetHost,
    bool useDefaultTargetHost,
    String targetHost,
    String currentTargetHost,
    String uri,
    bool useMockService,
    String responseFile,
  }) {
    return MockServiceInfoView(
      // defaultTargetHost: defaultTargetHost ?? this.defaultTargetHost,
      useDefaultTargetHost: useDefaultTargetHost ?? this.useDefaultTargetHost,
      targetHost: targetHost ?? this.targetHost,
      currentTargetHost: currentTargetHost ?? this.currentTargetHost,
      uri: uri ?? this.uri,
      useMockService: useMockService ?? this.useMockService,
      responseFile: responseFile ?? this.responseFile,
    );
  }
}
