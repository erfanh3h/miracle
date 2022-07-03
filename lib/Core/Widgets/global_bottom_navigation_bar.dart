import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  const GlobalBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    return Obx(
      () => Container(
        color: Colors.transparent.withOpacity(.5),
        height: 70,
        child: BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.primary.withOpacity(.5),
          currentIndex: globalController.selectedPage.value,
          onTap: (index) {
            globalController.pgCtrl.jumpToPage(index);
          },
          elevation: 10,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'حساب کاربری',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_incandescent_outlined),
              label: 'معجزه',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_on_doc),
              label: 'تجربه',
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
