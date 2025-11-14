import 'dart:math';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final String course;
  final String taskTitle;
  final String dateText;
  final int stars;

  const TaskDetailPage({
    super.key,
    required this.course,
    required this.taskTitle,
    required this.dateText,
    required this.stars,
  });

  static const green = Color(0xFF4CAF50);

  // Aquí podrías poner varias rutas y escoger una al azar.
  static const List<String> _memes = [
    'assets/images/meme_moodtasker_1.jpg',
    // 'assets/images/meme_moodtasker_2.jpg',
    // 'assets/images/meme_moodtasker_3.jpg',
  ];

  String get randomMeme {
    final rnd = Random();
    return _memes[rnd.nextInt(_memes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final memePath = randomMeme;

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
                  children: [
                    const SizedBox(height: 8),

                    // Título del curso
                    Text(
                      course,
                      style: const TextStyle(
                        color: green,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Tarjeta blanca con la tarea y el meme
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título de la tarea
                          Text(
                            taskTitle,
                            style: const TextStyle(
                              color: Color(0xFF1E88E5),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Fecha + icono
                          Row(
                            children: [
                              const Icon(
                                Icons.event_rounded,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                dateText,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Estrellitas
                          Row(
                            children: List.generate(
                              stars,
                              (i) => const Icon(
                                Icons.star_rounded,
                                color: green,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Meme motivacional
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                memePath,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Check verde para marcar como realizada
                          Center(
                            child: InkWell(
                              onTap: () {
                                // devolvemos true para indicar "completada"
                                Navigator.pop(context, true);
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: green,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Botón cancelar por si se arrepiente
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
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
      ),
    );
  }
}
