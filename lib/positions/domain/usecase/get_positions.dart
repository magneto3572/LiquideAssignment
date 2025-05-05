import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../models/position.dart';
import '../repository/position_repository.dart';

class GetPositions implements UseCase<List<Position>, NoParams> {
  final PositionRepository repository;

  GetPositions(this.repository);

  @override
  Future<Either<Failure, List<Position>>> call(NoParams params) {
    return repository.getPositions();
  }
}