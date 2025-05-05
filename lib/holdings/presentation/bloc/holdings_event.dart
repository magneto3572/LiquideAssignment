import 'package:equatable/equatable.dart';

abstract class HoldingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetHoldingsEvent extends HoldingsEvent {}
