import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:pokedex/models/multiselect_item.dart';

class GenerationFilter extends StatefulWidget {
  const GenerationFilter({super.key});

  @override
  State<GenerationFilter> createState() => _GenerationFilterState();
}

class _GenerationFilterState extends State<GenerationFilter> {
  final controller = MultiSelectController<MultiselectItem>();

  @override
  Widget build(BuildContext context) {
    var items = [1, 2, 3, 4, 5, 6, 7].map((id) {
      return DropdownItem(
        label: 'Gen $id',
        value: MultiselectItem(name: 'Gen $id', id: id)
      );
    }).toList();

    return MultiDropdown<MultiselectItem>(
      items: items,
      controller: controller,
      enabled: true,
      searchEnabled: true,
      chipDecoration: ChipDecoration(
        backgroundColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
        wrap: true,
        runSpacing: 2,
        spacing: 10,
      ),
      fieldDecoration: FieldDecoration(
        hintText: 'Generations',
        hintStyle: const TextStyle(color: Colors.black45),
        prefixIcon: const Icon(Icons.book, color: Colors.black45),
        showClearIcon: false,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a generation';
        }

        return null;
      },
      onSelectionChange: (selectedItems) {
        debugPrint("OnSelectionChange: $selectedItems");
      },
    );
  }
}
