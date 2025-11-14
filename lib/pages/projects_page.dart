import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  static const green = Color(0xFF4CAF50);

  // --------- OPCIÓN 1: Ajustes generales (fáciles) ----------
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  // --------- OPCIÓN 2: Preferencias de planificación ----------
  bool _prioritizeUrgent = true;
  bool _prioritizeShortTasks = false;

  // --------- OPCIÓN 4: Centro de motivación ----------
  bool _showMemes = true;
  String _memeType = 'Gatitos';
  bool _dailyMessages = true;
  bool _motivationalSound = false;

  final List<String> _memeTypes = const [
    'Gatitos',
    'Graciosos',
    'Anime',
    'Inspiracionales',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),

                    // Título principal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.build_rounded, color: green, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Ajustes de MoodTasker',
                          style: TextStyle(
                            color: green,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // --------- Sección 1: Ajustes generales ----------
                    _SettingsSection(
                      title: 'Ajustes generales',
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: const Text('Notificaciones de tareas'),
                            subtitle: const Text(
                              'Recordatorios de entregas y pendientes',
                            ),
                            value: _notificationsEnabled,
                            onChanged: (v) {
                              setState(() => _notificationsEnabled = v);
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Sonido de recordatorios'),
                            subtitle: const Text(
                              'Reproducir un sonido suave al notificar',
                            ),
                            value: _soundEnabled,
                            onChanged: (v) {
                              setState(() => _soundEnabled = v);
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Vibración'),
                            subtitle: const Text(
                              'Vibrar el dispositivo en recordatorios',
                            ),
                            value: _vibrationEnabled,
                            onChanged: (v) {
                              setState(() => _vibrationEnabled = v);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --------- Sección 2: Preferencias de planificación ----------
                    _SettingsSection(
                      title: 'Preferencias de planificación',
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: const Text('Priorizar tareas urgentes'),
                            subtitle: const Text(
                              'Mostrar primero tareas con fecha cercana',
                            ),
                            value: _prioritizeUrgent,
                            onChanged: (v) {
                              setState(() => _prioritizeUrgent = v);
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Priorizar tareas cortas'),
                            subtitle: const Text(
                              'Recomendar tareas rápidas cuando tienes poca energía',
                            ),
                            value: _prioritizeShortTasks,
                            onChanged: (v) {
                              setState(() => _prioritizeShortTasks = v);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --------- Sección 3: Centro de motivación ----------
                    _SettingsSection(
                      title: 'Centro de motivación',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwitchListTile(
                            title: const Text('Mostrar memes motivacionales'),
                            subtitle: const Text(
                              'En la pantalla de marcar tarea como realizada',
                            ),
                            value: _showMemes,
                            onChanged: (v) {
                              setState(() => _showMemes = v);
                            },
                          ),

                          const SizedBox(height: 4),
                          const Text(
                            'Tipo de memes',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _memeType,
                                items: _memeTypes
                                    .map(
                                      (t) => DropdownMenuItem(
                                        value: t,
                                        child: Text(t),
                                      ),
                                    )
                                    .toList(),
                                onChanged: _showMemes
                                    ? (value) {
                                        if (value == null) return;
                                        setState(() => _memeType = value);
                                      }
                                    : null,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: const Text(
                              'Mensajes motivacionales diarios',
                            ),
                            subtitle: const Text(
                              'Pequeños mensajes para animarte en tus estudios',
                            ),
                            value: _dailyMessages,
                            onChanged: (v) {
                              setState(() => _dailyMessages = v);
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Sonido motivacional'),
                            subtitle: const Text(
                              'Reproducir un sonido especial al completar tareas',
                            ),
                            value: _motivationalSound,
                            onChanged: (v) {
                              setState(() => _motivationalSound = v);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Texto mini
                    const Center(
                      child: Text(
                        'El equipo desarrollador de MoodTasker te agredece el apoyo <3.',
                        style: TextStyle(color: Colors.black45, fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Widget auxiliar de sección con tarjeta ----------

class _SettingsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF4CAF50),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Divider(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
