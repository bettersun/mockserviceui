import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mockserviceui/plugin/go/mock_service/model/mock_service_info.dart';

import 'mock_service_plugin.dart';
import 'model/model.dart';

class MockServicePluginImpl extends MockServicePlugin {
  // go-flutter插件中的包名，两者必须一致
  final channel = MethodChannel('bettersun.go-flutter.plugin.mockservice');

  final helo = 'hello';
  final run = 'run';
  final close = 'close';
  final hostlist = 'hostlist';
  final infolist = 'infolist';

  final ModelGo modelGo = ModelGo();

  /// 获取目标主机列表
  @override
  Future<List<String>> targetHostList() async {
    final Map m = await channel.invokeMethod(hostlist);

    final List<String> list = modelGo.fromGoHostList(m);
    return list;
  }

  /// 获取模拟服务信息列表
  @override
  Future<List<MockServiceInfo>> mockServiceInfoList() async {
    final Map m = await channel.invokeMethod(infolist);
    final List<MockServiceInfo> list = modelGo.fromGoInfoList(m);
    return list;
  }

  /// 运行模拟服务
  @override
  Future<String> runMockService() async {
    final String result = await channel.invokeMethod('run');
    return result;
  }

  /// 关闭模拟服务
  @override
  Future<String> closeMockService() async {
    final String result = await channel.invokeMethod('close');
    return result;
  }
}
