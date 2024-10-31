import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/nothing_found_indicator.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokemonList extends StatefulWidget {
  final List<Pokemon> pokemons;
  final bool shrinkWrap;
  final void Function() onEdgeReached;
  final void Function(String text) onSearchTextChanged;

  const PokemonList({
    super.key,
    required this.pokemons,
    required this.onEdgeReached,
    required this.onSearchTextChanged,
    this.shrinkWrap = false,
  });

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _scrollController = ScrollController();
  bool _showSearchBar = true;
  Timer? _textSearchDebouncer;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrollDirection = _scrollController.position.userScrollDirection;

    if (scrollDirection == ScrollDirection.reverse && _showSearchBar) {
      setState(() => _showSearchBar = false);
    } else if (scrollDirection == ScrollDirection.forward && _showSearchBar == false) {
      setState(() => _showSearchBar = true);
    }
  }

  void _onSearchByText(String text) {
    if ((_textSearchDebouncer?.isActive ?? false)) {
      _textSearchDebouncer?.cancel();
    }

    _textSearchDebouncer = Timer(Durations.medium4, () {
      widget.onSearchTextChanged(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pokemons.isEmpty) {
      return const NothingFoundIndicator();
    }

    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
          widget.onEdgeReached();
        }

        return false;
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showSearchBar ? 70.0 : 0.0,
            child: _showSearchBar
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search by name or ID',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _onSearchByText,
                    onSubmitted: _onSearchByText,
                  ),
                )
              : null,
          ),
          Expanded(
            child: ListView.builder(
              addRepaintBoundaries: true,
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shrinkWrap: widget.shrinkWrap,
              prototypeItem: PokemonCard(pokemon: widget.pokemons.first),
              itemCount: widget.pokemons.length,
              itemBuilder: (context, index) {
                return PokemonCard(pokemon: widget.pokemons[index]);
              }
            ),
          ),
        ],
      ),
    );
  }
}