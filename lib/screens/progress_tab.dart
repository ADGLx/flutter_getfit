import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Your Progress',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildProgressChart(WeightData, "Weight Over Time", Icons.monitor_weight, Colors.blue),
              _buildProgressChart(CaloriesData, "Calories Burned", Icons.local_fire_department, Colors.red),
              _buildProgressChart(StepsData, "Steps Taken", Icons.directions_walk, Colors.green),
              _buildProgressChart(WorkoutData, "Workout Duration", Icons.access_time, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressChart(List<Data> chartData, String title, IconData icondata, Color iconcolor) {
    return Card(
      elevation: 4,
      child: CustomChart(
        chartData: chartData,
        title: title,
        icondata: icondata,
        iconcolor: iconcolor,
      ),
    );
  }
}

class CustomChart extends StatefulWidget {
  final List<Data> chartData;
  final String title;
  final IconData icondata;
  final Color iconcolor;

  const CustomChart({
    super.key,
    required this.chartData,
    required this.title,
    required this.icondata,
    required this.iconcolor,
  });

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  late List<Data> _currentData;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentData = List.from(widget.chartData);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _addDataPoint() async {
    // Suggest a value slightly higher than last entry
    final suggestedValue = _currentData.last.value + (_currentData.last.value * 0.1);
    _textController.text = suggestedValue.toStringAsFixed(1);

    final newValue = await showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add ${widget.title}'),
          content: TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter new ${widget.title.split(' ')[0]} value',
              hintText: 'e.g., ${suggestedValue.toStringAsFixed(1)}',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final value = double.tryParse(_textController.text);
                if (value != null) {
                  Navigator.pop(context, value);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid number')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (newValue != null) {
      setState(() {
        // Generate next month name (simple implementation)
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        final currentMonthIndex = months.indexOf(_currentData.last.day);
        final nextMonth = currentMonthIndex < months.length - 1 
            ? months[currentMonthIndex + 1] 
            : months[0];
        
        _currentData.add(Data(nextMonth, newValue));
      });
    }
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(widget.icondata, color: widget.iconcolor, size: 30),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addDataPoint,
          ),
        ],
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <CartesianSeries>[
            LineSeries<Data, String>(
              color: widget.iconcolor,
              dataSource: _currentData,
              xValueMapper: (Data sales, _) => sales.day,
              yValueMapper: (Data sales, _) => sales.value,
              markerSettings: const MarkerSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample data
List<Data> WeightData = [
  Data("Jan", 65),
  Data("Feb", 64),
  Data("Mar", 67),
  Data("Apr", 65),
];

List<Data> CaloriesData = [
  Data("Jan", 1245),
  Data("Feb", 1500),
  Data("Mar", 1600),
  Data("Apr", 1300),
];

List<Data> StepsData = [
  Data("Jan", 300),
  Data("Feb", 400),
  Data("Mar", 350),
  Data("Apr", 600),
];

List<Data> WorkoutData = [
  Data("Jan", 60),
  Data("Feb", 40),
  Data("Mar", 120),
  Data("Apr", 80),
];

class Data {
  Data(this.day, this.value);
  final String day;
  final double value;
}