import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
 
  final _titleController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  @override
  void dispose(){
    super.dispose();

    _titleController.dispose();
  }

  void onCreate() {
    //  1 Build an expense
    String  title = _titleController.text;
    double amount = 0;   
              // for now..
    Category category = _selectedCategory;   // for now..
    DateTime date = _selectedDate ?? DateTime.now();

    // ignore: unused_local_variable
    Expense newExpense = Expense(title: title, amount: amount, date: date, category: category);

    // TODO YOUR CODE HERE
    Navigator.pop(context, newExpense);


  }

  Future<void> _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year -1, now.month, now.day);
    final DateTime lastDate = now;

    final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    

  }

  
  
  void onCancel() {
   
    // Close the modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          Row(
            children: [
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
              Spacer(),
              IconButton(
                onPressed: _presentDatePicker,
                icon: Icon(Icons.calendar_month),
              ),
            ],
          ),
          SizedBox(height: 10,),
          DropdownButton<Category>(
          value: _selectedCategory,
          items: Category.values.map((category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Text(category.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (Category? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCategory = newValue;
              });
            }
          },
        ),

           ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
           SizedBox(width: 10,),
          ElevatedButton(onPressed: onCreate, child: Text("Create")),
        ],
      ),
    );
  }
}
