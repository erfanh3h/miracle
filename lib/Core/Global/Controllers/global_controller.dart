// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

class GlobalController extends GetxController {
  // var _token = ''.obs;
  // String get token => _token.value;
  // setToken(String value) {
  //   _token.value = value;
  // }

  // var _image = ''.obs;
  // String get image => _image.value;
  // setImage(String value) {
  //   _image.value = value;
  // }

  // var _headerImage = ''.obs;
  // String get headerImage => _headerImage.value;
  // setHeaderImage(String value) {
  //   _headerImage.value = value;
  // }

  // var _letShowLive = false.obs;
  // bool get letShowLive => _letShowLive.value;
  // setletShowLive(bool value) {
  //   _letShowLive.value = value;
  // }

  // var _liveLink = ''.obs;
  // String get liveLink => _liveLink.value;
  // setLiveLink(String value) {
  //   _liveLink.value = value;
  // }

  // var _userName = ''.obs;
  // String get userName => _userName.value;
  // setUserName(String value) {
  //   _userName.value = value;
  // }

  var selectedPage = 0.obs;
  changePage(int page) => selectedPage.value = page;
  PageController pgCtrl = PageController();
  // static String _token = '';
  // static String get token {
  //   return GlobalController._token;
  // }

  // static set token(String token) {
  //   GlobalController._token = token;
  // }

  // static String _userId = '';
  // static String get userId {
  //   return _userId;
  // }

  // static set userId(String userId) {
  //   GlobalController._userId = userId;
  // }

  // static String _userName = '';
  // static String get userName {
  //   return _userName;
  // }

  // static set userName(String userName) {
  //   GlobalController._userName = userName;
  // }

  // static String _userPhone = '';
  // static String get userPhone {
  //   return _userPhone;
  // }

  // static set userPhone(String userPhone) {
  //   GlobalController._userPhone = userPhone;
  // }

  // getCardLength(BuildContext context) async {
  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     Urls.getCartCount,
  //   );
  //   result.fold(
  //     (error) async {},
  //     (result) async {
  //       cardLength = result['number'];
  //       notifyListeners();
  //     },
  //   );
  // }
  // static final AudioPlayer _audioPlayer = AudioPlayer();
  // static AudioPlayer get audioPlayer {
  //   return _audioPlayer;
  // }

  Rx<UserModel?> _user = Rx(null);
  UserModel? get user => _user.value;
  set user(UserModel? userData) {
    _user.value = userData;
  }

  Future<bool> fetchUserData(BuildContext context) async {
    final storageController = Get.find<UserStoreController>();
    _user.value = await storageController.getUserData();
    if (_user.value != null && _user.value!.token != null) {
      // if user haven any username he most go profile page
      if ((_user.value!.username ?? '') == '') {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
    // try {
    //   print(_user.value!.imageId);
    // } catch (_) {}
    // print(prefs.getUserData());

    // if (!prefs.hasData('userData')) {
    //   return false;
    // }
    // final userData =
    //     json.decode(prefs.read('userData')!) as Map<String, dynamic>;
    // setToken(userData['token']);
    // try {
    //   setImage(userData['image']);
    // } catch (_) {
    //   final prefs = GetStorage();
    //   prefs.remove('userData');
    //   setToken('');
    //   // Fluttertoast.showToast(msg: 'Please do login again!');
    //   return false;
    // }

    // // GlobalController.userId = userData['userId'];
    // try {
    //   setUserName(userData['username']);
    // } catch (_) {}
    // // GlobalController.userPhone = userData['userPhone'];
    // // notifyListeners();
    // // await getCardLength(context);
    // return true;
  }
}

// class GlobalController extends ChangeNotifier {
//   bool isLoading = true;
//   bool livePlaying = false;
//   late BetterPlayerController controller;
//   // late FlickManager flickManager;
//   Future getLive() async {
//     isLoading = true;
//     notifyListeners();
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       Urls.homeLive,
//       liveStream: true,
//       // resolutions: urls,
//     );
//     controller = BetterPlayerController(
//       BetterPlayerConfiguration(
//         controlsConfiguration: const BetterPlayerControlsConfiguration(
//           enableProgressText: true,
//           liveTextColor: Colors.white,
//         ),
//         autoDetectFullscreenDeviceOrientation: true,
//         autoPlay: true,
//         errorBuilder: (ctx, _) => const Center(
//           child: Text('Error play live!'),
//         ),
//         allowedScreenSleep: false,
//         showPlaceholderUntilPlay: true,
//         // placeholder: Image.network(widget.imageLink!),
//         looping: true,
//         // fullScreenByDefault: true,
//       ),
//       betterPlayerDataSource: betterPlayerDataSource,
//     );
//     isLoading = false;
//     notifyListeners();
//     // controller = VideoPlayerController.network(Urls.homeLive)
//     //   ..initialize().then((value) async {
//     //     flickManager = FlickManager(
//     //       videoPlayerController: controller,
//     //       autoInitialize: false,
//     //       autoPlay: false,
//     //     );
//     //     await controller.play();
//     //     livePlaying = true;
//     //     isLoading = false;
//     //     notifyListeners();
//     //   });
//   }

//   changeLiveStatus(bool isPause) async {
//     livePlaying = !isPause;
//     if (isPause) {
//       try {
//         controller.dispose();
//       } catch (e) {}
//     } else {
//       try {
//         await getLive();
//       } catch (e) {}
//     }
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     try {
//       controller.dispose();
//     } catch (e) {}
//     super.dispose();
//   }

//   static String _token = '';
//   static String get token {
//     return GlobalController._token;
//   }

//   static set token(String token) {
//     GlobalController._token = token;
//   }

//   static String _userId = '';
//   static String get userId {
//     return _userId;
//   }

//   static set userId(String userId) {
//     GlobalController._userId = userId;
//   }

//   static String _userName = '';
//   static String get userName {
//     return _userName;
//   }

//   static set userName(String userName) {
//     GlobalController._userName = userName;
//   }

//   static String _userPhone = '';
//   static String get userPhone {
//     return _userPhone;
//   }

//   static set userPhone(String userPhone) {
//     GlobalController._userPhone = userPhone;
//   }

//   int cardLength = 0;
//   changeCardLength(int value) {
//     cardLength = value;
//     notifyListeners();
//   }

//   // getCardLength(BuildContext context) async {
//   //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
//   //     Urls.getCartCount,
//   //   );
//   //   result.fold(
//   //     (error) async {},
//   //     (result) async {
//   //       cardLength = result['number'];
//   //       notifyListeners();
//   //     },
//   //   );
//   // }
//   static final AudioPlayer _audioPlayer = AudioPlayer();
//   static AudioPlayer get audioPlayer {
//     return _audioPlayer;
//   }

//   Future<bool> fetchUserData(BuildContext context) async {
//     // var sizes = MediaQuery.of(context).size;
//     // setSizes(sizes);
//     // GlobalController.mainFontColor = Theme.of(context).primaryColor;
//     // GlobalController.backgroundColor = Theme.of(context).canvasColor;
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final userData =
//         json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
//     GlobalController.token = userData['token'];
//     // GlobalController.userId = userData['userId'];
//     try {
//       GlobalController.userName = userData['username'];
//     } catch (e) {}
//     // GlobalController.userPhone = userData['userPhone'];
//     notifyListeners();
//     // await getCardLength(context);
//     return true;
//   }
// }

const Color mainFontColor = Colors.white;
