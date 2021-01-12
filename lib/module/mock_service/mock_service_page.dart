import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:mockserviceui/plugin/go/plugin.dart';

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

    final KiwiContainer container = KiwiContainer();
    final MockServicePlugin plugin = container<MockServicePlugin>();
    // 监听Go端发过来的消息
    plugin.channel.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == plugin.funcNameNotify) {
        final String notification = methodCall.arguments as String;

        // 触发事件
        _bloc.add(MockServiceNotifiedEvent(notification: notification));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<MockServiceBloc, MockServiceState>(
          builder: (context, state) {
        // 加载完成后，渲染
        if (state is MockServiceDoneState) {
          final Color colorNotificationIcon = state.view.visibleNotification
              ? Colors.deepOrangeAccent
              : Colors.teal;

          // 构建组件
          return Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                title: Text('模拟服务'),
                centerTitle: true,
                actions: [
                  // TODO 暂不显示通知
                  Container()
                  // 显示通知
                  // state.view.notification.isEmpty
                  //     ? Container()
                  //     : Container(
                  //         padding: EdgeInsets.only(right: 40),
                  //         child: IconButton(
                  //           icon: Icon(
                  //             state.view.visibleNotification
                  //                 ? Icons.close_outlined
                  //                 : Icons.info,
                  //             color: colorNotificationIcon,
                  //             size: 30,
                  //           ),
                  //           onPressed: () async {
                  //             // 触发事件
                  //             BlocProvider.of<MockServiceBloc>(context)
                  //                 .add(MockServiceShowNotificationEvent());
                  //           },
                  //         ),
                  //       ),
                ],
              ),
              preferredSize: Size.fromHeight(ThemeConst.heightAppBar),
            ),
            body: Container(
              padding: EdgeInsets.all(ThemeConst.sideWidth),
              color: Theme.of(context).bannerTheme.backgroundColor,
              child: state.view.visibleNotification
                  // 通知面板
                  ? NotificationPannel(view: state.view)
                  : Column(
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
            floatingActionButton:
                state.view.visibleNotification ? Container() : FAB(),
          );
        }

        return Container();
      }),
    );
  }
}
