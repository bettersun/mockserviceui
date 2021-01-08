import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockserviceui/common/const/const.dart';

import '../bloc/bloc.dart';
import '../vm/vm.dart';

/// 操作面板
class OperatePanel extends StatelessWidget {
  /// 模拟服务View
  final MockServiceView view;

  const OperatePanel({this.view});

  @override
  Widget build(BuildContext context) {
    final String toggleText = view.isRunning ? '关闭服务' : '运行服务';
    final Color toggleColor =
        view.isRunning ? Colors.green[300] : Colors.deepOrangeAccent;

    return Container(
      alignment: Alignment.center,
      color: Colors.blue[50],
      height: 30,
      padding: EdgeInsets.all(ThemeConst.sideWidth),
      child: Row(
        // 用于左右两端表示组件
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // 启动服务/关闭服务
              FlatButton(
                color: toggleColor,
                child: Text(
                  toggleText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<MockServiceBloc>(context)
                      .add(MockServiceToggleServiceEvent());
                },
              ),
            ],
          ),
          // 运行信息
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: ThemeConst.marginButton,
                    right: ThemeConst.marginButton),
                child: FlatButton(
                  color: Colors.blue[200],
                  child: Text('全部返回200'),
                  onPressed: () {
                    BlocProvider.of<MockServiceBloc>(context)
                        .add(MockServiceAllResponseOKEvent());
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: ThemeConst.marginButton,
                    right: ThemeConst.marginButton),
                child: Row(
                  children: [
                    Text('默认目标主机'),
                    Switch(
                      value: view.allUseDefaultTargetHost,
                      onChanged: (value) {
                        // 触发事件
                        BlocProvider.of<MockServiceBloc>(context)
                            .add(MockServiceAllUseDefaultTargetHostEvent(
                          allUseDefaultTargetHost: value,
                        ));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: ThemeConst.marginButton,
                    right: ThemeConst.marginButton),
                child: Row(
                  children: [
                    Text('模拟服务'),
                    Switch(
                      value: view.allUseMockService,
                      onChanged: (value) {
                        // 触发事件
                        BlocProvider.of<MockServiceBloc>(context)
                            .add(MockServiceAllUseMockServiceEvent(
                          allUseMockService: value,
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
