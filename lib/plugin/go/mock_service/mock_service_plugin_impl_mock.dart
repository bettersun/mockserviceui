import 'dart:async';

import 'package:mockserviceui/plugin/go/mock_service/model/mock_service_info.dart';

import 'mock_service_plugin.dart';

class MockServicePluginImplMock extends MockServicePlugin {
  /// 获取目标主机列表
  @override
  Future<List<String>> targetHostList() async {
    final List<String> list = [];

    list.add('http://127.0.0.1:8012');
    list.add('http://127.0.0.1:8016');
    list.add('http://192.168.1.9:9999');
    list.add('http://192.168.1.12:9001');
    list.add('http://192.168.1.12:9002');
    list.add('http://192.168.1.12:9003');

    return list;
  }

  /// 获取模拟服务信息列表
  @override
  Future<List<MockServiceInfo>> mockServiceInfoList() async {
    final List<MockServiceInfo> list = [];

    final MockServiceInfo info = MockServiceInfo(
      targetHost: 'http://127.0.0.1:8012',
      useDefaultTargetHost: true,
      uri: '/bettersun',
      useMockService: false,
      responseFile: '/json/bettersun.json',
    );

    final MockServiceInfo info1 = MockServiceInfo(
      targetHost: 'http://127.0.0.1:8012',
      useDefaultTargetHost: false,
      uri: '/bettersun/hello',
      useMockService: false,
      responseFile: '/json/hello.json',
    );

    final MockServiceInfo info2 = MockServiceInfo(
      targetHost: 'http://127.0.0.1:8012',
      useDefaultTargetHost: true,
      uri: '/bettersun/goodbye',
      useMockService: true,
      responseFile: '/json/goodbye.json',
    );

    list.add(info);
    list.add(info1);
    list.add(info2);
    // list.add(info1);
    // list.add(info2);
    // list.add(info1);
    // list.add(info2);
    // list.add(info1);
    // list.add(info2);
    // list.add(info1);
    // list.add(info2);

    return list;
  }

  /// 运行服务
  @override
  Future<String> runService() async {
    final String result = await channel.invokeMethod('run');
    return result;
  }

  /// 关闭服务
  @override
  Future<bool> closeService() async {
    final bool result = await channel.invokeMethod('close');
    return result;
  }

  /// 重新加载(配置及输入文件)
  @override
  Future<bool> reload() {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveInfo() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isRunning() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> responseFileList(String uri, String method) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateInfo(MockServiceInfo info) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateAllInfo(List<MockServiceInfo> infoList) {
    throw UnimplementedError();
  }
}
