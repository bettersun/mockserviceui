import '../bloc/bloc.dart';

import '../vm/vm.dart';

/// 模拟服务Service接口
abstract class MockServiceService {
  /// 初始化
  Future<MockServiceView> init();

  /// 运行服务
  Future<MockServiceView> run();

  // /// 重新加载运行时模拟服务信息
  // Future<MockServiceView> reload();

  /// 关闭服务
  Future<MockServiceView> close();

  /// 改变项目值
  MockServiceView changeItemValue(
      MockServiceView view, MockServiceChangeItemValueEvent e);

  /// 改变列表值
  MockServiceView changeListValue(
      MockServiceView view, MockServiceChangeListValueEvent e);
}
