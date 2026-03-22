import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/stock.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderStock>(_onReorderStock);
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoading());
    // Sample Data for 021 Trade
    final List<Stock> mockData = [
      const Stock(
        id: '1',
        symbol: 'RELIANCE',
        name: 'Reliance Industries',
        price: 2985.40,
        changePercentage: 1.25,
      ),
      const Stock(
        id: '2',
        symbol: 'TCS',
        name: 'Tata Consultancy Services',
        price: 4120.15,
        changePercentage: -0.85,
      ),
      const Stock(
        id: '3',
        symbol: 'HDFCBANK',
        name: 'HDFC Bank Ltd',
        price: 1450.00,
        changePercentage: 0.45,
      ),
      const Stock(
        id: '4',
        symbol: 'INFY',
        name: 'Infosys Ltd',
        price: 1620.30,
        changePercentage: 2.10,
      ),
      const Stock(
        id: '5',
        symbol: 'Swiggy',
        name: 'Swiggy Ltd',
        price: 185.20,
        changePercentage: -3.40,
      ),
    ];
    emit(WatchlistLoaded(mockData));
  }

  void _onReorderStock(ReorderStock event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final List<Stock> updatedList = List.from(currentState.stocks);

      int newIdx = event.newIndex;
      if (event.oldIndex < newIdx) {
        newIdx -= 1;
      }

      final Stock movedItem = updatedList.removeAt(event.oldIndex);
      updatedList.insert(newIdx, movedItem);

      emit(WatchlistLoaded(updatedList));
    }
  }
}
