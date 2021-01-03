import 'package:flutter/material.dart';
import 'package:mockserviceui/common/const/const.dart';

import '../bloc/bloc.dart';
import '../vm/vm.dart';

/// 中间面板
class MiddlePanel extends StatelessWidget {
  /// 模拟服务View
  final InfoDetailView view;

  const MiddlePanel({this.view});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue[50],
      height: 30,
      padding: EdgeInsets.all(ThemeConst.sideWidth),
      child: Row(
        children: [
          // 运行信息
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 4.0),
                child: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
