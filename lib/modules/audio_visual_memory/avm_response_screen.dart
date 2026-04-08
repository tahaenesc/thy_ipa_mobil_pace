import 'package:flutter/material.dart';
import '../../components/thy_header.dart';

class AVMResponseScreen extends StatefulWidget {
  final int currentPractice;
  final int totalPractices;
  final List<String> correctCities;
  final VoidCallback onComplete;
  final VoidCallback onExit;

  const AVMResponseScreen({
    super.key,
    required this.currentPractice,
    required this.totalPractices,
    required this.correctCities,
    required this.onComplete,
    required this.onExit,
  });

  @override
  State<AVMResponseScreen> createState() => _AVMResponseScreenState();
}

class _AVMResponseScreenState extends State<AVMResponseScreen> {
  final List<String> _allCities = [
    'Amsterdam', 'Ankara', 'Ashgabat', 'Baghdad', 'Bahrain',
    'Baku', 'Bangkok', 'Basel', 'Batumi', 'Beirut',
    'Belgrade', 'Berlin', 'Bilbao', 'Bishkek', 'Bologna',
    'Bombay', 'Boston', 'Bremen', 'Budapest', 'Dallas',
    'Delhi', 'Doha', 'Dubai', 'Dublin', 'Hamburg',
    'Havana', 'Houston', 'Kathmandu', 'Kiev', 'Lagos',
    'Lisbon', 'London', 'Lyon', 'Madrid', 'Malaga',
    'Malta', 'Manchester', 'Melbourne', 'Miami', 'Milan',
    'Montreal', 'Moscow', 'Munich', 'Paris', 'Phuket',
    'Porto', 'Prague', 'Riyadh', 'Rotterdam', 'Salzburg',
    'Santiago', 'Shanghai', 'Singapore', 'Stockholm', 'Stuttgart',
    'Sydney', 'Tashkent', 'Tokyo', 'Toronto', 'Tunis',
    'Valencia', 'Venice', 'Vienna', 'Zagreb', 'Zurich'
  ];
  final Set<String> _selectedCities = {};

  void _toggleCity(String city, bool? selected) {
    setState(() {
      if (selected == true) {
        _selectedCities.add(city);
      } else {
        _selectedCities.remove(city);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          ThyHeader(
            trailing: Text(
              'Practice ${widget.currentPractice} of ${widget.totalPractices}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4.5,
                ),
                itemCount: _allCities.length,
                itemBuilder: (context, index) {
                  final city = _allCities[index];
                  final isSelected = _selectedCities.contains(city);
                  return Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey),
                    child: CheckboxListTile(
                      value: isSelected,
                      onChanged: (val) => _toggleCity(city, val),
                      title: Text(
                        city,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      activeColor: const Color(0xFF0078D7),
                      checkColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: widget.onComplete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0078D7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

