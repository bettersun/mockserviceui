import 'package:equatable/equatable.dart';

/// 模拟服务信息View
class MockServiceInfoView extends Equatable {
  // /// 默认目标主机
  // final String defaultTargetHost;

  /// 使用默认目标主机
  final bool useDefaultTargetHost;

  /// 使用模拟服务
  final bool useMockService;

  /// 目标主机
  final String targetHost;

  /// 当前使用的目标主机
  /// 使用默认目标主机为true时，表示默认目标主机
  /// 使用默认目标主机为false时，表示当前的目标主机
  final String currentTargetHost;

  /// URI
  final String uri;

  /// HTTP请求方法
  final String method;

  /// 响应状态码
  final int statusCode;

  /// 响应状态码列表
  final List<String> statusCodeList;

  /// 响应文件
  final String responseFile;

  /// 可见性
  final bool visible;

  const MockServiceInfoView({
    // this.defaultTargetHost = '',
    this.useDefaultTargetHost = false,
    this.useMockService = false,
    this.targetHost = '',
    this.currentTargetHost = '',
    this.uri = '',
    this.method = '',
    this.statusCode = 0,
    this.statusCodeList = const [],
    this.responseFile = '',
    this.visible = false,
  });

  @override
  List<Object> get props => [
        // defaultTargetHost,
        useDefaultTargetHost,
        useMockService,
        targetHost,
        currentTargetHost,
        uri,
        method,
        statusCode,
        statusCodeList,
        responseFile,
        visible,
      ];

  MockServiceInfoView copyWith({
    String defaultTargetHost,
    bool useDefaultTargetHost,
    bool useMockService,
    String targetHost,
    String currentTargetHost,
    String uri,
    String method,
    int statusCode,
    List<String> statusCodeList,
    String responseFile,
    bool visible,
  }) {
    return MockServiceInfoView(
      // defaultTargetHost: defaultTargetHost ?? this.defaultTargetHost,
      useDefaultTargetHost: useDefaultTargetHost ?? this.useDefaultTargetHost,
      useMockService: useMockService ?? this.useMockService,
      targetHost: targetHost ?? this.targetHost,
      currentTargetHost: currentTargetHost ?? this.currentTargetHost,
      uri: uri ?? this.uri,
      method: method ?? this.method,
      statusCode: statusCode ?? this.statusCode,
      statusCodeList: statusCodeList ?? this.statusCodeList,
      responseFile: responseFile ?? this.responseFile,
      visible: visible ?? this.visible,
    );
  }
}
