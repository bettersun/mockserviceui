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
  // 请求方法
  final TextEditingController _methodCtrlr = TextEditingController();
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
    // 请求方法
    _methodCtrlr.text = widget.view.method;
    // 目标主机
    _targetHostPathCtrlr.text = widget.view.targetHost;
  }

  @override
  Widget build(BuildContext context) {
    // 响应文件
    _responseFileCtrlr.text = widget.view.responseFile;

    const String lblTxtTargetHost = '目标主机';

    // 使用默认目标主机时
    if (widget.view.useDefaultTargetHost) {
      inputTargetHost = TextFormField(
        decoration: InputDecoration(
          labelText: lblTxtTargetHost,
        ),
        controller: TextEditingController(text: widget.view.currentTargetHost),
        // 使用默认目标主机时，不可编辑
        enabled: !widget.view.useDefaultTargetHost,
      );
    } else {
      // 不使用默认目标主机时
      inputTargetHost = TextFormField(
        decoration: InputDecoration(
          labelText: lblTxtTargetHost,
        ),
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
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(
                      left: ThemeConst.paddingItem,
                      right: ThemeConst.paddingItem),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'URI',
                    ),
                    controller: _uriCtrlr,
                    enabled: false,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(
                      left: ThemeConst.paddingItem,
                      right: ThemeConst.paddingItem),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '请求方法',
                    ),
                    controller: _methodCtrlr,
                    enabled: false,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(
                      left: ThemeConst.paddingItem,
                      right: ThemeConst.paddingItem),
                  child: inputTargetHost,
                ),
              ),
              Container(
                height: 20,
                child: Row(
                  children: [
                    Text('默认目标主机'),
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
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(
                      left: ThemeConst.paddingItem,
                      right: ThemeConst.paddingItem),
                  // color: widget.view.useMockService
                  //     ? Colors.transparent
                  //     : Colors.grey,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '响应文件',
                    ),
                    controller: _responseFileCtrlr,
                    enabled: false,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(
                      left: ThemeConst.paddingItem,
                      right: ThemeConst.paddingItem),
                  // color: widget.view.useMockService
                  //     ? Colors.transparent
                  //     : Colors.grey,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '响应状态码',
                    ),
                    value: widget.view.statusCode.toString(),
                    disabledHint: Text(widget.view.statusCode.toString()),
                    onChanged: !widget.view.useMockService
                        ? null // 不使用模拟服务时，禁用下拉框
                        : (value) {
                            if (value != widget.view.statusCode.toString()) {
                              // 触发事件
                              BlocProvider.of<InfoDetailBloc>(context).add(
                                InfoDetailChangeItemValueEvent(
                                  key: InfoDetailItemKey.statusCode,
                                  newVal: value,
                                ),
                              );
                            }
                          },
                    // isExpanded: true,
                    items: widget.view.statusCodeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                height: 20,
                child: Row(
                  children: [
                    Text('模拟服务'),
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
