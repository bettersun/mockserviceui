import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          //
          FlatButton(
            color: Colors.blue[300],
            child: Text('重载响应文件列表'),
            onPressed: () {
              BlocProvider.of<InfoDetailBloc>(context)
                  .add(InfoDetailReloadResponseEvent());
            },
          ),
        ],
      ),
    );
  }
}
