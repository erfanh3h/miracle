import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Models/days.dart';

class ShowTitleContentImageBox extends StatelessWidget {
  const ShowTitleContentImageBox({super.key, required this.data});

  final DaysModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: ListView(
        children: [
          Container(
            padding: AppSpacings.s10All,
            margin: AppSpacings.s10Bottom,
            decoration: const BoxDecoration(),
            child: Image.memory(
              data.image!,
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).width / 2,
              // fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: AppSpacings.s10All,
            child: Text(
              data.title ?? '',
              style: context.textTheme.bodyLarge,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: AppSpacings.s10Horizental,
            child: Text(
              data.content ?? '',
              style: context.textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
