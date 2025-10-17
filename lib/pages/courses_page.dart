import 'package:flutter/material.dart';
import '../widgets/course_card.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CURSOS 2025-1',
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
          children: const [
            CourseCard(
              nombre: 'Cálculo 1',
              profesor: 'Nombre del Profesor',
              numero: '01',
              imagePath: 'assets/c1.jpg',
            ),
            CourseCard(
              nombre: 'Programación Web',
              profesor: 'Nombre del Profesor',
              numero: '02',
              imagePath: 'assets/pweb.jpg',
            ),
            CourseCard(
              nombre: 'Historia',
              profesor: 'Nombre del Profesor',
              numero: '03',
              imagePath: 'assets/historia.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
