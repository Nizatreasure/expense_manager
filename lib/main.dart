import 'package:expandable/expandable.dart';
import 'package:expense_manager/data_body.dart';
import 'package:expense_manager/dummy_data.dart';
import 'package:expense_manager/expanded_filter.dart';
import 'package:expense_manager/expense_manager.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

void main() {
  runApp(const MyApp());
}

enum SortBy {
  dateAsc,
  dateDes,
  merchantAsc,
  merchantDes,
  totalAsc,
  totalDes,
  statusAsc,
  statusDes,
  commentAsc,
  commentDes,
  none
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Expense Manager Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late LinkedScrollControllerGroup controllerGroup;
  late ScrollController controller;
  late ScrollController controller2;
  bool showBorder = false;
  late List<ExpenseManager> data;
  late List<ExpenseManager> data2;
  SortBy sortBy = SortBy.none;
  double total = 0.0;

  @override
  void initState() {
    controllerGroup = LinkedScrollControllerGroup();
    controller = controllerGroup.addAndGet();
    controller2 = controllerGroup.addAndGet();
    data = dummyData;
    calculateTotal();
    dateSort();

    controller.addListener(() {
      setState(() {
        showBorder = controller.offset != 0;
      });
    });

    super.initState();
  }

  calculateTotal() {
    data.where((element) {
      return element.status == "New";
    }).forEach((element) {
      total = total + element.total;
    });
    setState(() {});
  }

  dateSort() {
    if (sortBy != SortBy.dateDes && sortBy != SortBy.dateAsc) {
      setState(() {
        sortBy = SortBy.dateAsc;
        data.sort((a, b) {
          return a.date.toString().compareTo(b.date.toString());
        });
      });
    } else if (sortBy == SortBy.dateAsc && sortBy != SortBy.dateDes) {
      setState(() {
        data.sort((b, a) {
          sortBy = SortBy.dateDes;
          return a.date.toString().compareTo(b.date.toString());
        });
      });
    } else {
      setState(() {
        sortBy = SortBy.none;
        data.sort((a, b) {
          return a.date.toString().compareTo(a.date.toString());
        });
      });
    }
  }

  merchantSort() {
    if (sortBy != SortBy.merchantDes && sortBy != SortBy.merchantAsc) {
      setState(() {
        sortBy = SortBy.merchantAsc;
        data.sort((a, b) {
          return a.merchant.compareTo(b.merchant);
        });
      });
    } else if (sortBy == SortBy.merchantAsc && sortBy != SortBy.merchantDes) {
      setState(() {
        data.sort((b, a) {
          sortBy = SortBy.merchantDes;
          return a.merchant.compareTo(b.merchant);
        });
      });
    } else {
      setState(() {
        sortBy = SortBy.none;
        data.sort((a, b) {
          return a.date.toString().compareTo(a.date.toString());
        });
      });
    }
  }

  totalSort() {
    if (sortBy != SortBy.totalAsc && sortBy != SortBy.totalDes) {
      setState(() {
        sortBy = SortBy.totalAsc;
        data.sort((a, b) {
          return a.total.toString().compareTo(b.total.toString());
        });
      });
    } else if (sortBy == SortBy.totalAsc && sortBy != SortBy.totalDes) {
      setState(() {
        data.sort((b, a) {
          sortBy = SortBy.totalDes;
          return a.total.toString().compareTo(b.total.toString());
        });
      });
    } else {
      setState(() {
        sortBy = SortBy.none;
        data.sort((a, b) {
          return a.date.toString().compareTo(a.date.toString());
        });
      });
    }
  }

  statusSort() {
    if (sortBy != SortBy.statusDes && sortBy != SortBy.statusAsc) {
      setState(() {
        sortBy = SortBy.statusAsc;
        data.sort((a, b) {
          return a.status.compareTo(b.status);
        });
      });
    } else if (sortBy == SortBy.statusAsc && sortBy != SortBy.statusDes) {
      setState(() {
        data.sort((b, a) {
          sortBy = SortBy.statusDes;
          return a.status.compareTo(b.status);
        });
      });
    } else {
      setState(() {
        sortBy = SortBy.none;
        data.sort((a, b) {
          return a.date.toString().compareTo(a.date.toString());
        });
      });
    }
  }

