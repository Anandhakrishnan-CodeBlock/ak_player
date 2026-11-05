
import 'ak_player_platform_interface.dart';

class AkPlayer {
  Future<String?> getPlatformVersion() {
    return AkPlayerPlatform.instance.getPlatformVersion();
  }
}
