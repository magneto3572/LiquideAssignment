import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../models/holding.dart';
import '../repository/holdings_repository.dart';

class GetHoldings implements UseCase<List<Holding>, NoParams> {
  final HoldingsRepository repository;

  GetHoldings(this.repository);

  @override
  Future<Either<Failure, List<Holding>>> call(NoParams params) {
    return repository.getHoldings();
  }
}