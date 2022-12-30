// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/order.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Invoice extends StatefulWidget {
  Invoice({Key key, this.id, this.isHistory}) : super(key: key);
  int id;
  bool isHistory;

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  OrderItem dataSource;
  List<OrderItemDetail> item;
  bool isLoad = true;

  String no_receipt;
  int customer_id;
  int total_price;
  int payment_status;
  String bank_name;
  String bank_number;
  String created_at;

  getData() async {
    await getAccountOrderDetail(widget.id.toString()).then((val) {
      List<OrderItemDetail> list = [];
      for (var data in val['data']['order_dt'] as List) {
        list.add(OrderItemDetail(
          description: data['product']['name'],
          qty: data['total_item'].toString(),
          amount: data['total_item'].toString(),
        ));
      }
      setState(() {
        no_receipt = val['data']['no_receipt'];
        customer_id = val['data']['customer_id'];
        total_price = val['data']['total_price'];
        payment_status = val['data']['payment_status'];
        bank_name = val['data']['bank_name'];
        bank_number = val['data']['bank_number'];
        created_at = val['data']['created_at'];
        item = list;
        dataSource = OrderItem(item: item);
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
            color: CustomColor.whiteColor,
            onPressed: () => GoRouter.of(context).pop()),
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : Stack(
              children: [
                Container(
                  height: CustomScreen(context).height,
                  width: CustomScreen(context).width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/background-resize.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SpacerHeight(h: 60),
                      ClipPath(
                        clipper: CustomTicketShape(),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: CustomColor.greyColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/img/logo-header.png",
                                width: CustomScreen(context).width / 2,
                              ),
                              SpacerHeight(h: 20),
                              Text(
                                "4945 Forest Avenue, New York\n10004, United States\n646-888-6885\nemail@email.com\nwww.website.com",
                                style: CustomFont.bold10,
                              ),
                              SpacerHeight(h: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: CustomScreen(context).width / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Billed to",
                                          style: CustomFont.regular16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          customer_id.toString(),
                                          style: CustomFont.bold16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: CustomScreen(context).width / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Invoice Number",
                                          style: CustomFont.regular16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          no_receipt.toString(),
                                          style: CustomFont.bold16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SpacerHeight(h: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: CustomScreen(context).width / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Invoice Date",
                                          style: CustomFont.regular16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          created_at.toString(),
                                          style: CustomFont.bold16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: CustomScreen(context).width / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Payment Status",
                                          style: CustomFont.regular16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          payment_status.toString(),
                                          style: CustomFont.bold16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SpacerHeight(h: 20),
                              (item == null)
                                  ? Center(child: Text("No Item"))
                                  : SfDataGrid(
                                      verticalScrollPhysics:
                                          NeverScrollableScrollPhysics(),
                                      shrinkWrapRows: true,
                                      source: dataSource,
                                      columnWidthMode: ColumnWidthMode.fill,
                                      columns: <GridColumn>[
                                        GridColumn(
                                            columnName: 'itemDescription',
                                            label: Container(
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Item Description',
                                                  style: CustomFont.bold12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ))),
                                        GridColumn(
                                            columnName: 'qty',
                                            label: Container(
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Qty',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomFont.bold12,
                                                ))),
                                        GridColumn(
                                            columnName: 'amount',
                                            label: Container(
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Amount',
                                                  style: CustomFont.bold12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ))),
                                      ],
                                    ),
                              SpacerHeight(h: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: CustomColor.brownColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Text("Total",
                                              style: CustomFont.bold16),
                                          SpacerWidth(w: 20),
                                          Text(rupiah(999999),
                                              style: CustomFont.bold12),
                                        ],
                                      )),
                                ],
                              ),
                              SpacerHeight(h: 20),
                              Text(
                                "Payment Detail",
                                style: CustomFont.regular16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                bank_name.toString(),
                                style: CustomFont.bold16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                bank_number.toString(),
                                style: CustomFont.bold12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: (widget.isHistory)
          ? SizedBox()
          : Container(
              color: CustomColor.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomButton(
                title: "Back to Home",
                func: () async {},
              ),
            ),
    );
  }
}

class OrderItem extends DataGridSource {
  OrderItem({List<OrderItemDetail> item}) {
    _dataSource = item
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'itemDescription', value: e.description),
              DataGridCell(columnName: 'qty', value: e.qty),
              DataGridCell(columnName: 'amount', value: rupiah(e.amount)),
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

class CustomTicketShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(8)));
    path.addOval(Rect.fromCircle(
        center: Offset(0, (size.height / 3) * 1.8), radius: 15));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, (size.height / 3) * 1.8), radius: 15));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
