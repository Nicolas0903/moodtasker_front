import 'package:flutter/material.dart';

class MoodCheckPage extends StatefulWidget {
  const MoodCheckPage({super.key});

  @override
  State<MoodCheckPage> createState() => _MoodCheckPageState();
}

class _MoodCheckPageState extends State<MoodCheckPage> {
  // 0 = triste, 1 = normal, 2 = feliz
  int _mood = 1;
  double _energy = 50;

  static const green = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    '¿Cómo te sientes hoy?',
                    style: TextStyle(
                      color: green,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Emojis (3 estados)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _MoodIcon(
                        selected: _mood == 0,
                        icon: Icons.sentiment_dissatisfied_rounded,
                        onTap: () => setState(() => _mood = 0),
                      ),
                      _MoodIcon(
                        selected: _mood == 1,
                        icon: Icons.sentiment_satisfied_alt_rounded,
                        onTap: () => setState(() => _mood = 1),
                      ),
                      _MoodIcon(
                        selected: _mood == 2,
                        icon: Icons.sentiment_very_satisfied_rounded,
                        onTap: () => setState(() => _mood = 2),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Card con slider (auto -> rayo)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.directions_car_filled_rounded,
                              color: Colors.black54,
                            ),
                            Spacer(),
                            Icon(Icons.bolt_rounded, color: green),
                          ],
                        ),
                        Slider(
                          value: _energy,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          activeColor: green,
                          inactiveColor: const Color(0xFFCCE8CC),
                          onChanged: (v) => setState(() => _energy = v),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),
                  const Text(
                    'Tu ánimo importa para planear tus tareas.',
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),

                  // Botón principal
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: aquí puedes navegar a una pantalla de recomendaciones
                        // o devolver los valores al Home con Navigator.pop(context, {...})
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Generando recomendaciones…'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Ver recomendaciones',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodIcon extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;
  const _MoodIcon({
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CAF50);
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: selected ? green.withOpacity(0.12) : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: selected ? green : Colors.black26),
        ),
        child: Icon(icon, color: selected ? green : Colors.black54),
      ),
    );
  }
}
