import '../bloc/bloc.dart';
import '../const/const.dart';
import '../service/service.dart';
import '../vm/vm.dart';

class InfoDetailServiceImpl extends InfoDetailService {
  @override
  Future<InfoDetailView> init(InfoDetailInitEvent e) async {
    if (e.infoView == null) {
      return InfoDetailView();
    }

    // TODO 获取响应文件列表
    final List<DetailResponseView> responseList = [];
    final DetailResponseView responseView1 = DetailResponseView(
      fileName: 'test1.json',
      isJson: true,
      isJsonValid: false,
    );
    final DetailResponseView responseView2 = DetailResponseView(
      fileName: 'test2.json',
      isJson: true,
      isJsonValid: false,
    );
    final DetailResponseView responseView3 = DetailResponseView(
      fileName: 'test3.json',
      isJson: true,
      isJsonValid: true,
    );

    responseList.add(responseView1);
    responseList.add(responseView2);
    responseList.add(responseView3);
    responseList.add(responseView1);
    responseList.add(responseView2);
    responseList.add(responseView3);
    responseList.add(responseView1);
    responseList.add(responseView2);
    responseList.add(responseView3);
    responseList.add(responseView1);
    responseList.add(responseView2);
    responseList.add(responseView3);

    final InfoDetailView view = InfoDetailView(
      useDefaultTargetHost: e.infoView.useDefaultTargetHost,
      useMockService: e.infoView.useMockService,
      uri: e.infoView.uri,
      targetHost: e.infoView.targetHost,
      currentTargetHost: e.infoView.currentTargetHost,
      responseFile: e.infoView.responseFile,
      responseList: responseList,
    );

    return view;
  }

  @override
  InfoDetailView changeItemValue(
      InfoDetailView view, InfoDetailChangeItemValueEvent e) {
    InfoDetailView newView;

    // 目标主机
    String targetHost = '';
    if (e.key == InfoDetailItemKey.targetHost) {
      targetHost = (e.newVal as String) ?? '';

      newView = view.copyWith(targetHost: targetHost);
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

      newView = view.copyWith(useDefaultTargetHost: useDefaultTargetHost);
    }

    // 使用模拟服务
    bool useMockService = false;
    if (e.key == InfoDetailItemKey.useMockService) {
      useMockService = (e.newVal as bool) ?? false;

      newView = view.copyWith(useMockService: useMockService);
    }

    return newView;
  }

  @override
  Future<InfoDetailView> changeListValue(
      InfoDetailView view, InfoDetailChangeListValueEvent e) async {
    final InfoDetailView newView = view.copyWith(
      responseFile: e.newVal as String,
    );

    return newView;
  }

  @override
  Future<InfoDetailView> save(
      InfoDetailView view, InfoDetailSaveEvent e) async {
    // TODO

    return view;
  }
}
