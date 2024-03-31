
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miracle/Features/Review/Models/review.dart';
import 'package:miracle/Features/days/Models/days.dart';

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
