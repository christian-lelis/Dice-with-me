import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'background_container.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: BackgroundContainer(
            [
              Color(0xFF9C27B0),
              Color(0xFFE91E63),
              Color(0xFFFF9800),
            ],
          ),
        ),
      ),
    ),
  );
}
