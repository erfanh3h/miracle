import 'package:miracle/Components/dialog_component.dart';
import 'package:miracle/Core/global_repository.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/auth_repository.dart';
import 'package:appwrite/models.dart' as models;

class AuthController extends BaseController {
  final AuthRepository _repo;
  final GlobalRepository _globalRepo;

  AuthController(this._repo, this._globalRepo);

  final Rx<models.User?> userData = Rx(null);

  int? currentDay;
  String? avatar;

  Future<void> fetchUserData() async {
    isPageLoading.value = true;
    final result = await _repo.getActiveUser();
    if (result.resultData != null) {
      avatar = result.resultData!.prefs.data['avatarFileId'];
      if (!result.resultData!.prefs.data.keys.contains("currentDay")) {
        await _repo.updateCurrentDay(day: 1);
        await fetchUserData();
        return;
      } else {
        currentDay = result.resultData!.prefs.data['currentDay'];
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
      DialogCompanent.showToast(
        label: 'با موفقیت وارد شدید.',
        backgroundColor: AppColors.darkGreen,
      );
    } else {}
    isPageLoading.value = false;
  }

  Future<void> logout() async {
    Get.back();
    await _repo.logout();
    _globalRepo.logoutRemoveData();
  }

  @override
  void onInit() async {
    await fetchUserData();
    super.onInit();
  }
}
