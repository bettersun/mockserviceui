import 'package:flutter/material.dart';

import '../vm/vm.dart';
import 'info_card.dart';

/// 详细面板
class DetailPanel extends StatelessWidget {
  /// 模拟服务View
  final MockServiceView view;

  const DetailPanel({this.view});

  @override
  Widget build(BuildContext context) {
    Widget result = Container();

    // 详细信息
    result = SingleChildScrollView(
      child: Column(
        children: buildInfoList(),
      ),
    );

    return Container(
      color: Colors.blue[100],
      width: double.infinity,
      child: result,
    );
  }

  /// 构建模拟服务信息Card列表
  List<Widget> buildInfoList() {
    final List<InfoCard> infoCardList = [];
    for (int i = 0; i < view.infoList.length; i++) {
      //
      infoCardList.add(InfoCard(
        index: i,
        infoView: view.infoList[i],
      ));
    }

    return infoCardList;
  }
}
