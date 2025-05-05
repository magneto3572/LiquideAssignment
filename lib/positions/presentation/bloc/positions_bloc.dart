import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain/usecase/get_positions.dart';
import 'positions_event.dart';
import 'positions_state.dart';

class PositionsBloc extends Bloc<PositionsEvent, PositionsState> {
  final GetPositions getPositions;

  PositionsBloc({
    required this.getPositions,
  }) : super(const PositionsInitial()) {
    on<GetPositionsEvent>(_onGetPositionsEvent);
  }

  Future<void> _onGetPositionsEvent(GetPositionsEvent event,
      Emitter<PositionsState> emit,) async {
    emit(const PositionsLoading());
    final result = await getPositions(NoParams());
    result.fold(
          (failure) => emit(PositionsError(failure.toString())),
          (positions) => emit(PositionsLoaded(positions)),
    );
  }
}