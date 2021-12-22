import 'package:flutter/material.dart';
import 'package:photodatabase/screens/router_page.dart';

class PhotoDatabaseTabBar extends StatelessWidget {
  const PhotoDatabaseTabBar(
      {Key? key, required this.tabs, required this.tabController})
      : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalOrder(
      order: const NumericFocusOrder(0),
      child: TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
        controller: tabController,
        indicatorColor: Theme.of(context).selectedRowColor,
      ),
    );
  }
}

List<Widget> buildTabs({
  required BuildContext context,
  required ThemeData theme,
  bool isVertical = true,
  required TabController tabController,
}) {
  return [
    _Tab(
      theme: theme,
      iconData: Icons.folder_outlined,
      title: 'Folders',
      tabIndex: 0,
      tabController: tabController,
      isVertical: isVertical,
      tabCount: tabCount,
    ),
    _Tab(
      theme: theme,
      iconData: Icons.image_search_outlined,
      title: 'Photos',
      tabIndex: 1,
      tabController: tabController,
      isVertical: isVertical,
      tabCount: tabCount,
    ),
    _Tab(
      theme: theme,
      iconData: Icons.table_chart_outlined,
      title: 'Union',
      tabIndex: 2,
      tabController: tabController,
      isVertical: isVertical,
      tabCount: tabCount,
    ),
  ];
}

class _Tab extends StatefulWidget {
  _Tab({
    required ThemeData theme,
    required IconData iconData,
    required String title,
    required int tabIndex,
    required TabController tabController,
    required this.isVertical,
    required this.tabCount,
  })  : isExpanded = tabController.index == tabIndex,
        icon = Icon(
          iconData,
          semanticLabel: title,
        );

  // final Text titleText;
  final Icon icon;
  final bool isExpanded;
  final bool isVertical;
  final int tabCount;

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<_Tab> with SingleTickerProviderStateMixin {
  late Animation<double> _iconFadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.5, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(_Tab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const expandedTitleWidthMultiplier = 2;
    final unitWidth = width / (tabCount + expandedTitleWidthMultiplier);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Expanded(
        child: FadeTransition(
          opacity: _iconFadeAnimation,
          child: SizedBox(
            width: unitWidth,
            child: widget.icon,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
