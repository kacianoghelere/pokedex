import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline))
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://via.placeholder.com/600x400',
                    fit: BoxFit.cover,
                  ),
                  title: const Text('Tabs Screen'),
                  centerTitle: true,
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Sessão 1'),
                      Tab(text: 'Sessão 2'),
                      Tab(text: 'Sessão 3'),
                    ],
                  ),
                ),
                pinned: true, // Mantém as tabs fixas no topo ao rolar
              ),
            ];
          },
          body: TabBarView(
            children: [
              _renderTabContent('Conteúdo da Sessão 1'),
              _renderTabContent('Conteúdo da Sessão 2'),
              _renderTabContent('Conteúdo da Sessão 3'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderTabContent(String text) {
    return Column(
      children: [
        Text(text),
        const Placeholder(fallbackHeight: 700,)
      ],
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}