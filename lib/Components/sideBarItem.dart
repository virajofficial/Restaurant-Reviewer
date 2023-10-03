import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarItem extends StatefulWidget {
  SideBarItem({
    super.key,
    required this.selectedTab,
    required this.tab,
    required this.changeTab,
    this.isHorizontal = false,
    required this.position,
    this.isbatchCounter = false,
    this.count = 0,
  });

  final String selectedTab;
  final String tab;
  final Function changeTab;
  final bool isHorizontal;
  final int position;
  final bool isbatchCounter;
  int count;

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  getLayout({required Widget child}) {
    return widget.isHorizontal
        ? Expanded(
            child: child,
          )
        : Container(
            child: child,
          );
  }

  @override
  Widget build(BuildContext context) {
    return getLayout(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          InkWell(
            onTap: () => widget.changeTab(widget.tab),
            child: Container(
              width: widget.isHorizontal ? 120 : double.infinity,
              height: 50,
              margin: widget.isHorizontal
                  ? EdgeInsets.all(0)
                  : EdgeInsets.only(right: 10, top: 0, bottom: 20, left: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: widget.selectedTab == widget.tab
                      ? const Color.fromARGB(255, 226, 88, 44)
                      : const Color.fromARGB(255, 246, 153, 123),
                  borderRadius: widget.isHorizontal
                      ? widget.position == 1
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100))
                          : widget.position == 3
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(100),
                                  bottomRight: Radius.circular(100))
                              : const BorderRadius.all(Radius.circular(0))
                      : const BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                  boxShadow:
                      widget.isHorizontal && widget.selectedTab == widget.tab ||
                              !widget.isHorizontal
                          ? const [
                              BoxShadow(
                                  color: Color.fromARGB(95, 125, 44, 18),
                                  offset: Offset(0, -1),
                                  blurRadius: 8,
                                  blurStyle: BlurStyle.inner),
                              BoxShadow(
                                color: Color.fromARGB(56, 0, 0, 0),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              )
                            ]
                          : []),
              child: Text(
                widget.tab,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          widget.isbatchCounter && widget.count > 0
              ? Row(
                  children: [
                    Expanded(child: Container()),
                    Positioned(
                      right: 5,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.count.toString(),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
