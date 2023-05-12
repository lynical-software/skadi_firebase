import 'package:future_manager/future_manager.dart';

class FirebasePagination<T> {
  final FutureManager<List<T>> manager;
  final int limit;
  FirebasePagination({required this.manager, required this.limit});

  ///
  T? _lastDoc;
  T? get lastDoc => _lastDoc;

  ///
  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  void reset() {
    _lastDoc = null;
    _hasMoreData = true;
  }

  List<T> handle(List<T> response) {
    _hasMoreData = response.length >= limit;
    List<T> oldData = [];
    if (_lastDoc != null) {
      oldData = [...(manager.data ?? [])];
    }
    if (response.isNotEmpty) {
      _lastDoc = response.last;
    }
    return [...oldData, ...response];
  }
}
