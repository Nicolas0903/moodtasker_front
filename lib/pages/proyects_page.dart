import 'package:flutter/material.dart';

class ProyectsPage extends StatelessWidget {
  const ProyectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF), // fondo azul claro
      appBar: AppBar(
        title: const Text(
          'Mis tareas',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCourseCard(
              'Programación Web',
              [
                _buildTask('Ensayo de redes sociales', 'Entrega: 12/09', Colors.red),
                _buildTask('Proyecto final', 'Entrega: 25/09', Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            _buildCourseCard(
              'Historia',
              [
                _buildTask('Escribir resumen de clase', '', Colors.green),
              ],
            ),
          ],
        ),
      ),

      // Botón flotante verde
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // Aquí podrías abrir un formulario para agregar tareas
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

    );
  }

  // Widget para cada tarjeta de curso
  Widget _buildCourseCard(String title, List<Widget> tasks) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ...tasks,
          ],
        ),
      ),
    );
  }

  // Widget para cada tarea dentro del curso
  Widget _buildTask(String name, String date, Color iconColor) {
    return ListTile(
      leading: Icon(Icons.calendar_today, color: iconColor),
      title: Text(name),
      subtitle: date.isNotEmpty
          ? Text(
              date,
              style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
            )
          : null,
      trailing: Checkbox(
        value: false,
        onChanged: (value) {},
      ),
    );
  }
}
