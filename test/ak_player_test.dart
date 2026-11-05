import 'package:flutter_test/flutter_test.dart';
import 'package:ak_player/ak_player.dart';
import 'package:ak_player/ak_player_platform_interface.dart';
import 'package:ak_player/ak_player_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAkPlayerPlatform
    with MockPlatformInterfaceMixin
    implements AkPlayerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AkPlayerPlatform initialPlatform = AkPlayerPlatform.instance;

  test('$MethodChannelAkPlayer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAkPlayer>());
  });

  test('getPlatformVersion', () async {
    AkPlayer akPlayerPlugin = AkPlayer();
    MockAkPlayerPlatform fakePlatform = MockAkPlayerPlatform();
    AkPlayerPlatform.instance = fakePlatform;

    expect(await akPlayerPlugin.getPlatformVersion(), '42');
  });
}
