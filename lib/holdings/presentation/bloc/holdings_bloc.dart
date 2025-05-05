import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquide_assignment/holdings/presentation/bloc/holdings_event.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain/usecase/get_holdings.dart';
import 'holding_state.dart';

class HoldingsBloc extends Bloc<HoldingsEvent, HoldingsState> {
  final GetHoldings getHoldings;
  
  HoldingsBloc({
    required this.getHoldings,
}) : super(const HoldingsInitial()){
  on<GetHoldingsEvent>(_onGetHoldingsEvent);
}

  Future<void> _onGetHoldingsEvent(
    GetHoldingsEvent event,
    Emitter<HoldingsState> emit,
  ) async {
    emit(const HoldingsLoading());
    final result = await getHoldings(NoParams());
    result.fold(
      (failure) => emit(HoldingsError(failure.toString())),
      (holdings) => emit(HoldingsLoaded(holdings)),
    );
  }
}