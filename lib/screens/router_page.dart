import 'package:flutter/material.dart';
import 'package:photodatabase/components/photo_database_tabbar.dart';
import 'package:photodatabase/screens/folders_page.dart';
import 'package:photodatabase/screens/images_page.dart';
import 'package:photodatabase/screens/union_page.dart';
import 'package:platform_info/platform_info.dart';

const int tabCount = 3;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class RouterPage extends StatefulWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  RestorableInt tabIndex = RestorableInt(1);

  @override
  String get restorationId => 'home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabCount, vsync: this)
      ..addListener(() {
        setState(() {
          tabIndex.value = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  bool isDesktop() => Platform.I.isDesktop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _isDesktop = isDesktop();
    var tabBarView = TabBarView(
      physics: const PageScrollPhysics(),
      controller: _tabController,
      children: _buildTabViews(),
    );
    return Scaffold(
      appBar: AppBar(
        primary: true,
        flexibleSpace: Container(
          alignment: Alignment.topCenter,
          child: SafeArea(
            top: !_isDesktop,
            child: PhotoDatabaseTabBar(
              tabs: buildTabs(
                context: context,
                theme: theme,
                isVertical: true,
                tabController: _tabController,
              ),
              tabController: _tabController,
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: !_isDesktop,
        // bottom: !_isDesktop,
        child: Theme(
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: tabBarView,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabViews() {
    return const [
      FoldersPage(),
      ImagesPage(),
      UnionPage(),
    ];
  }
}
