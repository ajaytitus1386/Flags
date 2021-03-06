import 'package:flags_task/features/flags/presentation/widgets/language_grid_widget.dart';
import 'package:flutter/material.dart';

class LanguageListBuilder extends StatefulWidget {
  final List<String> languages;
  const LanguageListBuilder({Key? key, required this.languages})
      : super(key: key);

  @override
  _LanguageListBuilderState createState() => _LanguageListBuilderState();
}

class _LanguageListBuilderState extends State<LanguageListBuilder> {
  @override
  Widget build(BuildContext context) {
    int crossAxisCountGrid = widget.languages.length == 1 ? 1 : 2;
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.languages.length,
        itemBuilder: (context, index) {
          return Center(
            child: LanguageGridWidget(index: index, widget: widget),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCountGrid,
          crossAxisSpacing: 2,
          mainAxisSpacing: 4,
          childAspectRatio: 3,
        ),
      ),
    );
  }
}
