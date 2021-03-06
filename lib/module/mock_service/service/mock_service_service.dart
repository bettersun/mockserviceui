import '../bloc/bloc.dart';

import '../vm/vm.dart';

/// 模拟服务Service接口
abstract class MockServiceService {
  /// 初始化
  Future<MockServiceView> init();

  /// 重新加载(配置及输入文件)
  Future<MockServiceView> reload(MockServiceView view);

  /// 保存(配置及输入文件)
  Future<MockServiceView> save(MockServiceView view);

  /// 运行服务/关闭服务
  Future<MockServiceView> toggleService(MockServiceView view);

  /// 改变项目值
  Future<MockServiceView> changeItemValue(
      MockServiceView view, MockServiceChangeItemValueEvent e);

  /// 改变列表值
  Future<MockServiceView> changeListValue(
      MockServiceView view, MockServiceChangeListValueEvent e);

  /// 更新模拟服务信息(反映详细)
  Future<MockServiceView> updateFromDetail(
      MockServiceView view, MockServiceUpdateInfoEvent e);

  /// 全部响应返回OK
  Future<MockServiceView> allResponseOK(
      MockServiceView view, MockServiceAllResponseOKEvent e);

  /// 全部使用默认目标主机
  Future<MockServiceView> allUseDefaultTargetHost(
      MockServiceView view, MockServiceAllUseDefaultTargetHostEvent e);

  /// 全部使用模拟服务
  Future<MockServiceView> allUseMockService(
      MockServiceView view, MockServiceAllUseMockServiceEvent e);

  /// 搜索
  MockServiceView search(MockServiceView view, MockServiceSearchEvent e);

  /// 接收Go端通知表示信息
  MockServiceView notify(MockServiceView view, MockServiceNotifiedEvent e);

  /// 接收Go端通知添加新的模拟服务信息
  MockServiceView addMockServiceInfo(
      MockServiceView view, MockServiceAddMockServiceInfoEvent e);

  /// 显示/隐藏通知
  MockServiceView showNotification(MockServiceView view);
}
