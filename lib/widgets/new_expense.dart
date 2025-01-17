import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedDate = 'No date selected';
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    if (pickedDate != null) {
      setState(() {
        _selectedDate = formatter.format(pickedDate);
      });
    }
  }

  void onChangeCategory(Category? selectedItem) {
    if (selectedItem == null) {
      return;
    }
    setState(() {
      _selectedCategory = selectedItem;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 15,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text('Tittle'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate),
                    IconButton(
                        onPressed: () => _presentDatePicker(),
                        icon: Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (selectedItem) => onChangeCategory(selectedItem)),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: (() =>
                    print(_titleController.text + _amountController.text)),
                child: Text('Save expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
