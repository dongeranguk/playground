import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WriteMailScreen extends StatefulWidget {
  const WriteMailScreen({super.key});

  @override
  State<WriteMailScreen> createState() => _WriteMailScreenState();
}

class _WriteMailScreenState extends State<WriteMailScreen> {
  // final TextEditingController controller1 = TextEditingController();
  // final TextEditingController controller2 = TextEditingController();
  // final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: const Icon(CupertinoIcons.arrow_right_arrow_left),
            // TODO : 아이콘 옆에 기능을 설명하는 라벨 문자열 넣기
            onPressed: () {}),
        const Icon(CupertinoIcons.paperplane),
      ]),
      body: const Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: '받는 사람'),
          ),
          TextField(
            decoration: InputDecoration(labelText: '제목'),
          ),
          TextField(
            maxLength: 4000,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}
