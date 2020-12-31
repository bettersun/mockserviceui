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

/// 搜索画面State
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
    final fabs = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // 返回
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: 'b2',
            child: const Icon(Icons.refresh),
            onPressed: () async {
              // 初始化
              _bloc.add(MockServiceReloadEvent());
            },
          ),
        ),
      ],
    );

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<MockServiceBloc, MockServiceState>(
          builder: (context, state) {
        // 加载完成后，渲染
        if (state is MockServiceDoneState) {
          // 构建组件
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(ThemeConst.sideWidth),
              color: Theme.of(context).bannerTheme.backgroundColor,
              child: Column(
                children: [
                  // 模拟服务参数面板
                  HeaderPanel(view: state.view),
                  // Tab面板
                  OperatePanel(view: state.view),
                  // 详细面板
                  Expanded(
                    child: DetailPanel(view: state.view),
                  )
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
