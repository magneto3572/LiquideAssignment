import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../models/position.dart';

abstract class PositionRepository {
  Future<Either<Failure, List<Position>>> getPositions();
}