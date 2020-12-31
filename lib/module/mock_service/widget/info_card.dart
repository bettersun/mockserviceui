import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockserviceui/common/const/const.dart';
import 'package:mockserviceui/module/mock_service/const/const.dart';

import '../bloc/bloc.dart';
import '../vm/vm.dart';

/// 模拟服务信息Card
class InfoCard extends StatelessWidget {
  /// 下标
  final int index;

  /// 模拟服务信息View
  final MockServiceInfoView infoView;

  const InfoCard({this.index, this.infoView});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ThemeConst.sideWidth),
      child: Container(
        // padding: EdgeInsets.all(ThemeConst.sideWidth),
        child: Row(
          children: [
            Container(
              color: Colors.blue[100],
              margin: ThemeConst.cellMargin,
              padding: ThemeConst.cellPadding,
              // padding: EdgeInsets.all(ThemeConst.sideWidth),
              child: Text(index.toString()),
            ),
            Expanded(
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                // 使用模拟服务时，目标主机背景色为灰色
                color:
                    infoView.useMockService ? Colors.grey : Colors.transparent,
                child: Text(infoView.currentTargetHost),
              ),
            ),
            Expanded(
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                child: Text(infoView.uri),
              ),
            ),
            Expanded(
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                // 不使用模拟服务时，响应JSON背景色为灰色
                color:
                    infoView.useMockService ? Colors.transparent : Colors.grey,
                child: Text(infoView.responseFile),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  child: Row(
                    children: [
                      Text('使用默认目标主机'),
                      Switch(
                        value: infoView.useDefaultTargetHost,
                        onChanged: (value) {
                          // 使用默认目标主机
                          BlocProvider.of<MockServiceBloc>(context)
                              .add(MockServiceChangeListValueEvent(
                            index: index,
                            key:
                                MockServiceItemKey.infoListUseDefaultTargetHost,
                            newVal: value,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  child: Row(
                    children: [
                      Text('使用模拟服务'),
                      Switch(
                        value: infoView.useMockService,
                        onChanged: (value) {
                          // 使用模拟服务
                          BlocProvider.of<MockServiceBloc>(context)
                              .add(MockServiceChangeListValueEvent(
                            index: index,
                            key: MockServiceItemKey.infoListUseMockService,
                            newVal: value,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ThemeConst.sideWidth, right: ThemeConst.sideWidth),
              child: InkWell(
                child: Icon(Icons.arrow_right),
                onTap: () {
                  //
                  print('详细设置');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
