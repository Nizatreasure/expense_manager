import 'package:expandable/expandable.dart';
import 'package:expense_manager/textfield_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpandedFilter extends StatefulWidget {
  final double total;
  const ExpandedFilter({required this.total, Key? key}) : super(key: key);

  @override
  State<ExpandedFilter> createState() => _ExpandedFilterState();
}

class _ExpandedFilterState extends State<ExpandedFilter> {
  List<String> merchants = [
    "Electronics",
    "Breakfast",
    "Airline",
    "Parking",
    "Taxi",
    "Shuttle",
    "Fast Food",
    "Office Supplies",
    "Rental Car",
    "Ride Sharing",
    "Restaurant",
    "Hotel"
  ];

  bool newFilter = false, inProgressFiler = false, reimbursedFilter = false;

  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "To be reimbursed",
                    style: const TextStyle(color: Colors.black, fontSize: 13.5),
                    children: [
                      TextSpan(
                        text: "\n\$${widget.total}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                ExpandableButton(
                  child: Row(
                    children: const [
                      Text(
                        "Filters",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.sort,
                        color: Colors.blue,
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "From",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            readOnly: true,
            onTap: () {},
            decoration: decoration.copyWith(
              suffixIcon: const Icon(Icons.calendar_month_rounded),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "To",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            readOnly: true,
            onTap: () {},
            decoration: decoration.copyWith(
              suffixIcon: const Icon(Icons.calendar_month_rounded),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Min',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextField(
                        onTap: () {},
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black12,
                        style: const TextStyle(fontSize: 20, height: 1.4),
                        cursorHeight: 24,
                        cursorWidth: 1,
                        decoration: decoration.copyWith(
                          isDense: true,
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 25),
                          prefixIcon: const Text(
                            r" $",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                alignment: Alignment.center,
                child: const Text(
                  "_",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Max',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onTap: () {},
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: Colors.black12,
                      style: const TextStyle(fontSize: 20, height: 1.4),
                      cursorHeight: 24,
                      cursorWidth: 1,
                      decoration: decoration.copyWith(isDense: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Merchant",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          DropdownButtonFormField<String>(
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            items: merchants.map((merchant) {
              return DropdownMenuItem<String>(
                child: Text(merchant),
                value: merchant,
              );
            }).toList(),
            onChanged: (item) {
              setState(() {
                selectedItem = item;
              });
            },
            decoration: decoration,
            value: selectedItem,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Status",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    newFilter = !newFilter;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            value: newFilter,
                            onChanged: (val) {
                              setState(() {
                                newFilter = val ?? false;
                              });
                            }),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "New",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    inProgressFiler = !inProgressFiler;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          value: inProgressFiler,
                          onChanged: (val) {
                            setState(() {
                              inProgressFiler = val ?? false;
                            });
                          }),
                      const Text(
                        "In Progress",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    reimbursedFilter = !reimbursedFilter;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          value: reimbursedFilter,
                          onChanged: (val) {
                            setState(() {
                              reimbursedFilter = val ?? false;
                            });
                          }),
                      const Text(
                        "Reimbursed",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("Clear Filters",
                    style:
                        TextStyle(fontSize: 18.5, fontWeight: FontWeight.w600)),
              ),
              ExpandableButton(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.blue.withOpacity(0.1),
                child: const Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.5,
                      fontWeight: FontWeight.w600),
                ),
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
