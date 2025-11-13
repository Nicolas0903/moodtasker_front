import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> _courses = ['Programación Web', 'Cálculo 1', 'Historia'];

  Future<void> _showAddCourseDialog() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar curso'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Ej. Estadística II',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
            ),
            child: const Text('Agregar'),
          ),
        ],
      ),
    );

    final value = (result ?? '').trim();
    if (value.isEmpty) return;

    if (_courses.map((e) => e.toLowerCase()).contains(value.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ese curso ya está en la lista')),
      );
      return;
    }

    setState(() => _courses.add(value));
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CAF50);
    const bg = Color(0xFFF2FAF2);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fondo con dados decorativos
                Positioned(
                  top: 40,
                  left: 40,
                  child: _DiceIcon(size: 30, opacity: 0.15),
                ),
                Positioned(
                  top: 100,
                  right: 60,
                  child: _DiceIcon(size: 22, opacity: 0.12),
                ),
                Positioned(
                  bottom: 50,
                  left: 80,
                  child: _DiceIcon(size: 26, opacity: 0.12),
                ),
                Positioned(
                  bottom: 80,
                  right: 90,
                  child: _DiceIcon(size: 20, opacity: 0.10),
                ),

                // Tarjeta principal
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Título
                        const Text(
                          'MoodTasker',
                          style: TextStyle(
                            color: green,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Logo de rayo dentro del recuadro verde
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: green.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.bolt, color: green, size: 40),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          '👋 Bienvenido a MoodTasker',
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Planea según tu energía, no contra ella ;)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 28),

                        // Nombre de usuario
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Nombre de usuario',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: green,
                                width: 1.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Selecciona tus cursos iniciales',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Lista de cursos
                        ..._courses.map((c) => _CourseCheckbox(title: c)),

                        // Agregar curso
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _showAddCourseDialog,
                            icon: const Icon(Icons.add, color: green),
                            label: const Text(
                              'Agregar curso',
                              style: TextStyle(
                                color: green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Botón COMENZAR
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/home',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'COMENZAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- COMPONENTES AUXILIARES ---

class _CourseCheckbox extends StatefulWidget {
  final String title;
  const _CourseCheckbox({required this.title});

  @override
  State<_CourseCheckbox> createState() => _CourseCheckboxState();
}

class _CourseCheckboxState extends State<_CourseCheckbox> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CAF50);
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.title),
      value: checked,
      onChanged: (v) => setState(() => checked = v ?? false),
      activeColor: green,
    );
  }
}

class _DiceIcon extends StatelessWidget {
  final double size;
  final double opacity;
  const _DiceIcon({required this.size, this.opacity = 0.1});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.circle, size: 10, color: Colors.white),
      ),
    );
  }
}
