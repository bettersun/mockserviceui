import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockserviceui/common/const/const.dart';

import '../bloc/bloc.dart';
import '../const/const.dart';
import '../vm/vm.dart';

/// 模拟服务信息详细响应Card
class ResponseCard extends StatelessWidget {
  /// 下标
  final int index;

  /// 响应文件
  final String responseFile;

  /// 模拟服务信息详细View
  final DetailResponseView responseView;

  const ResponseCard({this.index, this.responseFile, this.responseView});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ThemeConst.sideWidth),
      child: Container(
        height: 20,
        child: Row(
          children: [
            Container(
              color: Colors.blue[100],
              margin: ThemeConst.cellMargin,
              padding: ThemeConst.cellPadding,
              child: Text(index.toString()),
            ),
            Expanded(
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                child: Text(responseView.fileName),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ThemeConst.sideWidth, right: ThemeConst.sideWidth),
              child: Row(
                children: [
                  Text('设为响应'),
                  Radio(
                    groupValue: responseFile,
                    value: responseView.fileName,
                    onChanged: (value) {
                      BlocProvider.of<InfoDetailBloc>(context)
                          .add(InfoDetailChangeListValueEvent(
                        key: InfoDetailItemKey.responseListIsResponse,
                        index: index,
                        newVal: value,
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
