/// An abstract class representing a use case in the application.
///
/// A use case encapsulates a specific piece of functionality or business logic
/// and provides a method to execute it with given parameters.
abstract class UseCase<Type, Params> {
  /// Executes the use case with the given [params] and returns a [Future] of type [Type].
  ///
  /// [params]: The parameters required to execute the use case.
  Future<Type> call({Params params});
}
