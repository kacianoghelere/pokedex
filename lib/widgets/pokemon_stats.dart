import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/models/pokemon_stat.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/extensions/color_extension.dart';
import 'package:pokedex/widgets/section_title.dart';
import 'package:provider/provider.dart';

class PokemonStats extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonStats({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = Provider.of<ThemeProvider>(context).mode;

    bool isDarkTheme = themeMode == ThemeMode.dark;

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
                fontWeight: FontWeight.w900
              ),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: LinearPercentIndicator(
                  barRadius: const Radius.circular(16),
                  backgroundColor: isDarkTheme
                    ? const Color.fromRGBO(15, 15, 15, 1)
                    : const Color.fromRGBO(245, 245, 245, 1),
                  center: Text(
                    stat.value.toString(),
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      shadows: isDarkTheme ? const [
                        Shadow(
                          blurRadius: 1,
                          color: Colors.black87,
                          offset: Offset(1.0, 1.0),
                        )
                      ] : null
                    ),
                  ),
                  lineHeight: 20.0,
                  percent: _getStatValue(stat),
                  progressColor: pokemon.typeColor.getColorByThemeMode(themeMode),
                ),
              ),
            );
          }
        )
      ],
    );
  }

  double _getStatValue(PokemonStat stat) {
    return stat.value / 150;
  }
}
