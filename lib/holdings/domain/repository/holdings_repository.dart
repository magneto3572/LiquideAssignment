import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../models/holding.dart';

abstract class HoldingsRepository {
  Future<Either<Failure, List<Holding>>> getHoldings();
}