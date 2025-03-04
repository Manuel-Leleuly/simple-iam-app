import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final Text label;
  final bool? isRequired;

  const FieldLabel({super.key, required this.label, this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          label,
          const SizedBox(width: 5),
          if (isRequired == true)
            Text(
              '*',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 20,
                    color: Colors.red,
                  ),
            ),
        ],
      ),
    );
  }
}
