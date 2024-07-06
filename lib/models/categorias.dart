class Categoria {
  final String id;
  final String categoria;

  Categoria({
    required this.id,
    required this.categoria,
  });

    Map toJson() => {
        'id': id,
        'categoria': categoria,
      };
}
