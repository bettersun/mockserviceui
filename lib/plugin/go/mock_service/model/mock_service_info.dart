/// 模拟服务信息(对应Go端的MockServiceInfo结构体)
class MockServiceInfo {
  /// 使用默认目标主机
  bool useDefaultTargetHost;

  /// 使用模拟服务
  bool useMockService;

  /// 目标主机
  String targetHost;

  /// URI
  String uri;

  /// HTTP请求方法
  String method;

  /// 响应状态码
  int statusCode;

  /// 响应文件
  String responseFile;

  MockServiceInfo({
    this.useDefaultTargetHost = false,
    this.useMockService = false,
    this.targetHost = '',
    this.uri = '',
    this.method = '',
    this.statusCode = 0,
    this.responseFile = '',
  });

  MockServiceInfo.fromJson(Map<dynamic, dynamic> json) {
    useDefaultTargetHost = json['useDefaultTargetHost'] as bool;
    useMockService = json['useMockService'] as bool;
    targetHost = json['targetHost'] as String;
    uri = json['uri'] as String;
    method = json['method'] as String;
    statusCode = (json['statusCode'] as double).toInt();
    responseFile = json['responseFile'] as String;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};

    data['useDefaultTargetHost'] = useDefaultTargetHost;
    data['useMockService'] = useMockService;
    data['targetHost'] = targetHost;
    data['uri'] = uri;
    data['method'] = method;
    data['statusCode'] = statusCode;
    data['responseFile'] = responseFile;

    return data;
  }
}
