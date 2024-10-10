import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noon/common/constants/assets.dart';

import '../../../common/theme/app_colors.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {super.key,
      required this.incremeant,
      required this.decremeant,
      required this.value});
  final Function() incremeant;
  final Function() decremeant;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
                color: AppColors.greyColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle),
            child: IconButton(
                onPressed: incremeant,
                icon: SvgPicture.asset(Assets.svgsPlus1)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
                color: AppColors.greyColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle),
            child: IconButton(
                onPressed: decremeant,
                icon: SvgPicture.asset(Assets.svgsMinus)),
          ),
        ],
      ),
    );
  }
}
