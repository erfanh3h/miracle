import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Widgets/input_box.dart';
import 'package:miracle/Features/days/Models/days.dart';

class AddTitleContentBox extends StatelessWidget {
  const AddTitleContentBox({
    Key? key,
    required this.ontapFunction,
    required this.dayNumber,
  }) : super(key: key);

  final Function ontapFunction;
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleCtrl = TextEditingController();
    final TextEditingController contentCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: Get.height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(
        color: AppColors.background,
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
                  InputBox(
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
                  Padding(
                    padding: AppSpacings.s10Vertical,
                    child: InputBox(
                      label: 'توضیحات',
                      controller: contentCtrl,
                      minLines: 8,
                      validator: (String value) {
                        if ((value).isEmpty) {
                          return 'این فیلد را پر کنید';
                        }
                        return null;
                      },
                      textType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
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
                      content: contentCtrl.text,
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
