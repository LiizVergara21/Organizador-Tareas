class Tarea {
  final int id;
  final String nombre;
  final DateTime? fechaEntrega;
  DateTime? fechaCalificacion;
  bool esRealizado;

  Tarea({
    required this.id,
    required this.nombre,
    this.fechaEntrega,
    this.fechaCalificacion,
    this.esRealizado = false,
  });
}
