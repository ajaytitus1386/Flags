import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/languages_list_builder.dart';
import 'package:flutter/material.dart';

class LanguageGridWidget extends StatelessWidget {
  const LanguageGridWidget({
    Key? key,
    required this.index,
    required this.widget,
  }) : super(key: key);

  final int index;
  final LanguageListBuilder widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          color: secondary,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(
        widget.languages[index],
        style: buildLanguageTextStyle(),
      ),
    );
  }
}
