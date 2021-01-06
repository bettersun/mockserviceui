import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockserviceui/common/const/const.dart';

import '../bloc/bloc.dart';
import '../const/const.dart';
import '../vm/vm.dart';

/// Header面板
class HeaderPanel extends StatefulWidget {
  /// 模拟服务信息详细View
  final InfoDetailView view;

  const HeaderPanel({this.view});

  @override
  _HeaderPanelState createState() {
    return _HeaderPanelState();
  }
}

/// 画面State
class _HeaderPanelState extends State<HeaderPanel> {
  // URI
  final TextEditingController _uriCtrlr = TextEditingController();
  // 目标主机
  final TextEditingController _targetHostPathCtrlr = TextEditingController();
  // 响应文件
  final TextEditingController _responseFileCtrlr = TextEditingController();

  // 目标主机
  TextFormField inputTargetHost;

  @override
  void initState() {
    super.initState();
    // URI
    _uriCtrlr.text = widget.view.uri;
    // 目标主机
    _targetHostPathCtrlr.text = widget.view.targetHost;
  }

  @override
  Widget build(BuildContext context) {
    // 响应文件
    _responseFileCtrlr.text = widget.view.responseFile;

    // 使用默认目标主机时
    if (widget.view.useDefaultTargetHost) {
      inputTargetHost = TextFormField(
        controller: TextEditingController(text: widget.view.currentTargetHost),
        // 使用默认目标主机时，不可编辑
        enabled: !widget.view.useDefaultTargetHost,
      );
    } else {
      // 不使用默认目标主机时
      inputTargetHost = TextFormField(
        controller: _targetHostPathCtrlr,
        // 使用默认目标主机时，不可编辑
        enabled: !widget.view.useDefaultTargetHost,
        onChanged: (value) {
          BlocProvider.of<InfoDetailBloc>(context)
              .add(InfoDetailChangeItemValueEvent(
            key: InfoDetailItemKey.targetHost,
            newVal: value,
          ));
        },
      );
    }

    return Container(
      color: Colors.blue[200],
      padding: EdgeInsets.all(ThemeConst.sideWidth * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text('URI'),
                    ),
                    Expanded(
                      // padding: EdgeInsets.all(ThemeConst.sideWidth),
                      child: TextFormField(
                        controller: _uriCtrlr,
                        enabled: false,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text('目标主机'),
                    ),
                    Expanded(
                      child: inputTargetHost,
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
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text('响应文件'),
                    ),
                    Expanded(
                      // padding: EdgeInsets.all(ThemeConst.sideWidth),
                      child: TextField(
                        controller: _responseFileCtrlr,
                        enabled: false,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 4.0),
                      child: Text('请求方法'),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(widget.view.method),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                child: Row(
                  children: [
                    Text('使用默认目标主机'),
                    Switch(
                      value: widget.view.useDefaultTargetHost,
                      onChanged: (value) {
                        if (value != widget.view.useDefaultTargetHost) {
                          BlocProvider.of<InfoDetailBloc>(context)
                              .add(InfoDetailChangeItemValueEvent(
                            key: InfoDetailItemKey.useDefaultTargetHost,
                            newVal: value,
                          ));
                        }
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
                      value: widget.view.useMockService,
                      onChanged: (value) {
                        if (value != widget.view.useMockService) {
                          BlocProvider.of<InfoDetailBloc>(context)
                              .add(InfoDetailChangeItemValueEvent(
                            key: InfoDetailItemKey.useMockService,
                            newVal: value,
                          ));
                        }
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
