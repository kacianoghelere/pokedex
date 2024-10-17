import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_evolution_chain.dart';
import 'package:pokedex/widgets/pokemon_carousel_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EvolutionChainCarrousel extends StatefulWidget {
  final PokemonEvolutionChain evolutionChain;

  const EvolutionChainCarrousel({super.key, required this.evolutionChain});

  @override
  State<EvolutionChainCarrousel> createState() => _EvolutionChainCarrouselState();
}

class _EvolutionChainCarrouselState extends State<EvolutionChainCarrousel> {
  final _carouselController = PageController(viewportFraction: 0.7);
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = widget.evolutionChain.stages.length;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const SizedBox(height: 36),
              ExpandablePageView.builder(
                controller: _carouselController,
                // allows our shadow to be displayed outside of widget bounds
                clipBehavior: Clip.none,
                onPageChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemCount: itemCount,
                itemBuilder: (_, index) {
                  if (!_carouselController.position.haveDimensions) {
                    return const SizedBox();
                  }

                  return AnimatedBuilder(
                    animation: _carouselController,
                    builder: (_, __) => Transform.scale(
                      scale: max(
                        0.8,
                        (1 - (_carouselController.page! - index).abs() / 2),
                      ),
                      child: PokemonCarouselCard(
                        pokemon: widget.evolutionChain.stages[index],
                        isSelected: index == selectedIndex,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              SmoothPageIndicator(
                controller: _carouselController,
                count: itemCount,
                effect: SwapEffect(
                  dotColor: Colors.grey.shade300,
                  activeDotColor: Colors.blue.shade300,
                  dotHeight: 8,
                  dotWidth: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
