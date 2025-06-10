import 'dart:math' as math;

import 'package:fitstart/utils/app_colors.dart';
import 'package:flutter/material.dart';
class NumberSelector extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final ValueChanged<int> onChanged;

  const NumberSelector({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late ScrollController _scrollController;
  late int _selectedValue;
  final double _itemWidth = 70.0;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    final initialOffset = (_selectedValue - widget.minValue) * _itemWidth;
    _scrollController = ScrollController(initialScrollOffset: initialOffset);
    _scrollController.addListener(_onScroll);
  }
  
  void _onScroll() {
      final centerIndex = (_scrollController.offset / _itemWidth).round();
      final centerValue = widget.minValue + centerIndex;
      if (centerValue != _selectedValue) {
        setState(() {
          _selectedValue = centerValue;
        });
      }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _snapToCenter() {
    final double offset = _scrollController.offset;
    final int nearestItemIndex = (offset / _itemWidth).round();
    final double snapOffset = nearestItemIndex * _itemWidth;

    _scrollController.animateTo(
      snapOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ).then((_) {
       final int finalValue = widget.minValue + nearestItemIndex;
       widget.onChanged(finalValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = (MediaQuery.of(context).size.width / 2) - _itemWidth / 2;
    final int itemCount = widget.maxValue - widget.minValue + 1;

    const selectedStyle = TextStyle(
      color: AppColors.primaryColor, // 3rd item: Highlighted
      fontSize: 48,
      fontWeight: FontWeight.bold,
    );
    final mediumStyle = TextStyle(
      color: Colors.white.withOpacity(0.8), // 2nd & 4th items: Medium with 0.8 opacity
      fontSize: 36,
      fontWeight: FontWeight.normal,
    );
    final smallStyle = TextStyle(
      color: Colors.white.withOpacity(0.5), // 1st & 5th items: Small with 0.5 opacity
      fontSize: 18,
      fontWeight: FontWeight.normal,
    );
    final distantStyle = TextStyle(
      color: Colors.white.withOpacity(0.0), // Other items: Invisible
      fontSize: 18,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              _snapToCenter();
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemExtent: _itemWidth,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              itemBuilder: (context, index) {
                final int currentValue = widget.minValue + index;
                final int difference = (currentValue - _selectedValue).abs();

                TextStyle style;
                // Apply style based on the distance from the selected center value
                switch (difference) {
                  case 0: // The selected item (3rd in view)
                    style = selectedStyle;
                    break;
                  case 1: // Immediate neighbors (2nd and 4th in view)
                    style = mediumStyle;
                    break;
                  case 2: // Outer visible neighbors (1st and 5th in view)
                    style = smallStyle;
                    break;
                  default: // All other items outside the 5-item window
                    style = distantStyle;
                    break;
                }

                return Container(
                  width: _itemWidth,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Left separator: only visible for the selected item
                      Container(
                        height: difference == 0 ? 35 : 20,
                        width: 2,
                        color: difference == 0 ? Colors.grey[700] : Colors.transparent,
                      ),
                      Text(currentValue.toString(), style: style),
                      // Right separator: only visible for the selected item
                      Container(
                        height: difference == 0 ? 35 : 20,
                        width: 2,
                        color: difference == 0 ? Colors.grey[700] : Colors.transparent,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Icon(
          Icons.arrow_drop_up,
          color: Colors.white,
          size: 35,
        ),
      ],
    );
  }
}