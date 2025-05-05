import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain/usecase/get_orders.dart';
import '../../domain/usecase/place_order.dart';
import 'orderbook_event.dart';
import 'orderbook_state.dart';

class OrderbookBloc extends Bloc<OrderbookEvent, OrderbookState> {
  final GetOrders getOrders;
  final PlaceOrder placeOrder;

  OrderbookBloc({
    required this.getOrders,
    required this.placeOrder,
  }) : super(const OrderbookInitial()) {
    on<GetOrdersEvent>(_onGetOrdersEvent);
    on<PlaceOrderEvent>(_onPlaceOrderEvent);
  }

  Future<void> _onGetOrdersEvent(GetOrdersEvent event,
      Emitter<OrderbookState> emit,) async {
    emit(const OrderbookLoading());
    final result = await getOrders(NoParams());
    result.fold(
      (failure) => emit(OrderbookError(failure.toString())),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> _onPlaceOrderEvent(PlaceOrderEvent event,
      Emitter<OrderbookState> emit,) async {
    emit(const OrderbookLoading());
    final result = await placeOrder(
      PlaceOrderParams(
        symbol: event.symbol,
        type: event.type,
        quantity: event.quantity,
        price: event.price,
      ),
    );
    result.fold(
      (failure) => emit(OrderbookError(failure.toString())),
      (success) => emit(OrderPlaced(success)),
    );
  }
}