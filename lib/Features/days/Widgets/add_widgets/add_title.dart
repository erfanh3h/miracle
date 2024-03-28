import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class AddTitleBox extends StatelessWidget {
  const AddTitleBox({
    Key? key,
    required this.ontapFunction,
    required this.dayNumber,
  }) : super(key: key);

  final Function ontapFunction;
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: Get.height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  GlobalInputBox(
                    label: 'عنوان',
                    controller: titleCtrl,
                    maxLines: 1,
                    validator: (String value) {
                      if ((value).isEmpty) {
                        return 'این فیلد را پر کنید';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  ontapFunction(
                    DaysModel(
                      dayNumber: dayNumber,
                      title: titleCtrl.text,
                    ),
                  );
                },
                child: const Icon(
                  Icons.save,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
