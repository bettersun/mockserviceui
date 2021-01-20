import '../../mock_service/vm/vm.dart';

/// 模拟服务信息详细Event
abstract class InfoDetailEvent {}

/// 初始化Event
class InfoDetailInitEvent extends InfoDetailEvent {
  // 模拟服务信息View
  final MockServiceInfoView infoView;

  InfoDetailInitEvent({this.infoView});

  @override
  String toString() => 'InfoDetailInitEvent';
}

/// 改变项目值Event
class InfoDetailChangeItemValueEvent extends InfoDetailEvent {
  // Key
  final String key;
  // 最新值
  final dynamic newVal;

  InfoDetailChangeItemValueEvent({this.key, this.newVal});

  @override
  String toString() => 'InfoDetailChangeItemValueEvent';
}

/// 改变列表值Event
class InfoDetailChangeListValueEvent extends InfoDetailEvent {
  // 下标
  final int index;
  // Key
  final String key;
  // 最新值
  final dynamic newVal;

  InfoDetailChangeListValueEvent({this.index, this.key, this.newVal});

  @override
  String toString() => 'InfoDetailChangeListValueEvent';
}

/// 重新加载响应文件列表Event
class InfoDetailReloadResponseEvent extends InfoDetailEvent {
  InfoDetailReloadResponseEvent();

  @override
  String toString() => 'InfoDetailReloadResponseEvent';
}

/// 重命名文件Event
class InfoDetailRenameEvent extends InfoDetailEvent {
  // 响应文件
  final String responseFile;

  // 新文件名
  final String newFileName;

  InfoDetailRenameEvent({this.responseFile, this.newFileName});

  @override
  String toString() => 'InfoDetailRenameEvent';
}
