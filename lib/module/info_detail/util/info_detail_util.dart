import '../../mock_service/vm/vm.dart';

import '../vm/vm.dart';

class InfoDetailUtil {
  static MockServiceInfoView toMockServiceInfoView(InfoDetailView view) {
    return MockServiceInfoView(
      useDefaultTargetHost: view.useDefaultTargetHost,
      currentTargetHost: view.currentTargetHost,
      targetHost: view.targetHost,
      uri: view.uri,
      useMockService: view.useMockService,
      responseFile: view.responseFile,
    );
  }
}
