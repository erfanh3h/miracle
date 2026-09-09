
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:miracle/Models/review.dart';
import 'package:miracle/Models/days.dart';

class HiveComponent {
  Future<void> init() async {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Directory.current.path;
    // var path = await getApplicationDocumentsDirectory();
    // Hive.init(path.path);
    await Hive.initFlutter();
    Hive.registerAdapter(DaysModelAdapter());
    Hive.registerAdapter(ReviewModelAdapter());
  }
}
