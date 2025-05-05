import 'package:equatable/equatable.dart';

abstract class PositionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPositionsEvent extends PositionsEvent {
  GetPositionsEvent();
}