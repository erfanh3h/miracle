import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_submit_button.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class AddTitleMultiContentBox extends StatefulWidget {
  const AddTitleMultiContentBox({
    Key? key,
    required this.ontapFunction,
    required this.dayNumber,
    this.maxLength,
  }) : super(key: key);

  final Function ontapFunction;
  final int dayNumber;
  final int? maxLength;

  @override
  State<AddTitleMultiContentBox> createState() =>
      _AddTitleMultiContentBoxState();
}

class _AddTitleMultiContentBoxState extends State<AddTitleMultiContentBox> {
  final TextEditingController titleCtrl = TextEditingController();
  List<TextEditingController> contentCtrls = [];
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.maxLength != null) {
      for (var i = 0; i < widget.maxLength!; i++) {
        contentCtrls.add(TextEditingController());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            ListView(
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
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => Padding(
                    padding: AppSpacings.s5Vertical,
                    child: GlobalInputBox(
                      label: 'مورد${index + 1}',
                      controller: contentCtrls[index],
                      minLines: 8,
                      validator: (String value) {
                        if ((value).isEmpty) {
                          return 'این فیلد را پر کنید';
                        }
                        return null;
                      },
                    ),
                  ),
                  itemCount: contentCtrls.length,
                ),
                Visibility(
                  visible: contentCtrls.length < (widget.maxLength ?? 100),
                  child: Padding(
                    padding: AppSpacings.s20Vertical,
                    child: GlobalSubmitButton(
                      tapFunction: () {
                        contentCtrls.add(TextEditingController());
                        setState(() {});
                      },
                      title: 'افزودن مورد',
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  List<String> contents = [];
                  for (var i = 0; i < contentCtrls.length; i++) {
                    contents.add(contentCtrls[i].text);
                  }
                  widget.ontapFunction(
                    DaysModel(
                      dayNumber: widget.dayNumber,
                      title: titleCtrl.text,
                      multiContents: contents,
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
