import 'package:flutter/material.dart';
import 'package:photodatabase/components/photo_database_tabbar.dart';

const int tabCount = 3;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;
// Все изображения - Страница изображения
// Список папок - Страница папки - Страница изображения
// Таблица

class RouterPage extends StatefulWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  RestorableInt tabIndex = RestorableInt(2);

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

  bool isDesktop() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _isDesktop = isDesktop();
    var tabBarView = Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _buildTabViews(),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          alignment: Alignment.topCenter,
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
      body: SafeArea(
        top: !_isDesktop,
        bottom: !_isDesktop,
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Photo Database'),
    //   ),
    //   body: const Center(
    //     child: Text('HomePage'),
    //   ),
    // );
  }

  List<Widget> _buildTabViews() {
    return const [
      Scaffold(body: Center(child: Text('0'))),
      Scaffold(body: Center(child: Text('1'))),
      Scaffold(body: Center(child: Text('2'))),
    ];
  }
}
