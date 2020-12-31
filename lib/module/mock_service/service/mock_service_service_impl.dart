import 'package:kiwi/kiwi.dart';
import 'package:mockserviceui/module/mock_service/bloc/mock_service_event.dart';
import 'package:mockserviceui/module/mock_service/const/const.dart';
import 'package:mockserviceui/plugin/go/plugin.dart';

import '../vm/vm.dart';
import 'mock_service_service.dart';

/// 模拟服务Service实现
class MockServiceServiceImpl extends MockServiceService {
  KiwiContainer container = KiwiContainer();

  /// 初始化
  @override
  Future<MockServiceView> init() async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    // 目标主机列表
    final List<String> targetHostList = await plugin.targetHostList();

    // 默认目标主机
    String defaultTargetHost = '';
    if (targetHostList.isNotEmpty) {
      defaultTargetHost = targetHostList[0];
    }

    // 模拟服务信息列表
    final List<MockServiceInfo> mockServiceInfoList =
        await plugin.mockServiceInfoList();

    // 模拟服务信息View列表
    final List<MockServiceInfoView> infoViewList = [];
    for (final MockServiceInfo info in mockServiceInfoList) {
      final MockServiceInfoView infoView =
          fromMockServiceInfo(info, defaultTargetHost);

      infoViewList.add(infoView);
    }

    final MockServiceView view = MockServiceView(
      defaultTargetHost: defaultTargetHost,
      targetHostList: targetHostList,
      infoList: infoViewList,
      isRunning: false,
    );

    return view;
  }

  /// 重新加载(运行时各种配置及输入文件)
  @override
  Future<MockServiceView> reload() async {
    final MockServicePlugin plugin = container<MockServicePlugin>();
    // 重新加载(运行时各种配置及输入文件)
    await plugin.reload();

    // 目标主机列表
    final List<String> targetHostList = await plugin.targetHostList();

    // 默认目标主机
    String defaultTargetHost = '';
    if (targetHostList.isNotEmpty) {
      defaultTargetHost = targetHostList[0];
    }

    // 模拟服务信息列表
    final List<MockServiceInfo> mockServiceInfoList =
        await plugin.mockServiceInfoList();

    // 模拟服务信息View列表
    final List<MockServiceInfoView> infoViewList = [];
    for (final MockServiceInfo info in mockServiceInfoList) {
      final MockServiceInfoView infoView =
          fromMockServiceInfo(info, defaultTargetHost);

      infoViewList.add(infoView);
    }

    // 服务运行中标志
    final bool isRunning = await plugin.isRunning();

    // 服务运行中标志为true时，重新运行下服务(主要用于新添加的URI)
    if (isRunning) {
      await plugin.runService();
    }

    final MockServiceView newView = MockServiceView(
      info: '已重新加载',
      defaultTargetHost: defaultTargetHost,
      targetHostList: targetHostList,
      infoList: infoViewList,
      isRunning: isRunning,
    );

    return newView;
  }

  /// 运行服务/关闭服务
  @override
  Future<MockServiceView> toggleService(MockServiceView view) async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    bool isRunning;
    if (view.isRunning) {
      // 关闭服务
      await plugin.closeService();
      isRunning = false;
    } else {
      // 运行服务
      await plugin.runService();
      isRunning = true;
    }
    final info = isRunning ? '服务运行中' : '服务已关闭';

    final MockServiceView newView = view.copyWith(
      info: info,
      isRunning: isRunning,
    );

    return newView;
  }

  /// 改变项目值
  @override
  MockServiceView changeItemValue(
      MockServiceView view, MockServiceChangeItemValueEvent e) {
    // 默认目标主机
    String defaultTargetHost = '';
    if (e.key == MockServiceItemKey.defaultTargetHost) {
      defaultTargetHost = (e.newVal as String) ?? '';
    }

    final List<MockServiceInfoView> infoList = [];
    for (int i = 0; i < view.infoList.length; i++) {
      // 使用默认目标主机时
      if (view.infoList[i].useDefaultTargetHost) {
        final MockServiceInfoView infoView = view.infoList[i].copyWith(
          currentTargetHost: defaultTargetHost,
        );

        infoList.add(infoView);
      } else {
        infoList.add(view.infoList[i]);
      }
    }

    final MockServiceView newView =
        view.copyWith(defaultTargetHost: defaultTargetHost, infoList: infoList);

    return newView;
  }

  /// 改变列表值
  @override
  Future<MockServiceView> changeListValue(
      MockServiceView view, MockServiceChangeListValueEvent e) async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    final List<MockServiceInfoView> infoList = [];
    for (int i = 0; i < view.infoList.length; i++) {
      if (i == e.index) {
        // 使用默认目标主机的值发生改变
        final bool isUseDefaultTargetHostChanged =
            e.key == MockServiceItemKey.infoListUseDefaultTargetHost;
        // 使用默认目标主机的值发生改变
        final bool istUseMockServiceChanged =
            e.key == MockServiceItemKey.infoListUseMockService;

        // 当前使用的目标主机
        String currentTargetHost = view.infoList[i].currentTargetHost;
        // 使用默认目标主机的值发生改变 并且 使用默认目标主机时，当前使用的目标主机 设置为 默认目标主机
        if (isUseDefaultTargetHostChanged && (e.newVal as bool)) {
          currentTargetHost = view.defaultTargetHost;
        }
        // 使用默认目标主机的值发生改变 并且 不使用默认目标主机时，当前使用的目标主机 设置为 当前的目标主机
        if (isUseDefaultTargetHostChanged && !(e.newVal as bool)) {
          currentTargetHost = view.infoList[i].targetHost;
        }

        final MockServiceInfoView infoView = view.infoList[i].copyWith(
          useDefaultTargetHost: isUseDefaultTargetHostChanged
              ? e.newVal as bool
              : view.infoList[i].useDefaultTargetHost,
          currentTargetHost: currentTargetHost,
          useMockService: istUseMockServiceChanged
              ? e.newVal as bool
              : view.infoList[i].useMockService,
        );

        // 通知Go端更新
        final MockServiceInfo info = MockServiceInfo(
          useDefaultTargetHost: infoView.useDefaultTargetHost,
          uri: infoView.uri,
          targetHost: infoView.targetHost,
          useMockService: infoView.useMockService,
          responseFile: infoView.responseFile,
        );
        await plugin.saveInfo(info);

        infoList.add(infoView);
      } else {
        infoList.add(view.infoList[i]);
      }
    }

    final MockServiceView newView = view.copyWith(infoList: infoList);

    return newView;
  }

  /// 模拟服务信息 转换为 模拟服务信息View
  MockServiceInfoView fromMockServiceInfo(
      MockServiceInfo model, String defaultTargetHost) {
    // 当前使用的目标主机
    String currentTargetHost = model.targetHost ?? '';

    // 使用默认目标主机 并且默认目标主机不为空
    if (model.useDefaultTargetHost && defaultTargetHost.isNotEmpty) {
      currentTargetHost = defaultTargetHost;
    }

    return MockServiceInfoView(
      useDefaultTargetHost: model.useDefaultTargetHost,
      targetHost: model.targetHost ?? '',
      currentTargetHost: currentTargetHost,
      uri: model.uri ?? '',
      useMockService: model.useMockService,
      responseFile: model.responseFile ?? '',
    );
  }
}