  commentSort() {
    if (sortBy != SortBy.commentDes && sortBy != SortBy.commentAsc) {
      setState(() {
        sortBy = SortBy.commentAsc;
        data.sort((a, b) {
          return a.comment.compareTo(b.comment);
        });
      });
    } else if (sortBy == SortBy.commentAsc && sortBy != SortBy.commentDes) {
      setState(() {
        data.sort((b, a) {
          sortBy = SortBy.commentDes;
          return a.comment.compareTo(b.comment);
        });
      });
    } else {
      setState(() {
        sortBy = SortBy.none;
        data.sort((a, b) {
          return a.date.toString().compareTo(a.date.toString());
        });
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(sortBy == SortBy.none ? "dummy" : "data");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              color: const Color(0xff233448),
              child: const Text(
                "Expense Manager",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ExpandableNotifier(
              child: Expandable(
                collapsed: Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  color: const Color(0xfff4f5f7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "To be reimbursed",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 13.5),
                          children: [
                            TextSpan(
                              text: "\n\$$total",
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
                      )),
                    ],
                  ),
                ),
                expanded: ExpandedFilter(total: total),
              ),
            ),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -2),
                    spreadRadius: 0,
                    blurRadius: 2,
                    color: Colors.black38,
                  ),
                ],
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: dateSort,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: sortBy == SortBy.dateAsc ||
                                        sortBy == SortBy.dateDes
                                    ? Colors.blue
                                    : Colors.black),
                          ),
                          Icon(
                            sortBy == SortBy.dateAsc
                                ? Icons.arrow_drop_down
                                : sortBy == SortBy.dateDes
                                    ? Icons.arrow_drop_up
                                    : Icons.unfold_more,
                            color: sortBy == SortBy.dateAsc ||
                                    sortBy == SortBy.dateDes
                                ? Colors.blue
                                : Colors.black38,
                          )
                        ],
                      ),
                      width: 100,
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              end: showBorder
                                  ? const BorderSide(
                                      color: Colors.black, width: 0.1)
                                  : BorderSide.none)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: merchantSort,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    'Merchant',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: sortBy == SortBy.merchantAsc ||
                                                sortBy == SortBy.merchantDes
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  Icon(
                                    sortBy == SortBy.merchantAsc
                                        ? Icons.arrow_drop_down
                                        : sortBy == SortBy.merchantDes
                                            ? Icons.arrow_drop_up
                                            : Icons.unfold_more,
                                    color: sortBy == SortBy.merchantAsc ||
                                            sortBy == SortBy.merchantDes
                                        ? Colors.blue
                                        : Colors.black38,
                                  )
                                ],
                              ),
                              width: 100,
                            ),
                          ),
                          GestureDetector(
                            onTap: totalSort,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: sortBy == SortBy.totalAsc ||
                                                sortBy == SortBy.totalDes
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  Icon(
                                    sortBy == SortBy.totalAsc
                                        ? Icons.arrow_drop_down
                                        : sortBy == SortBy.totalDes
                                            ? Icons.arrow_drop_up
                                            : Icons.unfold_more,
                                    color: sortBy == SortBy.totalAsc ||
                                            sortBy == SortBy.totalDes
                                        ? Colors.blue
                                        : Colors.black38,
                                  )
                                ],
                              ),
                              width: 100,
                            ),
                          ),
                          GestureDetector(
                            onTap: statusSort,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: sortBy == SortBy.statusAsc ||
                                                sortBy == SortBy.statusDes
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  Icon(
                                    sortBy == SortBy.statusAsc
                                        ? Icons.arrow_drop_down
                                        : sortBy == SortBy.statusDes
                                            ? Icons.arrow_drop_up
                                            : Icons.unfold_more,
                                    color: sortBy == SortBy.statusAsc ||
                                            sortBy == SortBy.statusDes
                                        ? Colors.blue
                                        : Colors.black38,
                                  )
                                ],
                              ),
                              width: 100,
                            ),
                          ),
                          GestureDetector(
                            onTap: commentSort,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    'Comment',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: sortBy == SortBy.commentAsc ||
                                                sortBy == SortBy.commentDes
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  Icon(
                                    sortBy == SortBy.commentAsc
                                        ? Icons.arrow_drop_down
                                        : sortBy == SortBy.commentDes
                                            ? Icons.arrow_drop_up
                                            : Icons.unfold_more,
                                    color: sortBy == SortBy.commentAsc ||
                                            sortBy == SortBy.commentDes
                                        ? Colors.blue
                                        : Colors.black38,
                                  )
                                ],
                              ),
                              width: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DataBody(
                controller2,
                data: data,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
