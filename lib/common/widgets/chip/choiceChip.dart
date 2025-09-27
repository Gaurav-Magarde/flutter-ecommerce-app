import 'package:flutter/material.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';
import '../TCircularContainer/TCircularContainer.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;
    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      onSelected: onSelected,
      selected: selected,
      labelStyle: TextStyle(
        color: selected ? TColors.white : null,
      ),
      avatar: isColor
          ? TCircularContainer(
        width: 50,
        height: 50,
        backgroundColor: THelperFunctions.getColor(text)!,
      )
          : null,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      shape: isColor ? const CircleBorder() : null,
      backgroundColor: isColor ? THelperFunctions.getColor(text)! : null,
    );
  }
}
