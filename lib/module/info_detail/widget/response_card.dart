import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/const/const.dart';

import '../bloc/bloc.dart';
import '../const/const.dart';
import '../vm/vm.dart';

/// 模拟服务信息详细响应Card
class ResponseCard extends StatefulWidget {
  /// 下标
  final int index;

  /// 响应文件
  final String responseFile;

  /// 模拟服务信息详细View
  final DetailResponseView responseView;

  const ResponseCard({this.index, this.responseFile, this.responseView});

  @override
  _ResponseCardState createState() => _ResponseCardState();
}

class _ResponseCardState extends State<ResponseCard> {
  // 重命名文件的控制器
  TextEditingController fileNameCtrlr = TextEditingController();
  InfoDetailBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<InfoDetailBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    fileNameCtrlr.text = widget.responseView.fileName;
    return Card(
      margin: widget.index == 0
          ? EdgeInsets.all(ThemeConst.sideWidth)
          : EdgeInsets.only(
              left: ThemeConst.sideWidth,
              right: ThemeConst.sideWidth,
              bottom: ThemeConst.sideWidth),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          color: widget.index % 2 == 0 ? Colors.transparent : Colors.blue[50],
        ),
        height: 30,
        child: Row(
          children: [
            Container(
              color: Colors.blue[100],
              margin: ThemeConst.cellMargin,
              padding: ThemeConst.cellPadding,
              child: Text(widget.index.toString()),
            ),
            // 文件路径
            Expanded(
              child: Container(
                margin: ThemeConst.cellMargin,
                padding: ThemeConst.cellPadding,
                child: Text(widget.responseView.responseFile),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ThemeConst.sideWidth, right: ThemeConst.sideWidth),
              child: Row(
                children: [
                  Text('设为响应'),
                  Radio(
                    groupValue: widget.responseFile,
                    value: widget.responseView.fileName,
                    onChanged: (value) {
                      BlocProvider.of<InfoDetailBloc>(context)
                          .add(InfoDetailChangeListValueEvent(
                        key: InfoDetailItemKey.responseListIsResponse,
                        index: widget.index,
                        newVal: value,
                      ));
                    },
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: ThemeConst.sideWidth, right: ThemeConst.sideWidth),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showRenameDialog();

                    // BlocProvider.of<InfoDetailBloc>(context)
                    //     .add(InfoDetailChangeListValueEvent(
                    //   key: InfoDetailItemKey.responseListIsResponse,
                    //   index: widget.index,
                    // ));
                  },
                )

                // Row(
                //   children: [
                //     Text('设为响应'),
                //     Radio(
                //       groupValue: responseFile,
                //       value: responseView.fileName,
                //       onChanged: (value) {
                //         BlocProvider.of<InfoDetailBloc>(context)
                //             .add(InfoDetailChangeListValueEvent(
                //           key: InfoDetailItemKey.responseListIsResponse,
                //           widget.index: widget.index,
                //           newVal: value,
                //         ));
                //       },
                //     ),
                //   ],
                // ),
                ),
          ],
        ),
      ),
    );
  }

  void showRenameDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('重命名文件'),
            content: Container(
              height: 100,
              width: 500,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[100],
                      child: Text(widget.responseView.fileName),
                    ),
                    TextFormField(
                      controller: fileNameCtrlr,
                    ),
                  ]),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text('取消'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  // print('取消');
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text('确定'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  // print('确定');
                  bloc.add(InfoDetailRenameEvent(
                    responseFile: widget.responseView.responseFile,
                    newFileName: fileNameCtrlr.value.text,
                  ));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
