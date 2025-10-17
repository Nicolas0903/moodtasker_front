import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String nombre;
  final String profesor;
  final String numero;
  final String imagePath;

  const CourseCard({
    super.key,
    required this.nombre,
    required this.profesor,
    required this.numero,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(profesor),
        trailing: Text(numero, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

