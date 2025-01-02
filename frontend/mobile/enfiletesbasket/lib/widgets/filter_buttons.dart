import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/tags_provider.dart';

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filters = ["Toutes", "Validées", "Non Validées"];

    return Consumer<TagsProvider>(
      builder: (context, tagsProvider, child) {
        final selectedFilter = tagsProvider.filter;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return ElevatedButton(
              onPressed: () {
                tagsProvider.updateFilter(filter);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue : Colors.grey,
                foregroundColor: isSelected ? Colors.white : Colors.black,
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
