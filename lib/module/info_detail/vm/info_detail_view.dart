import 'package:equatable/equatable.dart';

import 'detail_response_view.dart';

/// 模拟服务信息详细View
class InfoDetailView extends Equatable {
  /// 运行时信息
  final String info;

  // /// 默认目标主机
  // final String defaultTargetHost;

  /// 使用默认目标主机
  final bool useDefaultTargetHost;

  /// 使用模拟服务
  final bool useMockService;

  /// 目标主机
  final String targetHost;

  /// 当前使用的目标主机
  /// 使用默认目标主机为true时，表示 '默认目标主机'
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

  /// 响应文件列表
  final List<DetailResponseView> responseList;

  const InfoDetailView({
    this.info = '',
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
    this.responseList = const [],
  });

  @override
  List<Object> get props => [
        info,
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
        responseList,
      ];

  InfoDetailView copyWith({
    String info,
    // String defaultTargetHost,
    bool useDefaultTargetHost,
    bool useMockService,
    String targetHost,
    String currentTargetHost,
    String uri,
    String method,
    List<String> statusCodeList,
    int statusCode,
    String responseFile,
    List<DetailResponseView> responseList,
  }) {
    return InfoDetailView(
      info: info ?? this.info,
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
      responseList: responseList ?? this.responseList,
    );
  }
}
