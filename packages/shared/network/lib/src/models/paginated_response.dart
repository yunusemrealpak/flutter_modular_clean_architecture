/// Generic paginated response wrapper
class PaginatedResponse<T> {
  /// The list of items in the current page
  final List<T> items;

  /// Current page number
  final int currentPage;

  /// Total number of pages
  final int totalPages;

  /// Total number of items
  final int totalItems;

  /// Number of items per page
  final int pageSize;

  /// Whether there's a next page
  final bool hasNextPage;

  /// Whether there's a previous page
  final bool hasPreviousPage;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.pageSize,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  /// Factory constructor from JSON
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final items = (json['items'] as List<dynamic>?)
            ?.map((item) => fromJsonT(item as Map<String, dynamic>))
            .toList() ??
        [];

    final currentPage = json['currentPage'] as int? ?? json['page'] as int? ?? 1;
    final totalPages = json['totalPages'] as int? ?? json['pages'] as int? ?? 1;
    final totalItems = json['totalItems'] as int? ?? json['total'] as int? ?? 0;
    final pageSize = json['pageSize'] as int? ?? json['limit'] as int? ?? items.length;

    return PaginatedResponse(
      items: items,
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      pageSize: pageSize,
      hasNextPage: currentPage < totalPages,
      hasPreviousPage: currentPage > 1,
    );
  }

  /// Converts the response to JSON
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'items': items.map((item) => toJsonT(item)).toList(),
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'pageSize': pageSize,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }

  /// Creates a copy with modified fields
  PaginatedResponse<T> copyWith({
    List<T>? items,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    int? pageSize,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return PaginatedResponse(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      pageSize: pageSize ?? this.pageSize,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }

  @override
  String toString() {
    return 'PaginatedResponse(items: ${items.length}, currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems)';
  }
}
