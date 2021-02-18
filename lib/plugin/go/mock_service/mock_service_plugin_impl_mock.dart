import 'dart:async';

import 'mock_service_plugin.dart';
import 'model/mock_service_info.dart';

class MockServicePluginImplMock extends MockServicePlugin {
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

  @override
  Future<List<MockServiceInfo>> mockServiceInfoList() async {
    final List<MockServiceInfo> list = [];

    final MockServiceInfo info = MockServiceInfo(
      targetHost: 'http://127.0.0.1:8012',
      useDefaultTargetHost: true,
      url: '/bettersun',
      useMockService: false,
      responseFile: '/json/bettersun.json',
    );

    final MockServiceInfo info1 = MockServiceInfo(
      targetHost: 'http://127.0.0.1:8012',
      useDefaultTargetHost: false,
      url: '/bettersun/hello',
      useMockService: false,
      responseFile: '/json/hello.json',
    );

    final MockServiceInfo info2 = MockServiceInfo(
      targetHost: 'http://127.0.0.1:8012',
      useDefaultTargetHost: true,
      url: '/bettersun/goodbye',
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

  @override
  Future<String> runService() async {
    final String result = await channel.invokeMethod('run');
    return result;
  }

  @override
  Future<bool> closeService() async {
    final bool result = await channel.invokeMethod('close');
    return result;
  }

  @override
  Future<bool> load() {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveInfo() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> responseFileList(String url, String method) {
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

  @override
  Future<bool> renameResponseFile(String responseFile, String fileName) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setDefaultTargetHost(String targetHost) {
    throw UnimplementedError();
  }
}
