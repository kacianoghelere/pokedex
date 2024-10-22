import 'package:flutter/material.dart';

class StickyHeaderScreen extends StatelessWidget {
  const StickyHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://via.placeholder.com/400x300',
                fit: BoxFit.cover,
              ),
              title: const Text('Sticky Headers'),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          // Seções com Headers e Conteúdo
          _buildStickyHeader('Seção 1'),
          _buildSectionContent(),
          _buildStickyHeader('Seção 2'),
          _buildSectionContent(),
          _buildStickyHeader('Seção 3'),
          _buildSectionContent(),
        ],
      ),
    );
  }

  // Header fixo e substituível
  SliverPersistentHeader _buildStickyHeader(String text) {
    return SliverPersistentHeader(
      pinned: true, // Mantém o header fixo no topo
      delegate: _StickyHeaderDelegate(
        text: text,
        minHeight: 60.0, // Altura mínima e máxima do header
        maxHeight: 60.0,
      ),
    );
  }

  // Conteúdo de cada seção
  SliverList _buildSectionContent() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          height: 300.0, // Altura do conteúdo para simular scroll longo
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Text(
            'Conteúdo ${index + 1}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        childCount: 3, // 3 itens por seção para efeito de exemplo
      ),
    );
  }
}

// Delegate que controla o comportamento do header sticky
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String text;
  final double minHeight;
  final double maxHeight;

  _StickyHeaderDelegate({
    required this.text,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey.shade500,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! _StickyHeaderDelegate || oldDelegate.text != text;
  }
}
