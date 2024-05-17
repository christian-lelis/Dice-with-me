import 'package:flutter_riverpod/flutter_riverpod.dart';

class DicesNotifier extends StateNotifier<String> {
  DicesNotifier() : super('dice');

  changeDice(String dice) {
    state = dice;
    return;
  }
}

final dicesProvider =
    StateNotifierProvider<DicesNotifier, String>((ref) => DicesNotifier());
