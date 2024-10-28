import 'tarea.dart';

class CtrControlTareas {
  final List<Tarea> tareas = [];

  CtrControlTareas() {
    tareas.addAll([
      Tarea(id: 1, nombre: 'Estudiar Flutter', fechaEntrega: DateTime.now().add(Duration(days: 3))),
      Tarea(id: 2, nombre: 'Hacer la tarea de Matemáticas', fechaEntrega: DateTime.now().add(Duration(days: 1))),
      Tarea(id: 3, nombre: 'Leer un libro', fechaEntrega: DateTime.now().add(Duration(days: 7))),
    ]);
  }

  List<Tarea> getTareas() => tareas;

  void marcarComoRealizado(int id) {
    final tarea = tareas.firstWhere((t) => t.id == id);
    tarea.esRealizado = true;
  }

  void marcarComoPendiente(int id) {
    final tarea = tareas.firstWhere((t) => t.id == id);
    tarea.esRealizado = false;
  }

  void agregarTarea(Tarea tarea) => tareas.add(tarea);
}
