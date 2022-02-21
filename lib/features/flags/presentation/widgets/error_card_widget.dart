import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flutter/material.dart';

class ErrorCardWidget extends StatefulWidget {
  final String message;
  const ErrorCardWidget({Key? key, required this.message}) : super(key: key);

  @override
  _ErrorCardWidgetState createState() => _ErrorCardWidgetState();
}

class _ErrorCardWidgetState extends State<ErrorCardWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Container(
        decoration: cardDecoration,
        width: SizeConfig.cardWidth,
        height: SizeConfig.cardHeight,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: warning,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: buildErrorCardStyle(),
            ),
          )),
        ),
      ),
    );
  }
}
