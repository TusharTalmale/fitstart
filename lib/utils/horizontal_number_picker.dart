import 'package:fitstart/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HorizontalNumberPicker extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final ValueChanged<int> onChanged;

  const HorizontalNumberPicker({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<HorizontalNumberPicker> createState() => _HorizontalNumberPickerState();
}

class _HorizontalNumberPickerState extends State<HorizontalNumberPicker> {
  late final ScrollController _scrollController;
  late int selectedValue;
  static const double _itemWidth = 60;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    _scrollController = ScrollController(
      initialScrollOffset: (selectedValue - widget.min) * _itemWidth,
    );
  }

  void _onScrollEnd() {
    final idx = (_scrollController.offset / _itemWidth).round();
    final newValue = widget.min + idx;
    if (newValue != selectedValue &&
        newValue >= widget.min &&
        newValue <= widget.max) {
      setState(() => selectedValue = newValue);
      widget.onChanged(newValue);
    }
    _scrollController.animateTo(
      idx * _itemWidth,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenCenter = MediaQuery.of(context).size.width / 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (scroll is ScrollEndNotification) {
                    _onScrollEnd();
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemExtent: _itemWidth,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.max - widget.min + 1,
                  itemBuilder: (context, i) {
                    final value = widget.min + i;
                    final isSel = value == selectedValue;
                    return Center(
                      child: Text(
                        '$value',
                        style: TextStyle(
                          fontSize: isSel ? 32 : 20,
                          color: isSel
                              ? AppColors.primaryColor
                              : Colors.white.withOpacity(.5),
                          fontWeight:
                              isSel ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Left divider
              Positioned(
                left: screenCenter - (_itemWidth / 2),
                child: Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),

              // Right divider
              Positioned(
                left: screenCenter + (_itemWidth / 2),
                child: Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),
        const Icon(Icons.arrow_drop_up, size: 24, color: Colors.white),
      ],
    );
  }
}
