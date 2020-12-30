import 'package:kiwi/kiwi.dart';
import 'package:mockserviceui/module/mock_service/bloc/mock_service_event.dart';
import 'package:mockserviceui/module/mock_service/const/const.dart';
import 'package:mockserviceui/plugin/go/plugin.dart';

import '../vm/vm.dart';
import 'mock_service_service.dart';

/// 模拟服务Service实现
class MockServiceServiceImpl extends MockServiceService {
  KiwiContainer container = KiwiContainer();

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

    // // 添加一个空值
    // targetHostList.insert(0, '');

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
    );

    return view;
  }

  @override
  Future<MockServiceView> run() async {
    final MockServicePlugin plugin = container<MockServicePlugin>();
    await plugin.runMockService();

    return MockServiceView();
  }

  // @override
  // Future<MockServiceView> reload() async {
  //   await MockServicePlugin.reload();

  //   return MockServiceView();
  // }

  @override
  Future<MockServiceView> close() async {
    final MockServicePlugin plugin = container<MockServicePlugin>();
    await plugin.closeMockService();

    return MockServiceView();
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
  MockServiceView changeListValue(
      MockServiceView view, MockServiceChangeListValueEvent e) {
    final List<MockServiceInfoView> infoList = [];
    for (int i = 0; i < view.infoList.length; i++) {
      if (i == e.index) {
        // 使用默认目标主机的值发生改变
        final bool istUseDefaultTargetHostChanged =
            e.key == MockServiceItemKey.infoListUseDefaultTargetHost;
        // 使用默认目标主机的值发生改变
        final bool istUseMockServiceChanged =
            e.key == MockServiceItemKey.infoListUseMockService;

        // 当前使用的目标主机
        String currentTargetHost = view.infoList[i].currentTargetHost;
        // 使用默认目标主机的值发生改变 并且 使用默认目标主机时，当前使用的目标主机 设置为 默认目标主机
        if (istUseDefaultTargetHostChanged && (e.newVal as bool)) {
          currentTargetHost = view.defaultTargetHost;
        }
        // 使用默认目标主机的值发生改变 并且 不使用默认目标主机时，当前使用的目标主机 设置为 当前的目标主机
        if (istUseDefaultTargetHostChanged && !(e.newVal as bool)) {
          currentTargetHost = view.infoList[i].targetHost;
        }

        final MockServiceInfoView infoView = view.infoList[i].copyWith(
          useDefaultTargetHost: istUseDefaultTargetHostChanged
              ? e.newVal as bool
              : view.infoList[i].useDefaultTargetHost,
          currentTargetHost: currentTargetHost,
          useMockService: istUseMockServiceChanged
              ? e.newVal as bool
              : view.infoList[i].useMockService,
        );

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
