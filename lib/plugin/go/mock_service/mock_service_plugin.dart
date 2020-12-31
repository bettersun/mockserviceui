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
  Future<String> closeService();

  /// 重新加载(运行时各种配置及输入文件)
  Future<String> reload();

  /// 运行中
  Future<bool> isRunning();

  /// 保存
  Future<String> saveInfo(MockServiceInfo info);
}
