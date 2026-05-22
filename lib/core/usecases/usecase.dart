import 'package:tecnar_tok/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class Either<L, R> {
  final L? _left;
  final R? _right;
  final bool _isLeft;

  Either._(this._left, this._right, this._isLeft);

  factory Either.left(L left) => Either._(left, null, true);
  factory Either.right(R right) => Either._(null, right, false);

  bool get isLeft => _isLeft;
  bool get isRight => !_isLeft;

  T fold<T>(T Function(L left) leftFn, T Function(R right) rightFn) {
    return _isLeft ? leftFn(_left as L) : rightFn(_right as R);
  }
}