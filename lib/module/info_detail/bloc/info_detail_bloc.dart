import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../service/service.dart';
import '../vm/vm.dart';
import 'bloc.dart';

/// 模拟服务信息详细Bloc
class InfoDetailBloc extends Bloc<InfoDetailEvent, InfoDetailState> {
  KiwiContainer container = KiwiContainer();

  InfoDetailBloc() : super(InfoDetailInitState());

  @override
  Stream<InfoDetailState> mapEventToState(
    InfoDetailEvent event,
  ) async* {
    final InfoDetailService service = container<InfoDetailService>();

    // 初始化
    if (event is InfoDetailInitEvent) {
      final InfoDetailView view = await service.init(event);
      yield InfoDetailDoneState(view: view);
    }

    // 改变项目值
    if (event is InfoDetailChangeItemValueEvent) {
      final InfoDetailDoneState nowState = state as InfoDetailDoneState;
      final InfoDetailView view = service.changeItemValue(nowState.view, event);
      yield InfoDetailDoneState(view: view);
    }

    // 改变列表值
    if (event is InfoDetailChangeListValueEvent) {
      final InfoDetailDoneState nowState = state as InfoDetailDoneState;
      final InfoDetailView view =
          await service.changeListValue(nowState.view, event);
      yield InfoDetailDoneState(view: view);
    }

    // 保存
    if (event is InfoDetailSaveEvent) {
      final InfoDetailDoneState nowState = state as InfoDetailDoneState;
      final InfoDetailView view = await service.save(nowState.view, event);
      yield InfoDetailDoneState(view: view);
    }
  }
}
