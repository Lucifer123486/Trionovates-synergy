import 'package:flutter/material.dart';

void main() {
  runApp(MoneyManagementApp());
}

class MoneyManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SalaryExpenseCalculator(),
    );
  }
}

class SalaryExpenseCalculator extends StatefulWidget {
  @override
  _SalaryExpenseCalculatorState createState() =>
      _SalaryExpenseCalculatorState();
}

class _SalaryExpenseCalculatorState extends State<SalaryExpenseCalculator> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  double? _savings;

  void _calculateSavings() {
    final double salary = double.tryParse(_salaryController.text) ?? 0.0;
    final double expenses = double.tryParse(_expensesController.text) ?? 0.0;

    setState(() {
      _savings = salary - expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        title: Text('Money Management', style: TextStyle(fontSize: 22)),
        backgroundColor: Color(0xFF6C63FF),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Track your finances",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A3A3A),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Enter your salary and expenses to calculate savings.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 30),
              _buildTextField(
                  label: 'Salary',
                  controller: _salaryController,
                  icon: Icons.attach_money),
              SizedBox(height: 20),
              _buildTextField(
                  label: 'Expenses',
                  controller: _expensesController,
                  icon: Icons.shopping_cart),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _calculateSavings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Calculate Savings',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              if (_savings != null) _buildResultsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      required IconData icon}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16, color: Color(0xFF3A3A3A)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF6C63FF)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: "Enter $label",
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF6C63FF), width: 2),
        ),
      ),
    );
  }

  Widget _buildResultsCard() {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A3A3A),
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 1),
            SizedBox(height: 10),
            _buildResultRow("Total Salary", "\$${_salaryController.text}"),
            _buildResultRow("Total Expenses", "\$${_expensesController.text}"),
            _buildResultRow(
              "Savings",
              "\$${_savings!.toStringAsFixed(2)}",
              color: _savings! >= 0 ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Color(0xFF3A3A3A)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color ?? Color(0xFF3A3A3A),
            ),
          ),
        ],
      ),
    );
  }
}
