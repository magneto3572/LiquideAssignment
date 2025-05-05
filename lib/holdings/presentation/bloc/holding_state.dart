import 'package:equatable/equatable.dart';
import '../../../../holdings/domain/models/holding.dart';

abstract class HoldingsState extends Equatable {
  const HoldingsState();

  @override
  List<Object?> get props => [];
}

class HoldingsInitial extends HoldingsState {
  const HoldingsInitial();
}

class HoldingsLoading extends HoldingsState {
  const HoldingsLoading();
}

class HoldingsLoaded extends HoldingsState {
  final List<Holding> holdings;

  const HoldingsLoaded(this.holdings);

  @override
  List<Object?> get props => [holdings];
}

class HoldingsError extends HoldingsState {
  final String message;

  const HoldingsError(this.message);

  @override
  List<Object?> get props => [message];
}