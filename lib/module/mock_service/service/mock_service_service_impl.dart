import 'package:kiwi/kiwi.dart';
import 'package:mockserviceui/plugin/go/plugin.dart';

import '../..//biz/const/http_const.dart';
import '../bloc/mock_service_event.dart';
import '../const/const.dart';
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
    bool isAllUseDefaultTargetHost = true;
    bool isAllUseMockService = true;
    for (final MockServiceInfo info in mockServiceInfoList) {
      // 全部使用默认目标主机标志
      if (!info.useDefaultTargetHost) {
        isAllUseDefaultTargetHost = false;
      }

      /// 全部使用模拟服务标志
      if (!info.useMockService) {
        isAllUseMockService = false;
      }

      final MockServiceInfoView infoView =
          fromMockServiceInfo(info, defaultTargetHost);

      infoViewList.add(infoView);
    }

    final MockServiceView view = MockServiceView(
      defaultTargetHost: defaultTargetHost,
      targetHostList: targetHostList,
      infoList: infoViewList,
      isRunning: false,
      allUseDefaultTargetHost: isAllUseDefaultTargetHost,
      allUseMockService: isAllUseMockService,
    );

    return view;
  }

  /// 重新加载(配置及输入文件)
  @override
  Future<MockServiceView> reload() async {
    final MockServicePlugin plugin = container<MockServicePlugin>();
    // 重新加载(配置及输入文件)
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
    bool isAllUseDefaultTargetHost = true;
    bool isAllUseMockService = true;
    for (final MockServiceInfo info in mockServiceInfoList) {
      // 全部使用默认目标主机标志
      if (!info.useDefaultTargetHost) {
        isAllUseDefaultTargetHost = false;
      }

      /// 全部使用模拟服务标志
      if (!info.useMockService) {
        isAllUseMockService = false;
      }

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
      info: '模拟服务信息已重新加载',
      defaultTargetHost: defaultTargetHost,
      targetHostList: targetHostList,
      infoList: infoViewList,
      isRunning: isRunning,
      allUseDefaultTargetHost: isAllUseDefaultTargetHost,
      allUseMockService: isAllUseMockService,
    );

    return newView;
  }

  @override
  Future<MockServiceView> save(MockServiceView view) async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    final bool result = await plugin.saveInfo();
    if (!result) {
      print('保存失败');
    }

    return view.copyWith(info: '模拟服务信息已保存');
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
    bool isAllUseDefaultTargetHost = true;
    bool isAllUseMockService = true;
    for (final MockServiceInfoView v in view.infoList) {
      if (v.uri == e.infoView.uri && v.method == e.infoView.method) {
        // 使用默认目标主机的值发生改变
        final bool isUseDefaultTargetHostChanged =
            e.key == MockServiceItemKey.infoListUseDefaultTargetHost;

        // 当前使用的目标主机
        String currentTargetHost = v.currentTargetHost;
        // 使用默认目标主机的值发生改变 并且 使用默认目标主机时，当前使用的目标主机 设置为 默认目标主机
        if (isUseDefaultTargetHostChanged && (e.newVal as bool)) {
          currentTargetHost = view.defaultTargetHost;
        }
        // 使用默认目标主机的值发生改变 并且 不使用默认目标主机时，当前使用的目标主机 设置为 当前数据的 目标主机
        if (isUseDefaultTargetHostChanged && !(e.newVal as bool)) {
          currentTargetHost = v.targetHost;
        }

        // 使用默认目标主机的值发生改变
        final bool istUseMockServiceChanged =
            e.key == MockServiceItemKey.infoListUseMockService;

        // 响应状态码发生改变
        int statusCode = v.statusCode;
        if (e.key == MockServiceItemKey.infoListStatusCode) {
          statusCode = int.tryParse(e.newVal as String) ?? v.statusCode;
        }

        final MockServiceInfoView infoView = v.copyWith(
          useDefaultTargetHost: isUseDefaultTargetHostChanged
              ? e.newVal as bool
              : v.useDefaultTargetHost,
          currentTargetHost: currentTargetHost,
          useMockService:
              istUseMockServiceChanged ? e.newVal as bool : v.useMockService,
          statusCode: statusCode,
        );

        // 更新Go端内存
        final MockServiceInfo info = fromMockServiceInfoView(infoView);
        final bool result = await plugin.updateInfo(info);
        // TODO
        if (!result) {
          print('更新内存失败');
        }

        infoList.add(infoView);
      } else {
        infoList.add(v);
      }

      // 全部使用默认目标主机标志
      // 有一个为假则为假
      if (!v.useDefaultTargetHost) {
        isAllUseDefaultTargetHost = false;
      }

      /// 全部使用模拟服务标志
      // 有一个为假则为假
      if (!v.useMockService) {
        isAllUseMockService = false;
      }
    }

    final MockServiceView newView = view.copyWith(
      infoList: infoList,
      allUseDefaultTargetHost: isAllUseDefaultTargetHost,
      allUseMockService: isAllUseMockService,
    );

    return newView;
  }

  /// 更新模拟服务信息(反映详细)
  @override
  Future<MockServiceView> updateFromDetail(
      MockServiceView view, MockServiceUpdateInfoEvent e) async {
    final List<MockServiceInfoView> infoList = [];

    for (final MockServiceInfoView infoView in view.infoList) {
      if (infoView.uri == e.infoView.uri &&
          infoView.method == e.infoView.method) {
        // 当前使用的目标主机
        final String currentTargetHost = e.infoView.useDefaultTargetHost
            ? view.defaultTargetHost
            : e.infoView.targetHost;

        final MockServiceInfoView newInfoView = e.infoView.copyWith(
          currentTargetHost: currentTargetHost,
        );
        infoList.add(newInfoView);
      } else {
        infoList.add(infoView);
      }
    }

    return view.copyWith(infoList: infoList);
  }

  /// 全部响应返回OK
  @override
  Future<MockServiceView> allResponseOK(
      MockServiceView view, MockServiceAllResponseOKEvent e) async {
    return updateAll(view, MockServiceFlag.updateAllResponseOK, '');
  }

  /// 全部使用默认目标主机
  @override
  Future<MockServiceView> allUseDefaultTargetHost(
      MockServiceView view, MockServiceAllUseDefaultTargetHostEvent e) async {
    return updateAll(view, MockServiceFlag.updateAllUseDefaultTargetHost,
        e.allUseDefaultTargetHost);
  }

  /// 全部使用模拟服务
  @override
  Future<MockServiceView> allUseMockService(
      MockServiceView view, MockServiceAllUseMockServiceEvent e) async {
    return updateAll(
        view, MockServiceFlag.updateAllUseMockService, e.allUseMockService);
  }

  /// 搜索
  @override
  MockServiceView search(MockServiceView view, MockServiceSearchEvent e) {
    final List<MockServiceInfoView> infoList = [];

    for (final MockServiceInfoView infoView in view.infoList) {
      // 搜索关键字为空 或者 URI 包含搜索关键字时，可见。
      final bool isSearchResult = e.keyword.trim().isEmpty ||
          infoView.uri.contains(e.keyword.trim()) ||
          infoView.description.contains(e.keyword.trim());

      final MockServiceInfoView newInfoView =
          infoView.copyWith(visible: isSearchResult);
      infoList.add(newInfoView);
    }

    return view.copyWith(infoList: infoList);
  }

  /// 批量操作
  Future<MockServiceView> updateAll(
      MockServiceView view, int flag, dynamic val) async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    // 操作标志
    final bool isAllResponseOK = flag == MockServiceFlag.updateAllResponseOK;
    final bool isAllUseDefaultTargetHost =
        flag == MockServiceFlag.updateAllUseDefaultTargetHost;
    final bool isAllUseMockService =
        flag == MockServiceFlag.updateAllUseMockService;

    final List<MockServiceInfoView> infoList = [];
    final List<MockServiceInfo> infos = [];

    // 更新值
    for (int i = 0; i < view.infoList.length; i++) {
      final bool useDefaultTargetHost = isAllUseDefaultTargetHost
          ? val as bool
          : view.infoList[i].useDefaultTargetHost;

      final MockServiceInfoView infoView = view.infoList[i].copyWith(
        currentTargetHost: useDefaultTargetHost
            ? view.defaultTargetHost
            : view.infoList[i].targetHost,
        useDefaultTargetHost: useDefaultTargetHost,
        useMockService:
            isAllUseMockService ? val as bool : view.infoList[i].useMockService,
        statusCode: isAllResponseOK
            ? HTTPConst.responseOK
            : view.infoList[i].statusCode,
      );

      infoList.add(infoView);

      // 用来更新Go端内存
      infos.add(fromMockServiceInfoView(infoView));
    }

    // 更新Go端内存
    final bool result = await plugin.updateAllInfo(infos);
    if (!result) {
      print('更新失败');
    }

    final MockServiceView newView = view.copyWith(
      allUseDefaultTargetHost: isAllUseDefaultTargetHost
          ? val as bool
          : view.allUseDefaultTargetHost,
      allUseMockService:
          isAllUseMockService ? val as bool : view.allUseMockService,
      infoList: infoList,
    );

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

    // TODO 响应状态码
    final List<String> statusCodeList = ['', '200', '401', '403', '404', '500'];
    if (!statusCodeList.contains(model.statusCode.toString())) {
      statusCodeList.add(model.statusCode.toString());
    }

    return MockServiceInfoView(
      uri: model.uri ?? '',
      method: model.method ?? '',
      targetHost: model.targetHost ?? '',
      currentTargetHost: currentTargetHost,
      // defaultTargetHost: defaultTargetHost,
      useDefaultTargetHost: model.useDefaultTargetHost,
      statusCode: model.statusCode ?? 0,
      statusCodeList: statusCodeList,
      useMockService: model.useMockService,
      responseFile: model.responseFile ?? '',
      description: model.description,
      visible: true,
    );
  }

  /// 模拟服务信息View 转换为 模拟服务信息
  MockServiceInfo fromMockServiceInfoView(MockServiceInfoView view) {
    final MockServiceInfo info = MockServiceInfo(
      uri: view.uri,
      method: view.method,
      targetHost: view.targetHost,
      useDefaultTargetHost: view.useDefaultTargetHost,
      useMockService: view.useMockService,
      statusCode: view.statusCode,
      responseFile: view.responseFile,
      description: view.description,
    );

    return info;
  }
}
