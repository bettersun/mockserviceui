import 'package:flutter/material.dart';

class WidgetUtil {
  /// 输入框前标签
  static Widget label(String labelText) {
    const double labelPadding = 8.0;
    const double labelWidth = 120.0;

    return Container(
      padding: EdgeInsets.only(left: labelPadding, right: labelPadding),
      // color: Theme.of(context).dividerColor,
      width: labelWidth,
      alignment: Alignment.center,
      child: Text(labelText),
    );
  }
}
