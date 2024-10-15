import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class TypesFilter extends StatefulWidget {
  const TypesFilter({super.key});

  @override
  State<TypesFilter> createState() => _TypesFilterState();
}

class _TypesFilterState extends State<TypesFilter> {
  List<DropdownItem<PokemonType>> _getDropdownItems() {
    var pokemonTypes = Provider.of<FilterProvider>(context).types;

    return pokemonTypes.map((type) {
      return DropdownItem(
        label: type.name,
        value: type
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const label = 'Pokemon Types';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium
          ),
        ),
        Consumer<FilterProvider>(
          builder: (context, filterProvider, _) {
            return MultiDropdown<PokemonType>(
              items: _getDropdownItems(),
              controller: filterProvider.pokemonTypesController,
              enabled: true,
              searchEnabled: true,
              chipDecoration: ChipDecoration(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(8),
                wrap: true,
                runSpacing: 2,
                spacing: 10,
              ),
              fieldDecoration: FieldDecoration(
                hintText: label,
                hintStyle: const TextStyle(color: Colors.black45),
                // prefixIcon: const Icon(Icons.ac_unit, color: Colors.black45),
                showClearIcon: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.black87,
                  ),
                ),
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                selectedIcon: Icon(
                  Icons.check_box,
                  color: Theme.of(context).primaryColor
                ),
                disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
              ),
              onSelectionChange: (selectedItems) {
                if (kDebugMode) {
                  debugPrint("Filter filter changed: $selectedItems");
                }

                filterProvider.setTypes(selectedItems);
              },
            );
          }
        ),
      ],
    );
  }
}
