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
  // 目标主机
  TextEditingController _targetHostPathCtrlr;
  // URI
  TextEditingController _uriCtrlr;
  // 响应文件
  TextEditingController _responseFileCtrlr;

  @override
  void initState() {
    super.initState();

    _targetHostPathCtrlr = TextEditingController();
    _uriCtrlr = TextEditingController();
    _responseFileCtrlr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // 目标主机
    _targetHostPathCtrlr.text = widget.view.targetHost;
    // URI
    _uriCtrlr.text = widget.view.uri;
    // 响应文件
    _responseFileCtrlr.text = widget.view.responseFile;

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
                      child: Text('目标主机'),
                    ),
                    Expanded(
                      // padding: EdgeInsets.all(ThemeConst.sideWidth),s
                      child: TextFormField(
                        controller: _targetHostPathCtrlr,
                        onChanged: (value) {
                          if (value != widget.view.targetHost) {
                            BlocProvider.of<InfoDetailBloc>(context)
                                .add(InfoDetailChangeItemValueEvent(
                              key: InfoDetailItemKey.targetHost,
                              newVal: value,
                            ));
                          }
                        },
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
                      child: Text('URI'),
                    ),
                    Expanded(
                      // padding: EdgeInsets.all(ThemeConst.sideWidth),
                      child: TextFormField(
                        controller: _uriCtrlr,
                        onChanged: (value) {
                          if (value != widget.view.uri) {
                            BlocProvider.of<InfoDetailBloc>(context)
                                .add(InfoDetailChangeItemValueEvent(
                              key: InfoDetailItemKey.uri,
                              newVal: value,
                            ));
                          }
                        },
                      ),
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
