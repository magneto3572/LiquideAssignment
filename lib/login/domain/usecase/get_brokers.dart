import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../model/broker.dart';
import '../repository/login_repository.dart';


class GetBrokers implements UseCase<List<Broker>, NoParams> {
  final LoginRepository repository;

  GetBrokers(this.repository);

  @override
  Future<Either<Failure, List<Broker>>> call(NoParams params) async {
    return await repository.getBrokers();
  }
}