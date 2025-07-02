import 'package:flutter/material.dart';

class VomBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const VomBottomAppBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // o el color que uses en tu tema
      elevation: 0,
      child: IconTheme(
        data: const IconThemeData(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 38),
              onPressed: () => onItemTapped(0),
              tooltip: 'Inicio',
              color: selectedIndex == 0
                  ? Theme.of(context).primaryColorDark
                  : Colors.white,
            ),
            IconButton(
              icon: const Icon(
                  IconData(0xf009,
                      fontFamily: 'FontAwesome5', fontPackage: null),
                  size: 30),
              onPressed: () => onItemTapped(1),
              tooltip: 'Municipios',
              color: selectedIndex == 1
                  ? Theme.of(context).primaryColorDark
                  : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
