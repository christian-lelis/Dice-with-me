import 'package:dice_with_me/app_settings.dart';
import 'package:dice_with_me/criation_db_provider.dart';
import 'package:dice_with_me/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:dice_with_me/dice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackgroundContainer extends ConsumerWidget {
  const BackgroundContainer(this.colorsBg, {super.key});

  final List<Color> colorsBg;

  @override
  Widget build(context, WidgetRef ref) {
    //

    Future<Widget> initDice() async {
      final db = await ref.read(initdbProvider.notifier).initDatabase();

      return FutureBuilder<void>(
        future: Future.wait([ref.read(dbProvider.notifier).getdb(db)]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                width: AppSettings.width,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(strokeWidth: 10));
          } else {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colorsBg,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Dice(),
              ),
            );
          }
        },
      );
    }

    return FutureBuilder<Widget>(
      future: initDice(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            width: AppSettings.width,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(strokeWidth: 10),
          );
        } else {
          return snapshot.data ??
              Container(); // Returning the widget from the Future
        }
      },
    );
  }
}
