import 'package:equatable/equatable.dart';
import '../../domain/models/position.dart';

abstract class PositionsState extends Equatable {
  const PositionsState();

  @override
  List<Object?> get props => [];
}

class PositionsInitial extends PositionsState {
  const PositionsInitial();
}

class PositionsLoading extends PositionsState {
  const PositionsLoading();
}

class PositionsLoaded extends PositionsState {
  final List<Position> positions;

  const PositionsLoaded(this.positions);

  @override
  List<Object?> get props => [positions];
}

class PositionsError extends PositionsState {
  final String message;

  const PositionsError(this.message);

  @override
  List<Object?> get props => [message];
}