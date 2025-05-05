import 'dart:math';

import '../../domain/model/broker_model.dart';
import '../../domain/model/user_model.dart';



abstract class LoginRemoteDataSource {
  /// Gets a list of brokers
  /// Throws a ServerException for all error codes
  Future<List<BrokerModel>> getBrokers();

  /// Performs a login with the given credentials
  /// Throws a ServerException for all error codes
  Future<UserModel> login({
    required String brokerId,
    required String username,
    required String password,
  });
}

class RemoteDataSourceImpl implements LoginRemoteDataSource {
  // Mock brokers data
  final List<BrokerModel> _brokers = [
    const BrokerModel(
        id: '1', name: 'Zerodha', logo: 'assets/images/zerodha_logo.png'),
    const BrokerModel(
        id: '2', name: 'Upstox', logo: 'assets/images/upstox_logo.png'),
    const BrokerModel(
        id: '3', name: 'Groww', logo: 'assets/images/groww_logo.png'),
    const BrokerModel(
        id: '4', name: 'Angel One', logo: 'assets/images/angel_logo.png'),
    const BrokerModel(
        id: '5', name: 'ICICI Direct', logo: 'assets/images/icici_logo.png'),
  ];

  @override
  Future<List<BrokerModel>> getBrokers() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay
    return _brokers;
  }

  @override
  Future<UserModel> login({
    required String brokerId,
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // For demo, always return successful login
    return UserModel(
      id: 'user_${Random().nextInt(1000)}',
      name: username,
      brokerId: brokerId,
      token: 'mock_token_${DateTime
          .now()
          .millisecondsSinceEpoch}',
    );
  }
}