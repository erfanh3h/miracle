import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  const GlobalBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    return Obx(
      () => SizedBox(
        // color: Colors.transparent.withOpacity(.5),
        height: 70,
        child: BottomNavigationBar(
          currentIndex: globalController.selectedPage.value,
          onTap: (index) {
            globalController.pgCtrl.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_incandescent_outlined),
              label: 'معجزه',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_on_doc),
              label: 'تجربه',
            ),
          ],
        ),
      ),
    );
  }
}
