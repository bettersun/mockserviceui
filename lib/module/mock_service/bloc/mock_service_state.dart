import 'package:equatable/equatable.dart';

import '../vm/vm.dart';

/// 模拟服务State
abstract class MockServiceState extends Equatable {
  @override
  List<Object> get props => [props];
}

/// 初始State
class MockServiceInitState extends MockServiceState {}

/// 完成State
class MockServiceDoneState extends MockServiceState {
  /// 模拟服务View
  final MockServiceView view;

  MockServiceDoneState({this.view});

  @override
  List<Object> get props => [view];

  @override
  String toString() => 'MockServiceDoneState';
}
