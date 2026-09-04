import 'package:flutter/material.dart';
import 'package:miracle/Widgets/global/global_input_box.dart';
import 'package:miracle/Widgets/global/global_submit_button.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Models/days.dart';

class Day1AddWidget extends StatelessWidget {
  const Day1AddWidget({
    super.key,
    required this.ontapFunction,
    required this.dayNumber,
  });

  final Function ontapFunction;
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleCtrl = TextEditingController();
    final TextEditingController contentCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
                  Padding(
                    padding: AppSpacings.s10Vertical,
                    child: GlobalInputBox(
                      label: 'توضیحات',
                      controller: contentCtrl,
                      minLines: 8,
                      validator: (String value) {
                        if ((value).isEmpty) {
                          return 'این فیلد را پر کنید';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppSpacings.s5Vertical,
              child: GlobalSubmitButton(
                tapFunction: () {
                  if (!formKey.currentState!.validate()) return;
                  ontapFunction(
                    DaysModel(
                      dayNumber: dayNumber,
                      title: titleCtrl.text,
                      content: contentCtrl.text,
                    ),
                  );
                },
                title: 'ذخیره',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
