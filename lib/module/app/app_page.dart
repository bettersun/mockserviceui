import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() {
    return _AppPageState();
  }
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
    context.bloc<AppBloc>().add(AppInitEvent());

    // // 监听Go发过来的消息
    // HelloPlugin.channel.setMethodCallHandler((MethodCall methodCall) async {
    //   if (methodCall.method == 'interval') {
    //     context.bloc<AppBloc>().add(AppEvent.refresh);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (_, state) {
      // 加载完成后，渲染
      if (state is AppDoneState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.view.title,
              textAlign: TextAlign.left,
            ),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.computer),
              onPressed: () {},
            ),
          ),
          body: Container(child: Text('a go-flutter application')),
        );
      }

      return Container();
    });
  }
}
