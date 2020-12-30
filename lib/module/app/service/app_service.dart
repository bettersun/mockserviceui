import '../bloc/bloc.dart';
import '../vm/vm.dart';

/// 程序Service接口
abstract class AppService {
  /// 初始化
  Future<AppDoneState> init();
}
