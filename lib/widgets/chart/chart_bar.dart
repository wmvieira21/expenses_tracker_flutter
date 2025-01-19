import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;

  @override
  State<StatefulWidget> createState() {
    return _ChartBar();
  }
}

class _ChartBar extends State<ChartBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: FractionallySizedBox(
          heightFactor: widget.fill,
          widthFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
