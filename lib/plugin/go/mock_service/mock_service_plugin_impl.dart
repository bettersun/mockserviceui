import 'dart:async';

import 'mock_service_plugin.dart';
import 'model/model.dart';

class MockServicePluginImpl extends MockServicePlugin {
  /// 获取目标主机列表
  @override
  Future<List<String>> targetHostList() async {
    final Map m = await channel.invokeMethod(funcNameHostlist);

    final List<String> list = ModelGo.fromGoHostList(m);
    return list;
  }

  /// 获取模拟服务信息列表
  @override
  Future<List<MockServiceInfo>> mockServiceInfoList() async {
    final Map m = await channel.invokeMethod(funcNameInfolist);
    final List<MockServiceInfo> list = ModelGo.fromGoInfoList(m);
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
      print('关闭服务失败');
    }
    return result;
  }

  /// 加载(配置及输入文件)
  @override
  Future<bool> load() async {
    final bool result = await channel.invokeMethod(funcNameLoad);
    if (!result) {
      print('加载失败');
    }
    return result;
  }

  /// 更新模拟服务信息
  @override
  Future<bool> updateInfo(MockServiceInfo info) async {
    final Map m = info.toJson();

    final bool result = await channel.invokeMethod(funcNameUpdateInfo, m);
    if (!result) {
      print('更新失败');
    }
    return result;
  }

  /// 更新所有模拟服务信息
  @override
  Future<bool> updateAllInfo(List<MockServiceInfo> infoList) async {
    final List<Map> list = [];
    for (final MockServiceInfo info in infoList) {
      list.add(info.toJson());
    }

    final bool result = await channel.invokeMethod(funcNameUpdateAllInfo, list);
    if (!result) {
      print('更新失败');
    }
    return result;
  }

  /// 保存模拟服务信息
  @override
  Future<bool> saveInfo() async {
    final bool result = await channel.invokeMethod(funcNameSaveInfo);
    if (!result) {
      print('保存失败');
    }
    return result;
  }

  /// 获取响应文件列表
  @override
  Future<List<String>> responseFileList(String url, String method) async {
    final Map mParams = {};
    mParams['url'] = url;
    mParams['method'] = method;

    final Map m = await channel.invokeMethod(funcNameResponselist, mParams);
    final List<String> list = ModelGo.fromGoResponseList(m);

    return list;
  }

  /// 重命名响应文件
  @override
  Future<bool> renameResponseFile(String responseFile, String fileName) async {
    final Map mParams = {};
    mParams['responseFile'] = responseFile;
    mParams['fileName'] = fileName;

    final bool result =
        await channel.invokeMethod(funcNameRenameResponseFile, mParams);

    return result;
  }

  /// 设置默认目标主机
  @override
  Future<bool> setDefaultTargetHost(String targetHost) async {
    final Map mParams = {};
    mParams['targetHost'] = targetHost;

    final bool result =
        await channel.invokeMethod(funcNameSetDefaultTargetHost, mParams);

    return result;
  }
}
