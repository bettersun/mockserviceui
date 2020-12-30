import 'package:equatable/equatable.dart';

/// 程序View
class AppView extends Equatable {
  /// 标题
  final String title;

  /// 消息
  final String info;

  const AppView({
    this.title = '',
    this.info = '',
  });

  @override
  List<Object> get props => [title, info];

  AppView copyWith({String title, String info}) {
    return AppView(
      title: title ?? this.title,
      info: info ?? this.info,
    );
  }
}
