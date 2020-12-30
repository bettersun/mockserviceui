/// 模拟服务Event
abstract class AppEvent {}

/// 初始化Event
class AppInitEvent extends AppEvent {
  @override
  String toString() => 'AppInitEvent';
}
