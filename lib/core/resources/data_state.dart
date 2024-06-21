import 'package:dio/dio.dart';

/// A base class representing the state of data.
abstract class DataState<T> {
  /// The data retrieved or null if there was an error.
  final T? data;

  /// The error encountered during the data retrieval or null if successful.
  final DioException? error;

  /// Constructs a [DataState] with optional [data] and [error].
  const DataState({this.data, this.error});
}

/// A class representing a successful data state.
class DataSuccess<T> extends DataState<T> {
  /// Constructs a [DataSuccess] with the given [data].
  const DataSuccess(T data) : super(data: data);
}

/// A class representing a failed data state.
class DataFailed<T> extends DataState<T> {
  /// Constructs a [DataFailed] with the given [error].
  const DataFailed(DioException error) : super(error: error);
}
