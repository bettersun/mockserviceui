import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/const/const.dart';
import '../mock_service/vm/vm.dart';
import 'bloc/bloc.dart';
import 'widget/widget.dart';

/// 模拟服务信息详细画面
class InfoDetailPage extends StatefulWidget {
  /// 模拟服务信息View
  final MockServiceInfoView infoView;

  const InfoDetailPage({this.infoView});

  @override
  _InfoDetailPageState createState() {
    return _InfoDetailPageState();
  }
}

/// 画面State
class _InfoDetailPageState extends State<InfoDetailPage> {
  InfoDetailBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = InfoDetailBloc();

    // 初始化
    _bloc.add(InfoDetailInitEvent(infoView: widget.infoView));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<InfoDetailBloc, InfoDetailState>(
          builder: (context, state) {
        // 加载完成后，渲染
        if (state is InfoDetailDoneState) {
          // 构建组件
          return Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                title: Text('模拟服务信息详细'),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    // 模拟服务信息详细View转模拟服务信息View
                    final MockServiceInfoView infoView = MockServiceInfoView(
                      useDefaultTargetHost: state.view.useDefaultTargetHost,
                      useMockService: state.view.useMockService,
                      currentTargetHost: state.view.currentTargetHost,
                      targetHost: state.view.targetHost,
                      uri: state.view.uri,
                      method: state.view.method,
                      statusCode: state.view.statusCode,
                      statusCodeList: state.view.statusCodeList,
                      responseFile: state.view.responseFile,
                    );

                    // Pop
                    Navigator.maybePop(context, infoView);
                  },
                ),
              ),
              preferredSize: Size.fromHeight(ThemeConst.heightAppBar),
            ),
            body: Container(
              padding: EdgeInsets.all(ThemeConst.sideWidth),
              color: Theme.of(context).bannerTheme.backgroundColor,
              child: Column(
                children: [
                  // Header面板
                  HeaderPanel(view: state.view),
                  // 中间面板
                  MiddlePanel(view: state.view),
                  // 详细面板
                  Expanded(
                    child: DetailPanel(view: state.view),
                  ),
                  // 状态栏面板
                  StatusPannel(view: state.view),
                ],
              ),
            ),
          );
        }

        return Container();
      }),
    );
  }
}
