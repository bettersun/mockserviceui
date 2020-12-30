import 'mock_service_info.dart';

///
class ModelGo {
  //
  List<String> fromGoHostList(Map<dynamic, dynamic> json) {
    final List<String> hostList = [];

    // 对应Go端的Map键
    if (json['HostList'] != null) {
      json['HostList'].forEach((v) {
        hostList.add(v as String);
      });
    }

    return hostList;
  }

  //
  List<MockServiceInfo> fromGoInfoList(Map<dynamic, dynamic> json) {
    final List<MockServiceInfo> infoList = [];

    // 对应Go端的Map键
    if (json['InfoList'] != null) {
      json['InfoList'].forEach((v) {
        infoList.add(MockServiceInfo.fromJson(v as Map<dynamic, dynamic>));
      });
    }

    return infoList;
  }
}
