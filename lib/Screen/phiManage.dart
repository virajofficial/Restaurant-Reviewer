import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_reviewer/Screen/phiDialog.dart';
import 'package:restaurant_reviewer/Components/phiItem.dart';
import 'package:restaurant_reviewer/models/phi.dart';

import '../Api/api.dart';

class PHIManage extends StatefulWidget {
  const PHIManage({
    super.key,
  });

  @override
  State<PHIManage> createState() => _PHIManageState();
}

class _PHIManageState extends State<PHIManage> {
  List<Phi> phis = [];

  getPhis() async {
    List<Phi> response = await getPhisCall();

    setState(() {
      phis = response;
    });
  }

  @override
  void initState() {
    getPhis();
    super.initState();
  }

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
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: phis.length,
                  itemBuilder: (context, index) => PhiItem(
                    phi: phis[index],
                    reloadPhi: getPhis,
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => PhiDialogue(
                          state: 'add',
                          details: Phi(
                            phiArea: '',
                            phiName: '',
                            phiAddress: '',
                            phiContactNo: '',
                            phiEmail: '',
                            phiRegNo: '',
                          ),
                          reloadPhis: getPhis),
                    );
                  },
                  backgroundColor: Color(0xFFE2582C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
