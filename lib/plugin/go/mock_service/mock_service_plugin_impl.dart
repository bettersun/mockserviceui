import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mockserviceui/plugin/go/mock_service/model/mock_service_info.dart';

import 'mock_service_plugin.dart';
import 'model/model.dart';

class MockServicePluginImpl extends MockServicePlugin {
  // go-flutter插件中的包名，两者必须一致
  final channel = MethodChannel('bettersun.go-flutter.plugin.mockservice');

  final funcNameHelo = 'hello';

  final funcNameRun = 'run';
  final funcNameClose = 'close';
  final funcNameReload = 'reload';
  final funcNameIsRunning = 'IsRunning';

  final funcNameSaveInfo = 'saveInfo';

  final funcNameHostlist = 'hostlist';
  final funcNameInfolist = 'infolist';
  final funcNameResponselist = 'responselist';

  final ModelGo modelGo = ModelGo();

  /// 获取目标主机列表
  @override
  Future<List<String>> targetHostList() async {
    final Map m = await channel.invokeMethod(funcNameHostlist);

    final List<String> list = modelGo.fromGoHostList(m);
    return list;
  }

  /// 获取模拟服务信息列表
  @override
  Future<List<MockServiceInfo>> mockServiceInfoList() async {
    final Map m = await channel.invokeMethod(funcNameInfolist);
    final List<MockServiceInfo> list = modelGo.fromGoInfoList(m);
    return list;
  }

  /// 运行服务
  @override
  Future<String> runService() async {
    final String result = await channel.invokeMethod(funcNameRun);
    return result;
  }

  /// 关闭服务
  @override
  Future<bool> closeService() async {
    final bool result = await channel.invokeMethod(funcNameClose);
    if (!result) {
      print('服务关闭失败');
    }
    return result;
  }

  /// 重新加载(运行时各种配置及输入文件)
  @override
  Future<bool> reload() async {
    final bool result = await channel.invokeMethod(funcNameReload);
    if (!result) {
      print('保存失败');
    }
    return result;
  }

  ///
  @override
  Future<bool> saveInfo(MockServiceInfo info) async {
    final Map m = info.toJson();
    final bool result = await channel.invokeMethod(funcNameSaveInfo, m);
    if (!result) {
      print('保存失败');
    }
    return result;
  }

  /// 运行中状态
  @override
  Future<bool> isRunning() async {
    final bool result = await channel.invokeMethod(funcNameIsRunning);
    return result;
  }

  /// 获取响应文件列表
  @override
  Future<List<String>> responseFileList(String uri) async {
    final Map m = await channel.invokeMethod(funcNameResponselist, uri);

    final List<String> list = modelGo.fromGoResponseList(m);
    return list;
  }
}
