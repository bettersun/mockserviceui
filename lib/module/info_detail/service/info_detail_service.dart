import '../bloc/bloc.dart';

import '../vm/vm.dart';

/// 模拟服务信息详细Service接口
abstract class InfoDetailService {
  /// 初始化
  Future<InfoDetailView> init(InfoDetailInitEvent e);

  /// 改变项目值
  Future<InfoDetailView> changeItemValue(
      InfoDetailView view, InfoDetailChangeItemValueEvent e);

  /// 改变列表值
  Future<InfoDetailView> changeListValue(
      InfoDetailView view, InfoDetailChangeListValueEvent e);

  /// 重新加载响应文件列表
  Future<InfoDetailView> reloadResponse(InfoDetailView view);
}
