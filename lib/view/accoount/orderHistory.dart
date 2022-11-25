import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<Employee> employees = <Employee>[];
  EmployeeDataSource employeeDataSource;

  getOrderList() async {
    await getAccountOrder().then((val) {
      print(val);
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderList();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Order History",
        isPop: true,
      ),
      body: SfDataGrid(
        onCellTap: ((details) {
          if (details.rowColumnIndex.rowIndex != 0) {
            int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
            var row =
                employeeDataSource.effectiveRows.elementAt(selectedRowIndex);
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: SizedBox(
                      height: 300,
                      width: 300,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Text('Order ID'),
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25)),
                              const Text(':'),
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                              Text(row.getCells()[0].value.toString()),
                            ]),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK")),
                            )
                          ]),
                    )));
          }
        }),
        frozenColumnsCount: 1,
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.none,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'orderId',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Order ID',
                    style: CustomFont.bold12,
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'tItem',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Total Item',
                    style: CustomFont.bold12,
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'designation',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Total Price',
                    overflow: TextOverflow.ellipsis,
                    style: CustomFont.bold12,
                  ))),
          GridColumn(
              columnName: 'date',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Date',
                    style: CustomFont.bold12,
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'status',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Status',
                    style: CustomFont.bold12,
                    overflow: TextOverflow.ellipsis,
                  ))),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10002, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10003, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10004, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10005, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10006, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10007, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10008, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10009, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10010, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10010, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10010, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10010, 1, 10000, DateTime.now(), "Terkirim"),
      Employee(10010, 1, 10000, DateTime.now(), "Terkirim"),
    ];
  }
}

class Employee {
  Employee(this.orderId, this.tItem, this.tPrice, this.date, this.status);
  final int orderId;
  final int tItem;
  final int tPrice;
  final DateTime date;
  final String status;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'orderId', value: e.orderId),
              DataGridCell<int>(columnName: 'tItem', value: e.tItem),
              DataGridCell<int>(columnName: 'tPrice', value: e.tPrice),
              DataGridCell<DateTime>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'status', value: e.status),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          style: CustomFont.regular12,
        ),
      );
    }).toList());
  }
}
