class Producto {
  final String id;
  final String codigo;
  final String producto;
  final String idCategoria;
  final String existencia;

  Producto({
    required this.id,
    required this.codigo,
    required this.producto,
    required this.idCategoria,
    required this.existencia,
  });
    Map toJson() => {
        'id': id,
        'codigo': codigo,
        'producto': producto,
        'idcategoria': idCategoria,
        'existencia': existencia,
      };
}
