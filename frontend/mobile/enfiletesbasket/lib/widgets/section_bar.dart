import 'package:flutter/material.dart';

class SectionBar extends StatelessWidget {
  final List<String> sections;
  final int selectedIndex;
  final Function(int) onSectionSelected;

  SectionBar({required this.sections, required this.selectedIndex, required this.onSectionSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(sections.length, (index) {
          return GestureDetector(
            onTap: () => onSectionSelected(index),
            child: Text(
              sections[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                color: selectedIndex == index ? Colors.blue : Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}