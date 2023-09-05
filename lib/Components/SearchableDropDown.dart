import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';

class SearchableDropdown extends StatefulWidget {
  //final String type;
  final String labelText;
  //final Function onChange;

  const SearchableDropdown({
    super.key,
    //required this.type,
    required this.labelText,
    //required this.onChange,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  List<String> phiAreas = [];

  /*getPhiAreas() async {
    List<String>? response = await getPHIAreasCall();
    setState(() {
      phiAreas = response!;
    });
  }

  @override
  void initState() {
    getPhiAreas();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 16,
      ),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
          fit: FlexFit.loose,
          searchFieldProps: TextFieldProps(
            autofocus: true,
            cursorColor: Color.fromARGB(204, 150, 71, 26),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color(0xFFAA684B),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(160, 150, 71, 26),
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            ),
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFFAA684B),
            ),
          ),

          menuProps: MenuProps(
            backgroundColor: Color.fromARGB(255, 218, 159, 105),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            shadowColor: Colors.black,
            elevation: 2,
          ),

          //disabledItemFn: (String s) => s.startsWith('C'),
        ),
        //items: phiAreas,
        items: [
          "Brazil",
          "Italia",
          "Tunisia",
          "Canada",
          "Brazil",
          "Italia",
          "Tunisia",
          "Canada",
          "Brazil",
          "Italia",
          "Tunisia",
          "Canada",
          "Brazil",
          "Italia",
          "Tunisia",
          "Canada"
        ],
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Color(0xFFAA684B),
          ),
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.labelText,
            filled: true,
            fillColor: const Color.fromARGB(0, 255, 211, 186),
            suffixIconColor: const Color.fromARGB(204, 150, 71, 26),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(160, 150, 71, 26),
                )),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            labelStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFFAA684B),
            ),
            //hintText: "country in menu mode",
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
