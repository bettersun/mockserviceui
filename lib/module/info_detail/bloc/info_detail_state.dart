import 'package:equatable/equatable.dart';

import '../vm/vm.dart';

/// 模拟服务信息详细State
abstract class InfoDetailState extends Equatable {
  @override
  List<Object> get props => [props];
}

/// 初始State
class InfoDetailInitState extends InfoDetailState {}

/// 完成State
class InfoDetailDoneState extends InfoDetailState {
  /// 模拟服务View
  final InfoDetailView view;

  InfoDetailDoneState({this.view});

  @override
  List<Object> get props => [view];

  @override
  String toString() => 'InfoDetailDoneState';
}
