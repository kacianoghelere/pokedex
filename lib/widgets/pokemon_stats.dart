import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/models/pokemon_stat.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/widgets/section_title.dart';
import 'package:provider/provider.dart';

class PokemonStats extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonStats({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).mode == ThemeMode.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Stats'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pokemon.stats.length,
          itemBuilder: (context, index) {
            final stat = pokemon.stats[index];

            return ListTile(
              title: Text(toBeginningOfSentenceCase(stat.name)),
              titleTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold
              ),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: LinearPercentIndicator(
                  barRadius: const Radius.circular(16),
                  backgroundColor: isDarkTheme ? Colors.white12 : Colors.black12,
                  center: Text(
                    stat.value.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  lineHeight: 20.0,
                  percent: _getStatValue(stat),
                  progressColor: pokemon.typeColor,
                ),
              ),
            );
          }
        )
      ],
    );
  }

  double _getStatValue(PokemonStat stat) {
    return stat.value / 200;
  }
}
