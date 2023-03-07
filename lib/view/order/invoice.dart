// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/controller/order.dart';
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
  String payment_status;
  String bank_name;
  String bank_number;
  String payment_type;
  String created_at;

  getData() async {
    await getAccountOrderDetail(widget.id.toString()).then((val) async {
      List<OrderItemDetail> list = [];
      for (var data in val['data']['order_dt'] as List) {
        list.add(OrderItemDetail(
          description: (data['product_id'] != null)
              ? data['product']['name']
              : data['e_learning']['name'],
          qty: data['qty'].toString(),
          amount: data['sub_total'].toString(),
        ));
      }
      setState(() {
        no_receipt = val['data']['no_receipt'];
        customer_id = val['data']['customer_id'];
        total_price = val['data']['total_price'];
        if (val['data']['payment_status'] == 1) {
          payment_status = "Released";
        }
        if (val['data']['payment_status'] == 2) {
          payment_status = "Paid";
        }
        if (val['data']['payment_status'] == 3) {
          payment_status = "Cancel";
        }

        created_at = val['data']['created_at'];
        item = list;
        dataSource = OrderItem(item: item);
      });
      await getPaymentMethodMidtrans(no_receipt).then((val) {
        if (val['payment_type'] == "bank_transfer") {
          setState(() {
            payment_type = val['payment_type'].toString().toUpperCase();
            bank_name = val['va_numbers'][0]['bank'].toString().toUpperCase();
            bank_number = val['va_numbers'][0]['va_number'].toString();
            isLoad = false;
          });
        } else {
          setState(() {
            payment_type = val['payment_type'].toString().toUpperCase();
            isLoad = false;
          });
        }
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
        leading: (widget.isHistory)
            ? CupertinoNavigationBarBackButton(
                color: CustomColor.whiteColor,
                onPressed: () => GoRouter.of(context).pop())
            : SizedBox(),
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
                      image: AssetImage('assets/img/revver-bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(35),
                  child: Column(
                    children: [
                      SpacerHeight(h: 80),
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
                              Column(
                                children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Text(
                                  //       "Billed to: ",
                                  //       style: CustomFont(
                                  //               CustomColor.blackColor,
                                  //               12,
                                  //               FontWeight.w600)
                                  //           .font,
                                  //       overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //     Text(
                                  //       customer_id.toString(),
                                  //       style: CustomFont(
                                  //               CustomColor.blackColor,
                                  //               12,
                                  //               FontWeight.w400)
                                  //           .font,
                                  //       overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //   ],
                                  // ),
                                  // SpacerHeight(h: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Invoice No: ",
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                12,
                                                FontWeight.w400)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        no_receipt.toString(),
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                12,
                                                FontWeight.w600)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  SpacerHeight(h: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Invoice Date: ",
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                12,
                                                FontWeight.w400)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        created_at.toString(),
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                12,
                                                FontWeight.w600)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  SpacerHeight(h: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Status: ",
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                12,
                                                FontWeight.w400)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        payment_status.toString(),
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                12,
                                                FontWeight.w600)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     SizedBox(
                              //       width: CustomScreen(context).width / 3,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             "Billed to",
                              //             style: CustomFont.regular16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //           Text(
                              //             customer_id.toString(),
                              //             style: CustomFont.bold16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: CustomScreen(context).width / 3,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.end,
                              //         children: [
                              //           Text(
                              //             "Invoice Number",
                              //             style: CustomFont.regular16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //           Text(
                              //             no_receipt.toString(),
                              //             style: CustomFont.bold16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SpacerHeight(h: 20),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     SizedBox(
                              //       width: CustomScreen(context).width / 3,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             "Invoice Date",
                              //             style: CustomFont.regular16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //           Text(
                              //             created_at.toString(),
                              //             style: CustomFont.bold16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: CustomScreen(context).width / 3,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.end,
                              //         children: [
                              //           Text(
                              //             "Payment Status",
                              //             style: CustomFont.regular16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //           Text(
                              //             payment_status.toString(),
                              //             style: CustomFont.bold16,
                              //             overflow: TextOverflow.ellipsis,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
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
                                          Text(rupiah(total_price),
                                              style: CustomFont.bold12),
                                        ],
                                      )),
                                ],
                              ),
                              SpacerHeight(h: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Payment Detail",
                                        style: CustomFont.regular16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        payment_type ??= "",
                                        style: CustomFont(
                                                CustomColor.oldGreyColor,
                                                11,
                                                FontWeight.w400)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        bank_name ??= "",
                                        style: CustomFont(
                                                CustomColor.blackColor,
                                                20,
                                                FontWeight.w600)
                                            .font,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    bank_number ??= "",
                                    style: CustomFont(CustomColor.brownColor,
                                            20, FontWeight.w600)
                                        .font,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  (bank_number.isEmpty)
                                      ? SizedBox()
                                      : InkWell(
                                          child: Icon(
                                            Icons.copy,
                                            color: CustomColor.oldGreyColor,
                                          ),
                                          onTap: () async {
                                            await Clipboard.setData(
                                                    ClipboardData(
                                                        text: bank_number))
                                                .then((_) {
                                              customSnackBar(context, false,
                                                  "Bank Number Copied to Clipboard");
                                            });
                                          },
                                        ),
                                ],
                              )
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
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: CustomButton(
                title: "Back to Home",
                func: () async {
                  GoRouter.of(context).go('/homepage/0');
                },
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
