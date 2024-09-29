import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'Fahrenheit to Celsius';
  String _convertedValue = '';
  final List<String> _conversionHistory = [];
  bool _showHistory = false;

  void _convertTemperature() {
    double inputValue = double.tryParse(_controller.text) ?? 0.0;

    double result = 0.0;
    if (_conversionType == 'Fahrenheit to Celsius') {
      result = (inputValue - 32) * 5 / 9; // Fahrenheit to Celsius formula
    } else {
      result = (inputValue * 9 / 5) + 32; // Celsius to Fahrenheit formula
    }

    setState(() {
      _convertedValue = result.toStringAsFixed(2);
      _conversionHistory.insert(
          0, '$_conversionType: $inputValue => $_convertedValue');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Temperature Converter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Conversion type selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('F to C'),
                      value: 'Fahrenheit to Celsius',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('C to F'),
                      value: 'Celsius to Fahrenheit',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Input field for temperature
              SizedBox(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter Temperature',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20),

              // Convert button
              ElevatedButton(
                onPressed: _convertTemperature,
                child: const Text('Convert'),
              ),
              const SizedBox(height: 20),

              // Display result
              Text(
                'Result: $_convertedValue',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Show/Hide history button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showHistory = !_showHistory;
                  });
                },
                child: Text(_showHistory ? 'Hide History' : 'Show History'),
              ),
              const SizedBox(height: 20),

              // Conversion history list
              _showHistory
                  ? SizedBox(
                      height: screenHeight * 0.3, // Limit the height for history list
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _conversionHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_conversionHistory[index]),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
