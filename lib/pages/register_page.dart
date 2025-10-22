import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> _courses = [
    'Programación Web',
    'Cálculo 1',
    'Historia',
  ];

  Future<void> _showAddCourseDialog() async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Agregar curso'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'Ej. Estadística II',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => Navigator.of(ctx).pop(controller.text.trim()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    final value = (result ?? '').trim();

    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un nombre de curso ')),
      );
      return;
    }
    if (_courses.map((e) => e.toLowerCase()).contains(value.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ese curso ya está en la lista ')),
      );
      return;
    }

    setState(() => _courses.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'MoodTasker',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Icon(Icons.bolt, color: Colors.green, size: 60),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  '💫 Bienvenido a MoodTasker\nPlanea según tu energía, no contra ella ;)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 30),

              // Nombre de usuario
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                'Selecciona tus cursos iniciales',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              // Cursos dinámicos
              ..._courses.map((c) => CourseCheckbox(title: c)).toList(),

              TextButton.icon(
                onPressed: _showAddCourseDialog,
                icon: const Icon(Icons.add, color: Colors.green),
                label: const Text(
                  'Agregar curso',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),

              // Botón principal
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'COMENZAR',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCheckbox extends StatefulWidget {
  final String title;
  const CourseCheckbox({super.key, required this.title});

  @override
  State<CourseCheckbox> createState() => _CourseCheckboxState();
}

class _CourseCheckboxState extends State<CourseCheckbox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: checked,
      onChanged: (value) => setState(() => checked = value ?? false),
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
