import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/header.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/order.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  OrderDataSource dataSource;
  List<Order> order;
  bool isLoad = true;

  getOrderList() async {
    await getAccountOrder().then((val) {
      setState(() {
        order = val;
        dataSource = OrderDataSource(order: order);
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Order History",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SfDataGrid(
                verticalScrollPhysics: BouncingScrollPhysics(),
                horizontalScrollPhysics: BouncingScrollPhysics(),
                onCellTap: ((details) {
                  if (details.rowColumnIndex.rowIndex != 0) {
                    int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
                    var row =
                        dataSource.effectiveRows.elementAt(selectedRowIndex);
                    String val = row.getCells()[0].value.toString();
                    GoRouter.of(context).push('/invoice/$val/true');
                  }
                }),
                // frozenColumnsCount: 1,
                source: dataSource,
                columnWidthMode: ColumnWidthMode.fill,
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
                      columnName: 'designation',
                      label: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Amount',
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
                  // GridColumn(
                  //     columnName: 'status',
                  //     label: Container(
                  //         padding: EdgeInsets.all(8.0),
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           'Status',
                  //           style: CustomFont.bold12,
                  //           overflow: TextOverflow.ellipsis,
                  //         ))),
                ],
              ),
            ),
    );
  }
}

class OrderDataSource extends DataGridSource {
  OrderDataSource({List<Order> order}) {
    _dataSource = order
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'orderId', value: e.id),
              DataGridCell(columnName: 'tPrice', value: rupiah(e.total_price)),
              DataGridCell(columnName: 'date', value: e.created_at),
              // DataGridCell(columnName: 'status', value: e.payment_status),
            ]))
        .toList();
  }

  List<DataGridRow> _dataSource = [];

  @override
  List<DataGridRow> get rows => _dataSource;

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
