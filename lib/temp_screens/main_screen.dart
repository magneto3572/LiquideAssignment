import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HoldingsTab(),
    const OrderbookTab(),
    const PositionsTab(),
  ];

  final List<String> _titles = ['Holdings', 'Orderbook', 'Positions'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Holdings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orderbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: 'Positions',
          ),
        ],
      )
    );
  }
}

class HoldingsTab extends StatelessWidget {
  const HoldingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Holdings Screen'),
    );
  }
}

class OrderbookTab extends StatelessWidget {
  const OrderbookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Orderbook Screen'),
    );
  }
}

class PositionsTab extends StatelessWidget {
  const PositionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Positions Screen'),
    );
  }
}