import 'package:kiwi/kiwi.dart';

import 'module/app/service/service.dart';
import 'module/info_detail/service/service.dart';
import 'module/mock_service/service/service.dart';
import 'plugin/go/plugin.dart';

class Kiwi {
  // 注入依赖
  static void injectDependency() {
    final KiwiContainer container = KiwiContainer();

    // 程序
    container.registerFactory<AppService>((c) => AppServiceImpl());
    // 模拟服务
    container
        .registerFactory<MockServiceService>((c) => MockServiceServiceImpl());
    // 插件
    container
        .registerFactory<MockServicePlugin>((c) => MockServicePluginImpl());

    // 模拟服务信息详细
    container
        .registerFactory<InfoDetailService>((c) => InfoDetailServiceImpl());
  }
}
