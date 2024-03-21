import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/screen/main/tab/calendar/fab/w_floating_calendar_button.riverpod.dart';

import '../f_calendar.dart';

class CalendarFAB extends ConsumerStatefulWidget {
  const CalendarFAB({super.key});

  @override
  ConsumerState<CalendarFAB> createState() => _CalendarFABState();
}

class _CalendarFABState extends ConsumerState<CalendarFAB> {
  final TextEditingController _textEditingController = TextEditingController();
  late DateTime _from;
  late DateTime _to;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedDay = ref.watch(floatingButtonSelectedDayProvider);

    if(_selectedDay != null) {
      _from = _selectedDay;
      // ref.read(floatingButtonToProvider.notifier).state = _from.add(const Duration(days: 1));
    } else {
      _from = ref.watch(floatingButtonFromProvider);
      _to = ref.watch(floatingButtonToProvider);
    }


    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child:
                              const Text('취소', style: TextStyle(fontSize: 17)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text('새로운 이벤트',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        TextButton(
                          child: const Text(
                            '추가',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {},
                        ),
                      ]),
                  const SizedBox(height: 15),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: TextField(
                              decoration: const InputDecoration(
                                  hintText: '제목', border: InputBorder.none),
                              style: const TextStyle(fontSize: 15),
                              controller: _textEditingController,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 30),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                const Text('시작'),
                                const Spacer(),
                                CupertinoButton(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey.shade200),
                                        child: Text(_from.formattedDotYMD)),
                                    onPressed: () => showDialog(
                                        CupertinoDatePicker(
                                            initialDateTime: _from,
                                            minimumYear: DateTime.now().year,
                                            maximumYear:
                                                DateTime.now().year + 3,
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged:
                                                (DateTime newDate) {
                                              setState(() {
                                                _from = newDate;
                                                ref.read(floatingButtonFromProvider.notifier).state = _from;
                                              });
                                            }))),
                                CupertinoButton(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey.shade200),
                                        child: Text(_from.formattedHm)),
                                    onPressed: () => showDialog(
                                        CupertinoDatePicker(
                                            use24hFormat: false,
                                            initialDateTime: _from,
                                            mode: CupertinoDatePickerMode.time,
                                            minuteInterval: 10,
                                            onDateTimeChanged:
                                                (DateTime newDate) =>
                                                    setState(() {
                                                      _from = newDate;
                                                      ref.read(floatingButtonFromProvider.notifier).state = _from;
                                                    })))),
                              ],
                            ),
                          ),
                          const Line(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                const Text('종료'),
                                const Spacer(),
                                CupertinoButton(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey.shade200),
                                        child: Text(_to.formattedDotYMD)),
                                    onPressed: () => showDialog(
                                        CupertinoDatePicker(
                                            initialDateTime: _to,
                                            minimumYear: DateTime.now().year,
                                            maximumYear:
                                                DateTime.now().year + 3,
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged:
                                                (DateTime newDate) =>
                                                    setState(() {
                                                      _to = newDate;
                                                      ref.read(floatingButtonToProvider.notifier).state = _to;
                                                    })))),
                                CupertinoButton(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey.shade200),
                                        child: Text(_to.formattedHm)),
                                    onPressed: () => showDialog(
                                        CupertinoDatePicker(
                                            use24hFormat: false,
                                            initialDateTime: _to,
                                            mode: CupertinoDatePickerMode.time,
                                            minuteInterval: 10,
                                            onDateTimeChanged:
                                                (DateTime newDate) =>
                                                    setState(() {
                                                      _to = newDate;
                                                      ref.read(floatingButtonToProvider.notifier).state = _to;
                                                    })))),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          isScrollControlled: true,
        );
      },
      child: const Icon(Icons.add),
    );
  }

  void showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              color: Colors.white,
              height: 200,
              child: child,
            ));
  }
}
