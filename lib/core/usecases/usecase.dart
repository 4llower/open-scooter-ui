import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
