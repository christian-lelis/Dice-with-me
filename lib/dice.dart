import 'package:dice_with_me/dices_provider.dart';
import 'package:flutter/material.dart';
import 'package:dice_with_me/score_list.dart';
import 'package:dice_with_me/db_provider.dart';
import 'package:dice_with_me/app_settings.dart';
import 'package:dice_with_me/randomizer_list.dart';
import 'package:dice_with_me/criation_db_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dice extends ConsumerStatefulWidget {
  const Dice({super.key});
  @override
  ConsumerState<Dice> createState() {
    return _DiceState();
  }
}

class _DiceState extends ConsumerState<Dice> {
  @override
  Widget build(context) {
    final ScrollController _scrollController = ScrollController();
    List<Widget> lista = [];

    int counter = ref.watch(dbProvider).isEmpty
        ? 1
        : ref.watch(dbProvider).first['diceAmount'] as int;
    List<int> randomList = ref.watch(randomizerProvider);
    rollDice() {
      ref.read(randomizerProvider.notifier).randomizer();
      final aux = ref.read(randomizerProvider);
      ref.read(scoreProvider.notifier).addnumber(
            counter == 1
                ? aux[0]
                : counter == 2
                    ? aux[0] + aux[1]
                    : counter == 3
                        ? aux[0] + aux[1] + aux[2]
                        : counter == 4
                            ? aux[0] + aux[1] + aux[2] + aux[3]
                            : counter == 5
                                ? aux[0] + aux[1] + aux[2] + aux[3] + aux[4]
                                : aux[0] +
                                    aux[1] +
                                    aux[2] +
                                    aux[3] +
                                    aux[4] +
                                    aux[5],
          );
      if (lista.length > 5) {
        _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent + 70);
      }
    }

    List<Widget> diceListe = [];
    final dice = ref.watch(dicesProvider);
    List<Widget> setDice(int counter) => switch (counter) {
          1 => diceListe = [
              Image.asset('assets/images/$dice-${randomList[0]}.png',
                  width: AppSettings.width * .4)
            ],

          //
          2 => diceListe = [
              Image.asset('assets/images/$dice-${randomList[0]}.png',
                  width: AppSettings.width * .3),
              Image.asset('assets/images/$dice-${randomList[1]}.png',
                  width: AppSettings.width * .3)
            ],

          //
          3 => diceListe = [
              Image.asset('assets/images/$dice-${randomList[0]}.png',
                  width: AppSettings.width * .23),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[1]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[3]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
            ],

          //
          4 => diceListe = [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[0]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[1]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[2]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[3]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
            ],

          //
          5 => diceListe = [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[0]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[1]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
              Image.asset('assets/images/$dice-${randomList[2]}.png',
                  width: AppSettings.width * .23),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[3]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[4]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
            ],

          //
          6 => diceListe = [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[0]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[1]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[2]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[3]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/$dice-${randomList[4]}.png',
                      width: AppSettings.width * .23),
                  Image.asset('assets/images/$dice-${randomList[5]}.png',
                      width: AppSettings.width * .23)
                ],
              ),
            ],
          _ => [], //Valor padrão, substitui o default
        };

    plusCounter() async {
      if (counter > 0 && counter < 6) {
        final db = await ref.read(initdbProvider.notifier).initDatabase();
        ref.read(dbProvider.notifier).setcounter(db, counter + 1);
      }
    }

    lessCounter() async {
      if (counter > 1) {
        final db = await ref.read(initdbProvider.notifier).initDatabase();
        ref.read(dbProvider.notifier).setcounter(db, counter - 1);
      }
    }

    AppSettings.height = MediaQuery.of(context).size.height;
    AppSettings.width = MediaQuery.of(context).size.height;

    setDice(counter);

    for (var i = 0; i < ref.watch(scoreProvider).length; i++) {
      lista.add(
        Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1.1,
            child: Card(
              margin: EdgeInsets.zero,
              color:
                  i.isEven ? const Color(0xfff12c4c) : const Color(0xFF0f1923),
              child: Center(
                child: Text(
                  ref.read(scoreProvider)[i].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          if (ref.read(scoreProvider).isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView(
                  controller: _scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.horizontal,
                  children: lista),
            ),

          //

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: lessCounter,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shadowColor: Colors.transparent,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Icon(Icons.expand_more_rounded, size: 30)),
              const SizedBox(width: 10),
              Text(
                counter.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: plusCounter,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shadowColor: Colors.transparent,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Icon(Icons.expand_less_rounded, size: 30))
            ],
          ),

          //
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: diceListe)),
          //

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 70),
                SizedBox(
                  height: AppSettings.height * .08,
                  child: ElevatedButton(
                    onPressed: rollDice,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
                      foregroundColor: const Color.fromRGBO(0, 0, 0, 0.45),
                      shadowColor: Colors.transparent,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child:
                        const Text('Rodar dado', textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: const Color.fromRGBO(0, 0, 0, 0.1),
                    decoration: const InputDecoration(border: InputBorder.none),
                    elevation: 0,
                    iconSize: 35,
                    icon: Image.asset(
                      'assets/images/dice-icon.png',
                      color: const Color.fromARGB(88, 0, 0, 0),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'dice',
                        child: Image.asset('assets/images/dice-0.png'),
                      ),
                      DropdownMenuItem(
                        value: 'imob',
                        child: Image.asset('assets/images/imob-0.png'),
                      ),
                      DropdownMenuItem(
                        value: 'mono',
                        child: Image.asset('assets/images/mono-0.png'),
                      ),
                      DropdownMenuItem(
                        value: 'gcos',
                        child: Image.asset('assets/images/gcos-0.png'),
                      )
                    ],
                    onChanged: (e) {
                      ref.read(dicesProvider.notifier).changeDice(e ?? 'dice');
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
