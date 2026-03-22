import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/watchlist_bloc.dart';
import 'ui/widgets/stock_tile.dart';

void main() => runApp(const MyStockApp());

class MyStockApp extends StatelessWidget {
  const MyStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: BlocProvider(
        create: (context) => WatchlistBloc()..add(LoadWatchlist()),
        child: const WatchlistScreen(),
      ),
    );
  }
}

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist')),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }
          if (state is WatchlistLoaded) {
            return ReorderableListView.builder(
              itemCount: state.stocks.length,
              onReorder: (oldIdx, newIdx) {
                context.read<WatchlistBloc>().add(ReorderStock(oldIdx, newIdx));
              },
              itemBuilder: (context, index) {
                final stock = state.stocks[index];
                return StockTile(
                  key: ValueKey(stock.id),
                  stock: stock,
                  index: index,
                );
              },
            );
          }
          return const Center(
            child: Text(
              'Failed to load watchlist',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
