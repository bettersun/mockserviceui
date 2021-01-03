import 'package:equatable/equatable.dart';

/// 模拟服务信息详细响应View
class DetailResponseView extends Equatable {
  /// JSON标志
  final bool isJson;

  /// JSON合法标志
  final bool isJsonValid;

  /// 文件名
  final String fileName;

  const DetailResponseView({
    this.isJson = false,
    this.isJsonValid = false,
    this.fileName = '',
  });

  @override
  List<Object> get props => [
        isJson,
        isJsonValid,
        fileName,
      ];

  DetailResponseView copyWith({
    bool isResponse,
    bool isJson,
    bool isJsonValid,
    String fileName,
  }) {
    return DetailResponseView(
      isJson: isJson ?? this.isJson,
      isJsonValid: isJsonValid ?? this.isJsonValid,
      fileName: fileName ?? this.fileName,
    );
  }
}
