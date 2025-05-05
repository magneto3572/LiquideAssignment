import 'package:flutter/material.dart';

class DraggableFAB extends StatefulWidget {
  final VoidCallback onBuy;
  final VoidCallback onSell;

  const DraggableFAB({
    super.key,
    required this.onBuy,
    required this.onSell,
  });

  @override
  State<DraggableFAB> createState() => _DraggableFABState();
}

class _DraggableFABState extends State<DraggableFAB>
    with SingleTickerProviderStateMixin {
  Offset _offset = const Offset(0, 0);
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _expandAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Stack(
      children: [
        Positioned(
          right: 16 + _offset.dx,
          bottom: 16 + _offset.dy,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Buy button
              ScaleTransition(
                scale: _expandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Buy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton.small(
                        backgroundColor: Colors.green,
                        heroTag: 'buy_fab',
                        onPressed: () {
                          _toggleExpand();
                          widget.onBuy();
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
              // Sell button
              ScaleTransition(
                scale: _expandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Sell',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton.small(
                        backgroundColor: Colors.red,
                        heroTag: 'sell_fab',
                        onPressed: () {
                          _toggleExpand();
                          widget.onSell();
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ),
              // Main FAB
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    final newOffsetX = _offset.dx - details.delta.dx;
                    final newOffsetY = _offset.dy - details.delta.dy;

                    // Limit the FAB to stay within screen bounds
                    // for x cordinates
                    if (newOffsetX > -16 && newOffsetX < screenWidth - 100) {
                      _offset = Offset(newOffsetX, _offset.dy);
                    }

                    // For Y cordinates
                    if (newOffsetY > -16 &&
                        newOffsetY + 150 < screenHeight - 100) {
                      _offset = Offset(_offset.dx, newOffsetY);
                    }
                  });
                },
                child: FloatingActionButton(
                  heroTag: 'main_fab',
                  backgroundColor: _isExpanded ? Colors.grey : Colors.blue,
                  onPressed: _toggleExpand,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _expandAnimation,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}