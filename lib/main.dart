import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:liquide_assignment/login/data/source/login_local_data_source.dart';
import 'package:liquide_assignment/login/data/source/login_remote_data_source.dart';
import 'package:liquide_assignment/login/domain/repository/login_repository.dart';
import 'package:liquide_assignment/login/presentation/bloc/login_bloc.dart';
import 'core/network/network_info.dart';
import 'login/data/impl/login_repository_impl.dart';
import 'login/presentation/bloc/login_event.dart';
import 'login/domain/usecase/get_brokers.dart';
import 'login/domain/usecase/login.dart';
import 'holdings/data/source/holdings_remote_data_source.dart';
import 'holdings/data/source/holdings_local_data_source.dart';
import 'holdings/data/impl/holdings_repository_impl.dart';
import 'holdings/domain/repository/holdings_repository.dart';
import 'holdings/domain/usecase/get_holdings.dart';
import 'holdings/presentation/bloc/holdings_bloc.dart';
import 'orderbook/presentation/bloc/orderbook_bloc.dart';
import 'orderbook/domain/usecase/get_orders.dart' as orderbook_get_orders;
import 'orderbook/domain/usecase/place_order.dart' as orderbook_place_order;
import 'orderbook/domain/repository/order_repository.dart';
import 'orderbook/data/impl/order_repository_impl.dart';
import 'orderbook/data/source/orderbook_local_data_source.dart';
import 'orderbook/data/source/orderbook_remote_data_source.dart';
import 'positions/presentation/bloc/positions_bloc.dart';
import 'positions/domain/usecase/get_positions.dart' as positions_get_positions;
import 'positions/domain/repository/position_repository.dart';
import 'positions/data/impl/position_repository_impl.dart';
import 'positions/data/source/positions_local_data_source.dart';
import 'positions/data/source/positions_remote_data_source.dart';
import 'home_page.dart';

final GetIt sl = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDependencies();
  runApp(MyApp());
}

Future<void> _initDependencies() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Auth feature
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => RemoteDataSourceImpl());
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LocalDataSourceImpl());
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetBrokers(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerFactory(() => LoginBloc(getBrokers: sl(), login: sl()));

  // Holdings feature
  sl.registerLazySingleton<HoldingsRemoteDataSource>(
      () => HoldingsRemoteDataSourceImpl());
  sl.registerLazySingleton<HoldingsLocalDataSource>(
      () => HoldingsLocalDataSourceImpl());
  sl.registerLazySingleton<HoldingsRepository>(
    () => HoldingsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetHoldings(sl()));
  sl.registerFactory(() => HoldingsBloc(getHoldings: sl()));

  // Orderbook feature
  sl.registerLazySingleton<OrderbookRemoteDataSource>(
      () => OrderbookRemoteDataSourceImpl());
  sl.registerLazySingleton<OrderbookLocalDataSource>(
      () => OrderbookLocalDataSourceImpl());
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => orderbook_get_orders.GetOrders(sl()));
  sl.registerLazySingleton(() => orderbook_place_order.PlaceOrder(sl()));
  sl.registerFactory(() => OrderbookBloc(
        getOrders: sl(),
        placeOrder: sl(),
      ));

  // Positions feature
  sl.registerLazySingleton<PositionsRemoteDataSource>(
      () => PositionsRemoteDataSourceImpl());
  sl.registerLazySingleton<PositionsLocalDataSource>(
      () => PositionsLocalDataSourceImpl());
  sl.registerLazySingleton<PositionRepository>(
    () => PositionRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => positions_get_positions.GetPositions(sl()));
  sl.registerFactory(() => PositionsBloc(getPositions: sl()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => sl<LoginBloc>()..add(GetBrokersEvent()),
        ),
        BlocProvider<HoldingsBloc>(
          create: (_) => sl<HoldingsBloc>(),
        ),
        BlocProvider<OrderbookBloc>(
          create: (_) => sl<OrderbookBloc>(),
        ),
        BlocProvider<PositionsBloc>(
          create: (_) => sl<PositionsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Liquide',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}