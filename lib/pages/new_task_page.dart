import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cursos = ['Programación Web', 'Cálculo 1', 'Historia'];
    String? selectedCourse;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.green),
          onPressed: () {},
        ),
        title: const Text(
          'Nueva tarea',
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
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            // Selección de curso
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Selecciona un curso',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: cursos.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(c),
                );
              }).toList(),
              onChanged: (value) => selectedCourse = value,
            ),
            const SizedBox(height: 20),

            // Nombre de tarea
            TextField(
              decoration: InputDecoration(
                labelText: 'Ejemplo: Ensayo de redes sociales',
                suffixIcon: const Icon(Icons.edit, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Fecha límite
            TextField(
              decoration: InputDecoration(
                labelText: 'Agregar deadline (opcional)',
                suffixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Botones
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'GUARDAR',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
