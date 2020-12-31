/// 模拟服务信息(对应Go端的MockServiceInfo结构体)
class MockServiceInfo {
  /// 使用默认目标主机
  bool useDefaultTargetHost;

  /// 目标主机
  String targetHost;

  /// URI
  String uri;

  /// 使用模拟服务
  bool useMockService;

  /// 响应文件
  String responseFile;

  MockServiceInfo({
    this.useDefaultTargetHost = false,
    this.targetHost = '',
    this.uri = '',
    this.useMockService = false,
    this.responseFile = '',
  });

  MockServiceInfo.fromJson(Map<dynamic, dynamic> json) {
    useDefaultTargetHost = json['useDefaultTargetHost'] as bool;
    targetHost = json['targetHost'] as String;
    uri = json['uri'] as String;
    useMockService = json['useMockService'] as bool;
    responseFile = json['responseFile'] as String;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};

    data['useDefaultTargetHost'] = useDefaultTargetHost;
    data['targetHost'] = targetHost;
    data['uri'] = uri;
    data['useMockService'] = useMockService;
    data['responseFile'] = responseFile;

    return data;
  }
}
