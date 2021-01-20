import 'dart:async';

import 'package:flutter/services.dart';

import 'model/mock_service_info.dart';

abstract class MockServicePlugin {
// go-flutter插件中的包名，两者必须一致
  final channel = MethodChannel('bettersun.go-flutter.plugin.mockservice');

  final funcNameHelo = 'hello';

  final funcNameRun = 'run';
  final funcNameClose = 'close';
  final funcNameLoad = 'load';
  final funcNameIsRunning = 'IsRunning';

  final funcNameUpdateInfo = 'updateInfo';
  final funcNameUpdateAllInfo = 'updateAllInfo';
  final funcNameSaveInfo = 'saveInfo';

  final funcNameHostlist = 'hostlist';
  final funcNameInfolist = 'infolist';
  final funcNameResponselist = 'responselist';

  final funcNameRenameResponseFile = 'renameResponseFile';

  // 接收Go端通知表示信息
  final funcNameNotify = 'notify';

  // 接收Go端消息的方法，添加新的模拟服务信息
  final funcNameNotifyAddMockServiceInfo = 'notifyAddMockServiceInfo';

  /// 获取目标主机列表
  Future<List<String>> targetHostList();

  /// 获取模拟服务信息列表
  Future<List<MockServiceInfo>> mockServiceInfoList();

  /// 运行服务
  Future<String> runService();

  /// 关闭服务
  Future<bool> closeService();

  /// 加载(配置及输入文件)
  Future<bool> load();

  /// 更新模拟服务信息
  Future<bool> updateInfo(MockServiceInfo info);

  /// 更新所有模拟服务信息
  Future<bool> updateAllInfo(List<MockServiceInfo> infoList);

  /// 保存模拟服务信息
  Future<bool> saveInfo();

  /// 获取响应文件列表
  Future<List<String>> responseFileList(String url, String method);

  /// 重命名响应文件
  Future<bool> renameResponseFile(String responseFile, String fileName);
}
