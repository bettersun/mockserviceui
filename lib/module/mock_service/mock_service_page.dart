import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/const/const.dart';
import 'bloc/bloc.dart';
import 'widget/widget.dart';

/// 模拟服务画面
class MockServicePage extends StatefulWidget {
  @override
  _MockServicePageState createState() {
    return _MockServicePageState();
  }
}

/// 画面State
class _MockServicePageState extends State<MockServicePage> {
  MockServiceBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = MockServiceBloc();
    // 初始化
    _bloc.add(MockServiceInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    // FAB
    final fabs = Container(
      padding: EdgeInsets.only(bottom: ThemeConst.paddingFABBottom),
      child: FAB(),
    );

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<MockServiceBloc, MockServiceState>(
          builder: (context, state) {
        // 加载完成后，渲染
        if (state is MockServiceDoneState) {
          // 构建组件
          return Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                title: Text('模拟服务'),
                centerTitle: true,
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
                  // Tab面板
                  OperatePanel(view: state.view),
                  // 详细面板
                  Expanded(
                    child: DetailPanel(view: state.view),
                  ),
                  // 状态栏面板
                  StatusPannel(view: state.view),
                ],
              ),
            ),
            floatingActionButton: fabs,
          );
        }

        return Container();
      }),
    );
  }
}
