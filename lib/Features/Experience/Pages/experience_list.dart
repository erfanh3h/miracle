import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Experience/Controllers/experience_list_controller.dart';
import 'package:miracle/Features/Experience/Widgets/experience_row_widget.dart';

class ExperienceListPage extends StatefulWidget {
  const ExperienceListPage({Key? key}) : super(key: key);

  @override
  State<ExperienceListPage> createState() => _HomePageState();
}

class _HomePageState extends State<ExperienceListPage>
    with AutomaticKeepAliveClientMixin<ExperienceListPage> {
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<ExperienceListController>();

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppbar(
        title: 'تجربیات',
        letBack: false,
      ).build(context),
      body: Obx(
        () => controller.isPageLoading.value
            ? const Center(
                child: GlobalLoadingWidget(),
              )
            : NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    if (controller.scrollController.position.pixels >
                            controller
                                    .scrollController.position.maxScrollExtent -
                                40.r &&
                        !controller.isPageLoadingMore.value &&
                        !controller.lockPage) {
                      controller.getData();
                    }
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getData(resetPage: true);
                  },
                  child: ListView(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Obx(
                          () => Visibility(
                            visible: controller.letShowEachRow[index],
                            child: ExperienceRowWidget(
                              experience: controller.experienceData[index],
                              onTapFunction: () =>
                                  controller.goToExperienceDetails(index),
                              onLikeTap: () {
                                controller.reactExperience(index);
                              },
                            ),
                          ),
                        ),
                        itemCount: controller.experienceData.length,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.gotoAddExperience,
        child: const Icon(
          CupertinoIcons.add,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
