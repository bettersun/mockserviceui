import '../bloc/bloc.dart';
import '../vm/vm.dart';

import 'app_service.dart';

/// 程序Service实现
class AppServiceImpl extends AppService {
  @override
  Future<AppDoneState> init() async {
    const AppView view = AppView(title: 'A go-flutter application');

    return AppDoneState(view: view);
  }
}
