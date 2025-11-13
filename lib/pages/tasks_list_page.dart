import 'package:flutter/material.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  static const green = Color(0xFF4CAF50);

  // Datos “estáticos” iniciales (se pueden mutar en memoria para la demo)
  final Map<String, List<_TaskItem>> tasksByCourse = {
    'Programación Web': [
      _TaskItem(title: 'Ensayo de redes sociales', due: '12/09', urgent: true),
      _TaskItem(title: 'Proyecto final', due: '25/09', urgent: false),
    ],
    'Historia': [
      _TaskItem(title: 'Escribir resumen de clase', due: null, urgent: false),
    ],
  };

  /// Cursos que están en modo edición (se muestran casillas)
  final Set<String> _editingCourses = {};

  /// Tareas seleccionadas para borrar por curso (índices)
  final Map<String, Set<int>> _selectedForDelete = {};

  bool get _isEditingAny => _editingCourses.isNotEmpty;
  int get _totalSelected =>
      _selectedForDelete.values.fold<int>(0, (acc, s) => acc + s.length);
  bool get _canFinalize => _totalSelected > 0;

  void _toggleEditCourse(String course) {
    setState(() {
      if (_editingCourses.contains(course)) {
        _editingCourses.remove(course);
        _selectedForDelete.remove(course);
      } else {
        _editingCourses.add(course);
        _selectedForDelete.putIfAbsent(course, () => <int>{});
      }
    });
  }

  void _toggleSelect(String course, int index) {
    if (!_editingCourses.contains(course)) return;
    setState(() {
      final set = _selectedForDelete.putIfAbsent(course, () => <int>{});
      if (set.contains(index)) {
        set.remove(index);
      } else {
        set.add(index);
      }
    });
  }

  void _finalizeDeletion() {
    setState(() {
      for (final course in _editingCourses.toList()) {
        final list = tasksByCourse[course]!;
        final set = _selectedForDelete[course] ?? <int>{};
        // eliminar por índices de mayor a menor
        final sorted = set.toList()..sort((a, b) => b.compareTo(a));
        for (final i in sorted) {
          if (i >= 0 && i < list.length) list.removeAt(i);
        }
      }
      _editingCourses.clear();
      _selectedForDelete.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tareas eliminadas')));
  }

  void _cancelEditing() {
    setState(() {
      _editingCourses.clear();
      _selectedForDelete.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              // Encabezado: logo + "Mis tareas"
              Row(
                children: const [
                  _HeaderLogo(),
                  SizedBox(width: 8),
                  Text(
                    'Mis tareas',
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Lista
              Expanded(
                child: ListView(
                  children: [
                    ...tasksByCourse.entries.map((e) {
                      final course = e.key;
                      final tasks = e.value;
                      final editing = _editingCourses.contains(course);
                      final selected =
                          _selectedForDelete[course] ?? const <int>{};

                      return _CourseCard(
                        course: course,
                        tasks: tasks,
                        editing: editing,
                        selectedCount: selected.length,
                        selectedIndices: selected,
                        onTapEdit: () => _toggleEditCourse(course),
                        onToggleSelect: (i) => _toggleSelect(course, i),
                      );
                    }),
                    const SizedBox(height: 80),
                  ],
                ),
              ),

              // Acciones inferiores (solo si hay algún curso en edición)
              if (_isEditingAny) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: _canFinalize ? _finalizeDeletion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      _canFinalize
                          ? 'FINALIZAR (${_totalSelected})'
                          : 'FINALIZAR',
                      style: TextStyle(
                        color: _canFinalize ? Colors.white : Colors.black38,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _cancelEditing,
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),

      // FAB "+" → Nueva tarea (oculto si está editando)
      floatingActionButton: _isEditingAny
          ? null
          : FloatingActionButton(
              backgroundColor: green,
              shape: const CircleBorder(),
              onPressed: () => Navigator.pushNamed(context, '/newtask'),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ---------- Widgets auxiliares ----------

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo();

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CAF50);
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(Icons.check_box_rounded, color: green, size: 22),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String course;
  final List<_TaskItem> tasks;
  final bool editing;
  final Set<int> selectedIndices;
  final VoidCallback onTapEdit;
  final void Function(int index) onToggleSelect;
  final int selectedCount;

  const _CourseCard({
    required this.course,
    required this.tasks,
    required this.editing,
    required this.selectedIndices,
    required this.onTapEdit,
    required this.onToggleSelect,
    required this.selectedCount,
  });

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: border,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera del curso
            Row(
              children: [
                Text(
                  course,
                  style: const TextStyle(
                    color: Color(0xFF3F7CD7),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),

                if (editing && selectedCount > 0) // ← NUEVO
                  _CountBadge(count: selectedCount), // ← NUEVO

                TextButton(
                  onPressed: onTapEdit,
                  child: Text(editing ? 'Done' : 'Edit'),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Tareas
            ...List.generate(tasks.length, (i) {
              final t = tasks[i];
              final red = t.urgent ? Colors.red : const Color(0xFF3F7CD7);
              final selected = selectedIndices.contains(i);

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        t.urgent
                            ? Icons.event_rounded
                            : Icons.event_available_rounded,
                        color: red,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (t.due != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  'Entrega: ${t.due}',
                                  style: TextStyle(
                                    color: t.urgent
                                        ? Colors.red
                                        : Colors.black54,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // -------- Selector de borrado (solo en edición) --------
                      if (editing)
                        GestureDetector(
                          onTap: () => onToggleSelect(i),
                          child: _DeleteTick(selected: selected),
                        ),
                    ],
                  ),
                  if (i != tasks.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Casilla estilo “borrar”: gris vacío → rojo con ícono “–”
class _DeleteTick extends StatelessWidget {
  final bool selected;
  const _DeleteTick({required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: selected ? Colors.red : Colors.black26,
          width: 1.2,
        ),
        boxShadow: selected
            ? [BoxShadow(color: Colors.red.withOpacity(0.25), blurRadius: 6)]
            : null,
      ),
      child: Icon(
        selected ? Icons.remove_rounded : Icons.crop_square_rounded,
        color: selected ? Colors.white : Colors.transparent,
        size: 18,
      ),
    );
  }
}

class _TaskItem {
  final String title;
  final String? due;
  final bool urgent;
  final bool done;
  const _TaskItem({
    required this.title,
    this.due,
    required this.urgent,
    this.done = false,
  });
}
