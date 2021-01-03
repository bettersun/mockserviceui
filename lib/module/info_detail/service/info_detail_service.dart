import '../bloc/bloc.dart';

import '../vm/vm.dart';

/// 模拟服务信息详细Service接口
abstract class InfoDetailService {
  /// 初始化
  Future<InfoDetailView> init(InfoDetailInitEvent e);

  /// 改变项目值
  InfoDetailView changeItemValue(
      InfoDetailView view, InfoDetailChangeItemValueEvent e);

  /// 改变列表值
  Future<InfoDetailView> changeListValue(
      InfoDetailView view, InfoDetailChangeListValueEvent e);

  /// 保存
  Future<InfoDetailView> save(InfoDetailView view, InfoDetailSaveEvent e);
}
