import 'dart:async';

import 'model/mock_service_info.dart';

abstract class MockServicePlugin {
  /// 获取目标主机列表
  Future<List<String>> targetHostList();

  /// 获取模拟服务信息列表
  Future<List<MockServiceInfo>> mockServiceInfoList();

  /// 运行服务
  Future<String> runService();

  /// 关闭服务
  Future<bool> closeService();

  /// 重新加载(配置及输入文件)
  Future<bool> reload();

  /// 运行中状态
  Future<bool> isRunning();

  /// 更新模拟服务信息
  Future<bool> updateInfo(MockServiceInfo info);

  /// 更新所有模拟服务信息
  Future<bool> updateAllInfo(List<MockServiceInfo> infoList);

  /// 保存模拟服务信息
  Future<bool> saveInfo();

  /// 获取响应文件列表
  Future<List<String>> responseFileList(String uri, String method);
}
