import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreNotifier extends StateNotifier<List<int>> {
  ScoreNotifier() : super([]);

  addnumber(int newValue) {
    final data = state;
    data.add(newValue);
    state = data;
  }

  deleteList(int newValue) {
    state = [];
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, List<int>>((ref) {
  return ScoreNotifier();
});
