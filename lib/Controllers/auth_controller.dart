import 'package:file_picker/file_picker.dart';
import 'package:miracle/Components/dialog_component.dart';
import 'package:miracle/Core/days_repository.dart';
import 'package:miracle/Core/global_repository.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/auth_repository.dart';
import 'package:appwrite/models.dart' as models;
import 'package:miracle/Resources/app_consts.dart';

class AuthController extends BaseController {
  final AuthRepository _repo = AuthRepository();
  final GlobalRepository _globalRepo = GlobalRepository();

  AuthController();

  final Rx<models.User?> userData = Rx(null);

  RxInt currentDay = RxInt(1);
  Rx<String?> avatar = Rx(null);

  Future<void> fetchUserData() async {
    isPageLoading.value = true;
    final result = await _repo.getActiveUser();
    if (result.resultData != null) {
      avatar.value = result.resultData!.prefs.data['avatarFileId'];
      if (!result.resultData!.prefs.data.keys.contains("currentDay")) {
        await _repo.updateCurrentDay(day: 1);
        await fetchUserData();
        return;
      } else {
        currentDay.value = result.resultData!.prefs.data['currentDay'];
        userData.value = result.resultData;
      }
    }
    isPageLoading.value = false;
  }

  Future<void> login() async {
    isPageLoading.value = true;
    var response = await _repo.loginWithGoogle();
    if (response.resultData != null) {
      fetchUserData();
      Get.back();
      await fetchUserData();
      DialogCompanent.showToast(
        label: 'با موفقیت وارد شدید.',
        backgroundColor: AppColors.darkGreen,
      );
      syncDaysData();
    } else {}
    isPageLoading.value = false;
  }

  Future<void> changeAvatar() async {
    final file = await FilePicker.pickFile(type: FileType.image);
    if (file == null) {
      return;
    }
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.${file.extension}';
    final result = await _repo.updateAvatar(
      filePath: file.path!,
      filename: fileName,
    );
    if (result.resultData != null) {
      avatar.value = result.resultData!;
      DialogCompanent.showToast(label: "عکس بروز شد");
    }
  }

  Future<void> logout() async {
    Get.closeAllDialogs();
    userData.value = null;
    currentDay.value = 1;
    avatar.value = null;
    await _repo.logout();
    _globalRepo.logoutRemoveData();
  }

  void syncDaysData() {
    final DaysRepository dayRepo = DaysRepository();
    for (var day in daysList) {
      dayRepo.getDayDataServer(dayNumber: day).then((response) {
        if (response.resultData != null) {
          print(response.resultData.toString());
          final result = response.resultData!;
          for (var dataRaw in result) {
            dayRepo.writeDayDataStorage(data: dataRaw);
          }
        }
      });
    }
  }

  bool isLoggedIn() => userData.value != null;

  @override
  void onInit() async {
    await fetchUserData();
    super.onInit();
  }
}
