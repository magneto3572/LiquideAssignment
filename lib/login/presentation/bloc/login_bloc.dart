import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecase/get_brokers.dart';
import '../../domain/usecase/login.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginBaseEvent, LoginState> {
  final Login login;
  final GetBrokers? getBrokers; // Optional for initial implementation

  LoginBloc({
    required this.login,
    this.getBrokers,
  }) : super(LoginInitial()) {
    on<GetBrokersEvent>(_onGetBrokersEvent);
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckLoginStatusEvent>(_onCheckAuthStatusEvent);
  }

  Future<void> _onGetBrokersEvent(GetBrokersEvent event,
      Emitter<LoginState> emit,) async {
    emit(LoginLoading());
    if (getBrokers != null) {
      final result = await getBrokers!(NoParams());
      result.fold(
            (failure) => emit(LoginError(failure.toString())),
            (brokers) => emit(BrokersLoaded(brokers)),
      );
    } else {
      // Mock implementation when getBrokers is not provided
      await Future.delayed(const Duration(milliseconds: 500));
      emit(BrokersLoaded(const [
        // Mock brokers
      ]));
    }
  }

  Future<void> _onLoginEvent(LoginEvent event,
      Emitter<LoginState> emit,) async {
    emit(LoginLoading());
    final result = await login(
      LoginParams(
        brokerId: event.brokerId,
        username: event.username,
        password: event.password,
      ),
    );
    result.fold(
          (failure) => emit(LoginError(failure.toString())),
          (user) => emit(LoginAuthenticated(user)),
    );
  }

  Future<void> _onLogoutEvent(LogoutEvent event,
      Emitter<LoginState> emit,) async {
    emit(LoginLoading());
    emit(LoginUnauthenticated());
  }

  Future<void> _onCheckAuthStatusEvent(CheckLoginStatusEvent event,
      Emitter<LoginState> emit,) async {
    emit(LoginLoading());
    // In a real app, check if there's a cached user
    emit(LoginUnauthenticated());
  }
}