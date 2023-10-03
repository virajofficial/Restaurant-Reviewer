import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Screen/phiDialog.dart';
import 'package:restaurant_reviewer/models/phi.dart';
import 'package:restaurant_reviewer/models/restaurant.dart';

import '../Screen/reviewDialog.dart';

class PhiItem extends StatelessWidget {
  const PhiItem({super.key, required this.phi, required this.reloadPhi});

  final Phi phi;
  final Function reloadPhi;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            constraints: const BoxConstraints(minWidth: 500, maxWidth: 800),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
                color: Color(0xFFFFBE99),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: Color.fromARGB(141, 54, 54, 54),
                    blurRadius: 5,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phi.phiName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCD3100)),
                  textAlign: TextAlign.start,
                ),
                Text(
                  phi.phiArea,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 18),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: const Color.fromARGB(61, 233, 127, 56),
                splashColor: const Color.fromARGB(59, 223, 117, 56),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => PhiDialogue(
                        state: 'edit',
                        details: Phi(
                          phiId: phi.phiId,
                          phiAddress: phi.phiAddress,
                          phiArea: phi.phiArea,
                          phiContactNo: phi.phiContactNo,
                          phiEmail: phi.phiEmail,
                          phiName: phi.phiName,
                          phiRegNo: phi.phiRegNo,
                        ),
                        reloadPhis: reloadPhi),
                  );
                },
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 500, maxWidth: 800),
                  height: 90,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
