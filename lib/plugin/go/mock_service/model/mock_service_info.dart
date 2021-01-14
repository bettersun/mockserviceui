/// 模拟服务信息(对应Go端的MockServiceInfo结构体)
class MockServiceInfo {
  /// URL
  String url;

  /// HTTP请求方法
  String method;

  /// 目标主机
  String targetHost;

  /// 使用默认目标主机
  bool useDefaultTargetHost;

  /// 使用模拟服务
  bool useMockService;

  /// 响应状态码
  int statusCode;

  /// 响应文件
  String responseFile;

  /// 说明
  String description;

  MockServiceInfo({
    this.useDefaultTargetHost = false,
    this.useMockService = false,
    this.targetHost = '',
    this.url = '',
    this.method = '',
    this.statusCode = 0,
    this.responseFile = '',
    this.description = '',
  });

  MockServiceInfo.fromJson(Map<dynamic, dynamic> json) {
    useDefaultTargetHost = json['useDefaultTargetHost'] as bool;
    useMockService = json['useMockService'] as bool;
    targetHost = json['targetHost'] as String;
    url = json['url'] as String;
    method = json['method'] as String;
    statusCode = (json['statusCode'] as double).toInt();
    responseFile = json['responseFile'] as String;
    description = json['description'] as String;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};

    data['useDefaultTargetHost'] = useDefaultTargetHost;
    data['useMockService'] = useMockService;
    data['targetHost'] = targetHost;
    data['url'] = url;
    data['method'] = method;
    data['statusCode'] = statusCode;
    data['responseFile'] = responseFile;
    data['description'] = description;

    return data;
  }
}
