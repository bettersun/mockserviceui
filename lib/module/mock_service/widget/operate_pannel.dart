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
                color: Colors.blue[300],
                child: Text(toggleText),
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
                padding: EdgeInsets.only(right: 4.0),
                child: Text(view.info),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
