import 'package:kiwi/kiwi.dart';
import 'package:mockserviceui/plugin/go/plugin.dart';

import '../bloc/bloc.dart';
import '../const/const.dart';
import '../service/service.dart';
import '../vm/vm.dart';

class InfoDetailServiceImpl extends InfoDetailService {
  KiwiContainer container = KiwiContainer();

  @override
  Future<InfoDetailView> init(InfoDetailInitEvent e) async {
    if (e.infoView == null) {
      return InfoDetailView();
    }

    // 获取响应文件列表
    final MockServicePlugin plugin = container<MockServicePlugin>();
    final List<String> responseFileList =
        await plugin.responseFileList(e.infoView.uri);

    // 响应文件View列表
    final List<DetailResponseView> responseList = [];
    for (final String responseFile in responseFileList) {
      final DetailResponseView responseView = DetailResponseView(
        fileName: responseFile,
        isJson: true,
        isJsonValid: true,
      );
      responseList.add(responseView);
    }

    // 使用中的目标主机
    final String currentTargetHost = e.infoView.useDefaultTargetHost
        ? InfoDetailStrings.defaultTargetHost
        : e.infoView.targetHost;

    final InfoDetailView view = InfoDetailView(
      // defaultTargetHost: e.infoView.defaultTargetHost,
      useDefaultTargetHost: e.infoView.useDefaultTargetHost,
      useMockService: e.infoView.useMockService,
      uri: e.infoView.uri,
      targetHost: e.infoView.targetHost,
      currentTargetHost: currentTargetHost,
      responseFile: e.infoView.responseFile,
      responseList: responseList,
    );

    return view;
  }

  @override
  Future<InfoDetailView> changeItemValue(
      InfoDetailView view, InfoDetailChangeItemValueEvent e) async {
    InfoDetailView newView = view;

    // 目标主机
    String targetHost = '';
    if (e.key == InfoDetailItemKey.targetHost) {
      targetHost = (e.newVal as String) ?? '';

      // 当前使用的目标主机
      final String currentTargetHost = view.useDefaultTargetHost
          ? InfoDetailStrings.defaultTargetHost
          : targetHost;

      newView = view.copyWith(
        targetHost: targetHost,
        currentTargetHost: currentTargetHost,
      );
    }

    // URI
    String uri = '';
    if (e.key == InfoDetailItemKey.uri) {
      uri = (e.newVal as String) ?? '';

      newView = view.copyWith(uri: uri);
    }

    // 使用默认目标主机
    bool useDefaultTargetHost = false;
    if (e.key == InfoDetailItemKey.useDefaultTargetHost) {
      useDefaultTargetHost = (e.newVal as bool) ?? false;

      // 当前使用的目标主机
      final String currentTargetHost = useDefaultTargetHost
          ? InfoDetailStrings.defaultTargetHost
          : view.targetHost;

      newView = view.copyWith(
        useDefaultTargetHost: useDefaultTargetHost,
        currentTargetHost: currentTargetHost,
      );
    }

    // 使用模拟服务
    bool useMockService = false;
    if (e.key == InfoDetailItemKey.useMockService) {
      useMockService = (e.newVal as bool) ?? false;

      newView = view.copyWith(useMockService: useMockService);
    }

    // 保存到文件
    final bool saved = await saveInfoDetail(newView);
    if (!saved) {
      newView = newView.copyWith(info: '保存失败');
    } else {
      newView = newView.copyWith(info: '');
    }
    return newView;
  }

  @override
  Future<InfoDetailView> changeListValue(
      InfoDetailView view, InfoDetailChangeListValueEvent e) async {
    final InfoDetailView newView = view.copyWith(
      responseFile: e.newVal as String,
    );

    // 保存到文件
    await saveInfoDetail(newView);

    return newView;
  }

  @override
  Future<InfoDetailView> reloadResponse(InfoDetailView view) async {
    // 获取响应文件列表
    final MockServicePlugin plugin = container<MockServicePlugin>();
    final List<String> responseFileList =
        await plugin.responseFileList(view.uri);

    // 响应文件View列表
    final List<DetailResponseView> responseList = [];
    for (final String responseFile in responseFileList) {
      final DetailResponseView responseView = DetailResponseView(
        fileName: responseFile,
        isJson: true,
        isJsonValid: true,
      );
      responseList.add(responseView);
    }

    final InfoDetailView newView = view.copyWith(
      responseList: responseList,
    );

    return newView;
  }

  /// 保存到文件
  Future<bool> saveInfoDetail(InfoDetailView view) async {
    // 通知Go端更新
    final MockServicePlugin plugin = container<MockServicePlugin>();
    final MockServiceInfo info = MockServiceInfo(
      useDefaultTargetHost: view.useDefaultTargetHost,
      uri: view.uri,
      targetHost: view.targetHost,
      useMockService: view.useMockService,
      responseFile: view.responseFile,
    );

    final bool result = await plugin.saveInfo(info);
    return result;
  }
}
