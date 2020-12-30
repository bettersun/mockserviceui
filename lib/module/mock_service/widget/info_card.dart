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
        padding: EdgeInsets.all(ThemeConst.sideWidth),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.blue[100],
                        padding: EdgeInsets.only(
                            left: ThemeConst.sideWidth,
                            right: ThemeConst.sideWidth),
                        child: Text('#' + index.toString()),
                      ),
                      Container(
//                    color: Colors.green[100],
                        child: Text(infoView.currentTargetHost),
                      )
                    ],
                  ),
                ),
                Container(
//                  color: Colors.green[200],
                  height: 20,
                  child: Row(
                    children: [
                      Text('使用默认目标主机'),
                      Switch(
                        value: infoView.useDefaultTargetHost,
                        onChanged: (value) {
                          //
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
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.blue[100],
                        padding: EdgeInsets.only(
                            left: ThemeConst.sideWidth,
                            right: ThemeConst.sideWidth),
                        child: Text(infoView.uri),
                      ),
                    ],
                  ),
                ),
                Container(
//                  color: Colors.green[200],
                  height: 20,
                  child: Row(
                    children: [
                      Text('使用模拟服务'),
                      Switch(
                        value: infoView.useMockService,
                        onChanged: (value) {
                          //
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
            Row(
              children: [
                Expanded(
                  child: Container(
//                    color: Colors.green[300],
                    child: Text(infoView.responseFile),
                  ),
                ),
                Container(
//                  color: Colors.green[400],
                  child: InkWell(
                    child: Icon(Icons.arrow_right),
                    onTap: () {
                      //
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
