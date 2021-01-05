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

  /// 目标主机
  final String targetHost;

  /// 当前使用的目标主机
  /// 使用默认目标主机为true时，表示 '默认目标主机'
  /// 使用默认目标主机为false时，表示当前的目标主机
  final String currentTargetHost;

  /// URI
  final String uri;

  /// 使用模拟服务
  final bool useMockService;

  /// 响应文件
  final String responseFile;

  /// 响应文件列表
  final List<DetailResponseView> responseList;

  const InfoDetailView({
    this.info = '',
    // this.defaultTargetHost = '',
    this.useDefaultTargetHost = false,
    this.targetHost = '',
    this.currentTargetHost = '',
    this.uri = '',
    this.useMockService = false,
    this.responseFile = '',
    this.responseList = const [],
  });

  @override
  List<Object> get props => [
        info,
        // defaultTargetHost,
        useDefaultTargetHost,
        targetHost,
        currentTargetHost,
        uri,
        useMockService,
        responseFile,
        responseList,
      ];

  InfoDetailView copyWith({
    String info,
    // String defaultTargetHost,
    bool useDefaultTargetHost,
    String targetHost,
    String currentTargetHost,
    String uri,
    bool useMockService,
    String responseFile,
    List<DetailResponseView> responseList,
  }) {
    return InfoDetailView(
      info: info ?? this.info,
      // defaultTargetHost: defaultTargetHost ?? this.defaultTargetHost,
      useDefaultTargetHost: useDefaultTargetHost ?? this.useDefaultTargetHost,
      targetHost: targetHost ?? this.targetHost,
      currentTargetHost: currentTargetHost ?? this.currentTargetHost,
      uri: uri ?? this.uri,
      useMockService: useMockService ?? this.useMockService,
      responseFile: responseFile ?? this.responseFile,
      responseList: responseList ?? this.responseList,
    );
  }
}
