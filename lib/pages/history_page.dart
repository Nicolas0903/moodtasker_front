import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tareas completadas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _taskCard('Control de Lectura', 'Completado el 12/09', 'assets/c1.jpg'),
            _taskCard('Trabajo de Progra', 'Completado el 12/09', 'assets/pweb.jpg'),
            _taskCard('Wireframes', 'Completado el 12/09', 'assets/historia.jpg'),

            const SizedBox(height: 30),
            const Text(
              'Tus moods',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 200, child: MoodBarChart()),
          ],
        ),
      ),
    );
  }

  Widget _taskCard(String title, String subtitle, String imagePath) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class MoodBarChart extends StatelessWidget {
  const MoodBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [3, 5, 4, 2, 4, 3, 5]; // valores ejemplo
    final dias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < dias.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(dias[index], style: const TextStyle(fontSize: 12)),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
        barGroups: List.generate(
          data.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: data[i].toDouble(),
                color: Colors.green,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
