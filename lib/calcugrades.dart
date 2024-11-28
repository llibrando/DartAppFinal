import 'package:flutter/material.dart';

class CalcugradesApp extends StatefulWidget {
  const CalcugradesApp({super.key});

  @override
  _CalcugradesAppState createState() => _CalcugradesAppState();
}

class _CalcugradesAppState extends State<CalcugradesApp> {
  final TextEditingController _atController = TextEditingController();
  final TextEditingController _tlaController = TextEditingController();
  final TextEditingController _examController = TextEditingController();

  double terminalGrade = 0.0;
  String errorMessage = '';

  void calculateGrade() {
    setState(() {
      errorMessage = '';
      terminalGrade = 0.0; 
    });

    try {
      // Parse inputs
      List<double> atScores = _atController.text.split(',')
          .map((s) {
            final score = double.tryParse(s.trim());
            if (score == null) throw FormatException('Invalid AT score');
            return score;
          }).toList();

      List<double> tlaScores = _tlaController.text.split(',')
          .map((s) {
            final score = double.tryParse(s.trim());
            if (score == null) throw FormatException('Invalid TLA score');
            return score;
          }).toList();

      double? examScore = double.tryParse(_examController.text);
      if (examScore == null) throw FormatException('Invalid Exam score');

      if (atScores.isEmpty && tlaScores.isEmpty) throw Exception('No scores entered.');

      // Calculate CO_i
      double sumAT = atScores.reduce((a, b) => a + b);
      double sumTLA = tlaScores.reduce((a, b) => a + b);
      
      double CO_i = (0.7 * (sumAT / atScores.length)) + (0.3 * sumTLA);

      // Calculate Terminal Grade
      terminalGrade = (0.7 * CO_i) + (0.3 * examScore);
    } catch (e) {
      setState(() {
        errorMessage = e.toString(); // Display the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcugrades'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/clayton-robbins-ihqB-c8C7Bc-unsplash.jpg"), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _atController,
                  style: TextStyle(color: Colors.white), 
                  decoration: InputDecoration(
                    labelText: 'Enter AT scores (comma-separated)',
                    labelStyle: TextStyle(color: Colors.white), 
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5), 
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _tlaController,
                  style: TextStyle(color: Colors.white), 
                  decoration: InputDecoration(
                    labelText: 'Enter TLA scores (comma-separated)',
                    labelStyle: TextStyle(color: Colors.white), 
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5), 
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _examController,
                  style: TextStyle(color: Colors.white), 
                  decoration: InputDecoration(
                    labelText: 'Enter Exam score',
                    labelStyle: TextStyle(color: Colors.white), 
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5), 
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: calculateGrade,
                  child: const Text('Calculate Terminal Grade'),
                ),
                SizedBox(height: 20),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                if (terminalGrade > 0)
                  Text(
                    'Terminal Grade: ${terminalGrade.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}