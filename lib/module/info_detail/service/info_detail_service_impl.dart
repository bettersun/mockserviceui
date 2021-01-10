import 'package:kiwi/kiwi.dart';
import 'package:mockserviceui/plugin/go/plugin.dart';

import '../../biz/util/mock_service_util.dart';
import '../bloc/bloc.dart';
import '../const/const.dart';
import '../service/service.dart';
import '../vm/vm.dart';

class InfoDetailServiceImpl extends InfoDetailService {
  final KiwiContainer container = KiwiContainer();
  final MockServiceUtil util = MockServiceUtil();

  @override
  Future<InfoDetailView> init(InfoDetailInitEvent e) async {
    if (e.infoView == null) {
      return InfoDetailView();
    }

    // 获取响应文件列表
    final MockServicePlugin plugin = container<MockServicePlugin>();
    final List<String> responseFileList =
        await plugin.responseFileList(e.infoView.uri, e.infoView.method);

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
      uri: e.infoView.uri,
      method: e.infoView.method,
      targetHost: e.infoView.targetHost,
      currentTargetHost: currentTargetHost,
      // defaultTargetHost: e.infoView.defaultTargetHost,
      useDefaultTargetHost: e.infoView.useDefaultTargetHost,
      useMockService: e.infoView.useMockService,
      statusCode: e.infoView.statusCode,
      statusCodeList: e.infoView.statusCodeList,
      responseFile: e.infoView.responseFile,
      responseList: responseList,
      description: e.infoView.description,
    );

    return view;
  }

  @override
  Future<InfoDetailView> changeItemValue(
      InfoDetailView view, InfoDetailChangeItemValueEvent e) async {
    InfoDetailView newView = view;

    // URI
    String uri = '';
    if (e.key == InfoDetailItemKey.uri) {
      uri = (e.newVal as String) ?? '';
      newView = view.copyWith(uri: uri);
    }

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

    // 响应状态码
    int statusCode = view.statusCode;
    if (e.key == InfoDetailItemKey.statusCode) {
      statusCode = int.tryParse(e.newVal as String) ?? 0;
      newView = view.copyWith(statusCode: statusCode);
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

    // 说明
    if (e.key == InfoDetailItemKey.description) {
      newView = view.copyWith(description: (e.newVal as String) ?? '');
    }

    // 更新Go端内存
    final bool result = await updateInfoDetail(newView);
    if (!result) {
      print('更新失败');
    }
    return newView;
  }

  @override
  Future<InfoDetailView> changeListValue(
      InfoDetailView view, InfoDetailChangeListValueEvent e) async {
    final InfoDetailView newView = view.copyWith(
      responseFile: e.newVal as String,
    );

    // 更新Go端内存
    final bool result = await updateInfoDetail(newView);
    if (!result) {
      print('更新失败');
    }

    return newView;
  }

  @override
  Future<InfoDetailView> reloadResponse(InfoDetailView view) async {
    // 获取响应文件列表
    final MockServicePlugin plugin = container<MockServicePlugin>();
    final List<String> responseFileList =
        await plugin.responseFileList(view.uri, view.method);

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

  /// 通知Go端更新内存
  Future<bool> updateInfoDetail(InfoDetailView view) async {
    // 通知Go端更新
    final MockServicePlugin plugin = container<MockServicePlugin>();
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

    final bool result = await plugin.updateInfo(info);
    return result;
  }
}
