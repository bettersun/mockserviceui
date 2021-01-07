import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockserviceui/common/const/const.dart';

import '../../info_detail/info_detail_page.dart';
import '../../mock_service/const/const.dart';
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
      margin: index == 0
          ? EdgeInsets.all(ThemeConst.sideWidth)
          : EdgeInsets.only(
              left: ThemeConst.sideWidth,
              right: ThemeConst.sideWidth,
              bottom: ThemeConst.sideWidth),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          color: index % 2 == 0 ? Colors.transparent : Colors.blue[50],
        ),
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
              flex: 3,
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                child: Text(infoView.uri),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                child: Text(infoView.method),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                // 使用模拟服务时，目标主机背景色为灰色
                color:
                    infoView.useMockService ? Colors.grey : Colors.transparent,
                child: Text(infoView.currentTargetHost),
              ),
            ),
            // 响应状态码
            Expanded(
              flex: 1,
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                // 不使用模拟服务时，背景色为灰色
                color:
                    infoView.useMockService ? Colors.transparent : Colors.grey,
                child: DropdownButton<String>(
                  value: infoView.statusCode.toString(),
                  disabledHint: Text(infoView.statusCode.toString()),
                  onChanged: !infoView.useMockService
                      ? null // 不使用模拟服务时，禁用下拉框
                      : (value) {
                          if (value != infoView.statusCode.toString()) {
                            // 触发事件
                            BlocProvider.of<MockServiceBloc>(context).add(
                              MockServiceChangeListValueEvent(
                                index: index,
                                key: MockServiceItemKey.infoListStatusCode,
                                newVal: value,
                              ),
                            );
                          }
                        },
                  isExpanded: true,
                  items: infoView.statusCodeList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            // 响应文件
            Expanded(
              flex: 3,
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                // 不使用模拟服务时，背景色为灰色
                color:
                    infoView.useMockService ? Colors.transparent : Colors.grey,
                child: Text(infoView.responseFile),
              ),
            ),
            // 使用默认目标主机
            Row(
              children: [
                Container(
                  height: 20,
                  child: Row(
                    children: [
                      Text('默认目标主机'),
                      Switch(
                        value: infoView.useDefaultTargetHost,
                        onChanged: (value) {
                          // 触发事件
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
                // 使用模拟服务
                Container(
                  height: 20,
                  child: Row(
                    children: [
                      Text('模拟服务'),
                      Switch(
                        value: infoView.useMockService,
                        onChanged: (value) {
                          // 触发事件
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
                onTap: () async {
                  //
                  print('详细');
                  // 详细
                  await Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<dynamic>(builder: (_) {
                      return InfoDetailPage(infoView: infoView);
                    }),
                  ).then((value) {
                    // 更新模拟服务信息
                    BlocProvider.of<MockServiceBloc>(context).add(
                        MockServiceUpdateInfoEvent(
                            infoView: value as MockServiceInfoView));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
