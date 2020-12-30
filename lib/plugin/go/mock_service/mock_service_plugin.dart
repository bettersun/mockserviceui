import 'dart:async';

import 'model/mock_service_info.dart';

abstract class MockServicePlugin {
  /// 获取目标主机列表
  Future<List<String>> targetHostList();

  /// 获取模拟服务信息列表
  Future<List<MockServiceInfo>> mockServiceInfoList();

  /// 运行模拟服务
  Future<String> runMockService();

  /// 关闭模拟服务
  Future<String> closeMockService();
}
