import 'package:flutter/material.dart';

import '../../../../../common/texts/section_heading.dart';

class SpecificationSection extends StatefulWidget {
  const SpecificationSection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<SpecificationSection> createState() => _SpecificationSectionState();
}

class _SpecificationSectionState extends State<SpecificationSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final entries = widget.data.entries.toList();
    final visibleEntries = _isExpanded ? entries : entries.take(4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Specification',
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          actionButton: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 24,
          ),
        ),
        const SizedBox(height: 16),
        ...visibleEntries.map((entry) {
          final label = entry.key.replaceAll('_', ' ').toUpperCase();
          final value = entry.value is List
              ? (entry.value as List).join(', ')
              : entry.value.toString();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '$label:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
