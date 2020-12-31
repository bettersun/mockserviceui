import '../bloc/bloc.dart';

import '../vm/vm.dart';

/// 模拟服务Service接口
abstract class MockServiceService {
  /// 初始化
  Future<MockServiceView> init();

  /// 重新加载(运行时各种配置及输入文件)
  Future<MockServiceView> reload();

  /// 运行服务/关闭服务
  Future<MockServiceView> toggleService(MockServiceView view);

  /// 改变项目值
  MockServiceView changeItemValue(
      MockServiceView view, MockServiceChangeItemValueEvent e);

  /// 改变列表值
  Future<MockServiceView> changeListValue(
      MockServiceView view, MockServiceChangeListValueEvent e);
}
