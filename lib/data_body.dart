import 'package:expense_manager/dummy_data.dart';
import 'package:expense_manager/expense_manager.dart';
import 'package:expense_manager/single_cell.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DataBody extends StatefulWidget {
  final ScrollController controllerNew;
  final List<ExpenseManager> data;
  const DataBody(this.controllerNew, {required this.data, Key? key})
      : super(key: key);

  @override
  State<DataBody> createState() => _DataBodyState();
}

class _DataBodyState extends State<DataBody> {
  late LinkedScrollControllerGroup controllerGroup;
  late ScrollController controller;
  late ScrollController controller2;
  bool showBorder = false;

  @override
  void initState() {
    controllerGroup = LinkedScrollControllerGroup();
    controller = controllerGroup.addAndGet();
    controller2 = controllerGroup.addAndGet();
    widget.controllerNew.addListener(() {
      showBorder = widget.controllerNew.offset != 0;
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: ListView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return SingleCell(
                  DateFormat.yMd().format(widget.data[index].date),
                  showBorder: showBorder,
                  padding: 10);
            },
            itemCount: dummyData.length,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.controllerNew,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
                width: 450,
                child: ListView.builder(
                  controller: controller2,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // dummyData.sort((a, b) {
                    //   return b.date.toString().compareTo(a.date.toString());
                    // });
                    String status = widget.data[index].status;
                    return Row(
                      children: [
                        SingleCell(widget.data[index].merchant),
                        SingleCell('\$${widget.data[index].total}'),
                        SingleCell(
                          status,
                          color: status == "New" ? Colors.red : Colors.black,
                          fontStyle: status == "In Progress"
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontWeight: status == "In Progress" || status == "New"
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                        SingleCell(
                          widget.data[index].comment,
                          width: 150,
                        )
                      ],
                    );
                  },
                  itemCount: widget.data.length,
                )
                // ListView(
                // controller: controller2,
                // physics: const AlwaysScrollableScrollPhysics(),
                //   children: List.generate(20, (index) {
                //     return Row(
                //       children: const [
                //         SingleCell("Taxi"),
                //         SingleCell("\$500.12"),
                //         SingleCell("Reimbursed"),
                //         SingleCell(
                //           "Expense from the trip.",
                //           width: 150,
                //         ),
                //       ],
                //     );
                //   }),
                // ),
                ),
          ),
        ),
      ],
    );
  }
}
