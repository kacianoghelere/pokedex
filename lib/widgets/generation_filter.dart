import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:pokedex/models/generation.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class GenerationFilter extends StatefulWidget {
  const GenerationFilter({super.key});

  @override
  State<GenerationFilter> createState() => _GenerationFilterState();
}

class _GenerationFilterState extends State<GenerationFilter> {
  List<DropdownItem<Generation>> _getDropdownItems() {
    var generations = Provider.of<FilterProvider>(context).generations;

    return generations.map((generation) {
      return DropdownItem(
        label: generation.name,
        value: generation
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const label = 'Generations';

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
            return MultiDropdown<Generation>(
              items: _getDropdownItems(),
              controller: filterProvider.generationsController,
              enabled: true,
              searchEnabled: true,
              chipDecoration: ChipDecoration(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(8),
                wrap: false,
                runSpacing: 2,
                spacing: 10,
              ),
              fieldDecoration: FieldDecoration(
                hintText: label,
                hintStyle: const TextStyle(color: Colors.black45),
                // prefixIcon: const Icon(Icons.book, color: Colors.black45),
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
                  debugPrint("Generation filter changed: $selectedItems");
                }

                filterProvider.setGenerationIds(selectedItems);
              },
            );
          }
        )
      ],
    );
  }
}
