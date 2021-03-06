import 'package:kiwi/kiwi.dart';
import '../../../common/util/util.dart';
import '../../../plugin/go/plugin.dart';

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
    final List<DetailResponseView> responseList =
        await loadResponseFile(e.infoView.url, e.infoView.method);

    // 使用中的目标主机
    final String currentTargetHost = e.infoView.useDefaultTargetHost
        ? InfoDetailStrings.defaultTargetHost
        : e.infoView.targetHost;

    final InfoDetailView view = InfoDetailView(
      url: e.infoView.url,
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

    // URL
    String url = '';
    if (e.key == InfoDetailItemKey.url) {
      url = (e.newVal as String) ?? '';
      newView = view.copyWith(url: url);
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
    final List<DetailResponseView> responseList =
        await loadResponseFile(view.url, view.method);

    final InfoDetailView newView = view.copyWith(
      responseList: responseList,
    );

    return newView;
  }

  @override
  Future<InfoDetailView> renameResponseFile(
      InfoDetailView view, InfoDetailRenameEvent e) async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    // 重命名响应文件
    final bool result =
        await plugin.renameResponseFile(e.responseFile, e.newFileName);

    // 重命名成功，重新加载响应文件列表
    if (result) {
      // 获取响应文件列表
      final List<DetailResponseView> responseList =
          await loadResponseFile(view.url, view.method);

      final InfoDetailView newView = view.copyWith(
        responseList: responseList,
        info: '文件已重命名',
      );

      return newView;
    }

    return view.copyWith(info: '文件重命名失败');
  }

  /// 通知Go端更新内存
  Future<bool> updateInfoDetail(InfoDetailView view) async {
    // 通知Go端更新
    final MockServicePlugin plugin = container<MockServicePlugin>();
    final MockServiceInfo info = MockServiceInfo(
      url: view.url,
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

  /// 加载响应文件列表
  Future<List<DetailResponseView>> loadResponseFile(
      String url, String method) async {
    final MockServicePlugin plugin = container<MockServicePlugin>();

    // 加载响应文件列表
    final List<String> responseFileList =
        await plugin.responseFileList(url, method);

    // 响应文件View列表
    final List<DetailResponseView> responseList = [];
    for (final String responseFile in responseFileList) {
      final DetailResponseView responseView = DetailResponseView(
        responseFile: responseFile,
        fileName: Util.getFileName(responseFile),
        isJson: true,
        isJsonValid: true,
      );
      responseList.add(responseView);
    }

    return responseList;
  }
}
