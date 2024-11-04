import 'package:flutter/material.dart';
import 'package:plugin/widget/carousel_flowdelegate.dart';

class FilterSelector extends StatefulWidget {
  const FilterSelector({
    Key? key,
    required this.filters,
    required this.onFilterChanged,
  }) : super(key: key);

  final List<Color> filters;
  final ValueChanged<Color> onFilterChanged;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  final _pageController = PageController();
  static const _filtersPerScreen = 5;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {}); // Triggers a rebuild to update the delegate.
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Flow(
        delegate: CarouselFlowDelegate(
          viewportOffset: _pageController.position,
          filtersPerScreen: _filtersPerScreen,
        ),
        children: widget.filters
            .map((color) => GestureDetector(
                  onTap: () => widget.onFilterChanged(color),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: color,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
