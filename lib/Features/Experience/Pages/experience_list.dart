import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            : RefreshIndicator(
                onRefresh: () async {
                  controller.getData(resetPage: true);
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ExperienceRowWidget(
                    experience: controller.experienceData[index],
                  ),
                  itemCount: controller.experienceData.length,
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
