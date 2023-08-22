import 'package:flutter/material.dart';

class PHIManage extends StatefulWidget {
  const PHIManage({super.key});

  @override
  State<PHIManage> createState() => _PHIManageState();
}

class _PHIManageState extends State<PHIManage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 57,
          margin: const EdgeInsets.only(top: 10),
          color: const Color.fromARGB(255, 175, 109, 61),
          alignment: Alignment.center,
          child: const Text(
            'PHI Manage',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        )
      ],
    );
  }
}
