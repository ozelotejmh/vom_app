import 'package:flutter/material.dart';

class VomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const VomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.asset(
                'assets/palomita_blanca.png',
                height: 80,
                fit: BoxFit.contain,
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(color: Colors.white, width: 3))),
            child: Text(
              title,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160.0);
}
