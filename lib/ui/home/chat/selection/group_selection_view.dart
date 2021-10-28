import 'package:flutter/material.dart';

class GruopSelectionView extends StatelessWidget {
  const GruopSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Verify your identity'),
            const Placeholder(
              fallbackHeight: 100,
              fallbackWidth: 100,
            ),
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () {},
            ),
            const TextField(
              decoration: InputDecoration(hintText: 'Name of the group'),
            ),
            Wrap(
              children: List.generate(
                5,
                (index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(),
                    Text('index $index'),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
