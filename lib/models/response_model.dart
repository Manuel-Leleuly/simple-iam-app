class Paging {
  final String next;
  final String prev;

  const Paging({
    required this.next,
    required this.prev,
  });

  factory Paging.fromJson(Map<String, dynamic> jsonData) {
    return Paging(
      next: jsonData['next'],
      prev: jsonData['prev'],
    );
  }
}

class Response<T> {
  final T data;

  const Response({required this.data});
}

class WithPagination<T> {
  final T data;
  final Paging paging;

  const WithPagination({
    required this.data,
    required this.paging,
  });
}
