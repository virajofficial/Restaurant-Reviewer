import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/models/restaurant.dart';

import '../Api/api.dart';

class SearchableDropdown extends StatefulWidget {
  final String type;
  final String mode;
  final String labelText;
  final String initialValue;
  final Function onChange;

  const SearchableDropdown({
    super.key,
    this.mode = 'add',
    this.initialValue = '',
    required this.type,
    required this.labelText,
    required this.onChange,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  List<String> phiAreas = [];
  List<Restaurant> restaurants = [];
  List<String> restaurantNames = [];
  List<int> resId = [];

  getPhiAreas() async {
    List<String> response = await getPHIAreasCall();
    setState(() {
      phiAreas = response;
    });
  }

  getRestaurants() async {
    List<Restaurant> response = await getRestaurantsCall();
    setState(() {
      restaurants = response;
      for (int i = 0; i < restaurants.length; i++) {
        restaurantNames
            .add('${restaurants[i].resName} - ${restaurants[i].resPhiArea}');
      }
    });
  }

  String getRestaurantId(String value) {
    int index = restaurantNames.indexOf(value);
    return '${restaurants[index].resId.toString()}-${value.split(' - ')[1]}';
  }

  @override
  void initState() {
    getRestaurants();
    getPhiAreas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.mode == 'add')
        ? Padding(
            //*******************************************************************************************add Searchable Input
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
            ),
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                //fit: FlexFit.loose,
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
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF96471A))),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF96471A))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF96471A))),
                  ),
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 136, 83, 60),
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
              items: (widget.type == 'resNames') ? restaurantNames : phiAreas,
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
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF96471A))),
                  disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF96471A))),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF96471A))),
                  labelStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFAA684B),
                  ),
                  //hintText: "country in menu mode",
                ),
              ),
              onChanged: (value) {
                (widget.type == 'resNames')
                    ? widget.onChange(getRestaurantId(value!))
                    : widget.onChange(value);
              },
            ),
          )
        : Padding(
            //*******************************************************************************************Edit Searchable Input
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
            ),
            child: Row(
              children: [
                MediaQuery.of(context).size.width > 490
                    ? Container(
                        width: 100,
                        child: Text(
                          '${widget.labelText}:',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 168, 88, 41),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                Expanded(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(160, 150, 71, 26),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF96471A))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF96471A))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF96471A))),
                        ),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 134, 82, 59),
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
                    selectedItem: widget.initialValue,
                    items: phiAreas,
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
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF96471A))),
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF96471A))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF96471A))),
                        labelStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFAA684B),
                        ),
                        //hintText: "country in menu mode",
                      ),
                    ),
                    onChanged: (value) {
                      widget.onChange(value);
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
