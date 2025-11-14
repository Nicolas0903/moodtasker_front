import 'package:flutter/material.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  static const Color _green = Color(0xFF4CAF50);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: icono y título
                    Row(
                      children: const [
                        _HeaderIcon(),
                        SizedBox(width: 8),
                        Text(
                          'Tus recomendaciones',
                          style: TextStyle(
                            color: _green,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Marco verde con las tarjetas dentro
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(
                          18,
                        ), // ← más redondo
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                        ), // ← bordecito gris
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.03,
                            ), // ← sombra más suave
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: const [
                          _RecommendationCard(
                            course: 'Historia',
                            task: 'Escribir resumen de clase',
                            dateText: 'Entrega: No estimada',
                            dateColor: Colors.black54,
                            icon: Icons.psychology_alt_rounded,
                            iconColor: Colors.grey,
                            stars: 1,
                          ),
                          SizedBox(height: 8),
                          _RecommendationCard(
                            course: 'Programación Web',
                            task: 'Ensayo de redes sociales',
                            dateText: 'Entrega: 25/09',
                            dateColor: Colors.red,
                            icon: Icons.event_rounded,
                            iconColor: Colors.red,
                            stars: 3,
                          ),
                          SizedBox(height: 8),
                          _RecommendationCard(
                            course: 'Programación Web',
                            task: 'Proyecto final',
                            dateText: 'Entrega: 12/09',
                            dateColor: Colors.blue,
                            icon: Icons.event_available_rounded,
                            iconColor: Colors.blue,
                            stars: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Botón volver al final de la página
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) =>
                                false, // elimina TODO lo anterior del stack
                          );
                        },

                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Volver',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                            0xFF4CAF50,
                          ), // verde MoodTasker
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
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

// ---------- widgets auxiliares ----------

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.refresh_rounded,
        color: Color(0xFF4CAF50),
        size: 20,
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final String course;
  final String task;
  final String dateText;
  final Color dateColor;
  final IconData icon;
  final Color iconColor;
  final int stars;

  const _RecommendationCard({
    required this.course,
    required this.task,
    required this.dateText,
    required this.dateColor,
    required this.icon,
    required this.iconColor,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CAF50);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar / imagen
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              image: const DecorationImage(
                image: AssetImage('assets/images/placeholder.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course,
                  style: const TextStyle(
                    color: Color(0xFF3F7CD7),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(task, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(icon, color: dateColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      dateText,
                      style: TextStyle(color: dateColor, fontSize: 12.5),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    stars,
                    (i) =>
                        const Icon(Icons.star_rounded, color: green, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
