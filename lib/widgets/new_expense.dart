import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSaveNewExpenseList});

  final Function(Expense expense) onSaveNewExpenseList;

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

  void _onChangeCategory(Category? selectedItem) {
    if (selectedItem == null) {
      return;
    }
    setState(() {
      _selectedCategory = selectedItem;
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = (enteredAmount == null || enteredAmount <= 0);

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == 'No date selected') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure the tittle, amount and data are valid.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onSaveNewExpenseList(Expense(
        tittle: _titleController.text,
        amount: enteredAmount,
        date: formatter.parse(_selectedDate),
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final widgetWidth = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, keyBoardSpace + 16),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                    if (widgetWidth >= 600)
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
                          onChanged: (selectedItem) =>
                              _onChangeCategory(selectedItem)),
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
                    if (widgetWidth < 600)
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
                          onChanged: (selectedItem) =>
                              _onChangeCategory(selectedItem)),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => _submitExpense(),
                      child: Text('Save expense'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
