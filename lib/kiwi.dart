import 'package:kiwi/kiwi.dart';

import 'module/app/service/app_service.dart';
import 'module/app/service/app_service_impl.dart';
import 'module/mock_service/service/service.dart';
import 'plugin/go/plugin.dart';

class Kiwi {
  // 注入依赖
  static void injectDependency() {
    final KiwiContainer container = KiwiContainer();

    // 程序
    container.registerFactory<AppService>((c) => AppServiceImpl());
    //
    container
        .registerFactory<MockServiceService>((c) => MockServiceServiceImpl());
    // 插件
    container
        .registerFactory<MockServicePlugin>((c) => MockServicePluginImpl());
  }
}
