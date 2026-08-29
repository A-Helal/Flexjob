class PaginatedResult<T> {
  const PaginatedResult({required this.items, required this.total});

  final List<T> items;
  final int total;

  bool get hasMore => items.length < total;
}