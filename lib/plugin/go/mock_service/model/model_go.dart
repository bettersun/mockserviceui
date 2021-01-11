import 'mock_service_info.dart';

///
class ModelGo {
  //
  static List<String> fromGoHostList(Map<dynamic, dynamic> json) {
    final List<String> list = [];

    // 对应Go端的Map键
    if (json['HostList'] != null) {
      json['HostList'].forEach((v) {
        list.add(v as String);
      });
    }

    return list;
  }

  //
  static List<MockServiceInfo> fromGoInfoList(Map<dynamic, dynamic> json) {
    final List<MockServiceInfo> list = [];

    // 对应Go端的Map键
    if (json['InfoList'] != null) {
      json['InfoList'].forEach((v) {
        list.add(MockServiceInfo.fromJson(v as Map<dynamic, dynamic>));
      });
    }

    return list;
  }

  //
  static List<String> fromGoResponseList(Map<dynamic, dynamic> json) {
    final List<String> list = [];

    // 对应Go端的Map键
    if (json['ResponseList'] != null) {
      json['ResponseList'].forEach((v) {
        list.add(v as String);
      });
    }

    return list;
  }
}
