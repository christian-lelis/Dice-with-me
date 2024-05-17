import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomizerNotifier extends StateNotifier<List<int>> {
  RandomizerNotifier() : super([0, 0, 0, 0, 0, 0]);

  randomizer() {
    List<int> newList = [];
    for (var e in state) {
      e = Random().nextInt(6) + 1;
      newList.add(e);
    }
    state = newList;
  }

  deleteList(int newValue) {
    state = [0, 0, 0, 0, 0, 0];
  }
}

final randomizerProvider =
    StateNotifierProvider<RandomizerNotifier, List<int>>((ref) {
  return RandomizerNotifier();
});
