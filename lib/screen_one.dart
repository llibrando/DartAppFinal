import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScreenOne extends HookWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Clicker:',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
            Text(
              'Hello,You clicked:${counter.value}',
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (counter.value > 0) {
                      counter.value--;
                    }
                  },
                  child: const Text("Reduce"),
                ),
                OutlinedButton(
                  onPressed: () {
                    counter.value++;
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
