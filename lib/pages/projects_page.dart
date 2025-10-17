import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  // Estado de las tareas
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Programación Web',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.red),
                  title: const Text('Entregar informe final'),
                  subtitle: const Text(
                    'Entrega: 25/10',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  trailing: Checkbox(
                    value: _isChecked,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí podrías agregar una nueva tarea
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

