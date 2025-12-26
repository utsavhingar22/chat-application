import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Offers',
          style: TextStyle(
            fontSize: 24,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

