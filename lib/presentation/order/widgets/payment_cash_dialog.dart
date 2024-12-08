import 'package:badges/badges.dart';
import 'package:shoelaundry/core/extensions/build_context_ext.dart';
import 'package:shoelaundry/core/extensions/int_ext.dart';
import 'package:shoelaundry/core/extensions/string_ext.dart';
import 'package:shoelaundry/presentation/order/widgets/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart'; // Import QuickAlert package

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/product_local_datasource.dart';
import '../bloc/order/order_bloc.dart';
import '../models/order_model.dart';

class PaymentCashDialog extends StatefulWidget {
  final int price;
  const PaymentCashDialog({super.key, required this.price});

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  TextEditingController? priceController;

  @override
  void initState() {
    priceController = TextEditingController(text: widget.price.currencyFormatRp);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        confirmBtnText: 'Proses',  // Button for confirmation
        cancelBtnText: 'Batal',   // Button for cancellation (if needed)
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceHeight(8.0),
            CustomTextField(
              controller: priceController!,
              label: '',
              showLabel: false,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final int priceValue = value.toIntegerFromText;
                priceController!.text = priceValue.currencyFormatRp;
                priceController!.selection = TextSelection.fromPosition(
                    TextPosition(offset: priceController!.text.length));
              },
            ),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Button.filled(
                    onPressed: () {},
                    label: widget.price.currencyFormatRp,
                    disabled: true,
                    textColor: AppColors.black,
                    fontSize: 13.0,
                    height: 40.0,
                  ),
                ),
              ],
            ),
            const SpaceHeight(30.0),
            BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (
                      data,
                      qty,
                      total,
                      payment,
                      nominal,
                      idKasir,
                      namaKasir,
                      ) {
                    final orderModel = OrderModel(
                        paymentMethod: payment,
                        nominalBayar: nominal,
                        orders: data,
                        totalQuantity: qty,
                        totalPrice: total,
                        idKasir: idKasir,
                        namaKasir: namaKasir,
                        transactionTime: DateFormat('yyyy-MM-ddTHH:mm:ss')
                            .format(DateTime.now()),
                        isSync: false);
                    ProductLocalDatasource.instance.saveOrder(orderModel);
                    context.pop();
                    showDialog(
                      context: context,
                      builder: (context) => const PaymentSuccessDialog(),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return const SizedBox();
                }, success: (data, qty, total, payment, _, idKasir, mameKasir) {
                  return const SizedBox();  // Remove the Button.filled
                }, error: (message) {
                  return const SizedBox();  // Remove the Button.filled
                });
              },
            ),
          ],
        ),
        title: 'Pembayaran - Tunai',
        text: 'Masukkan jumlah uang',
        onConfirmBtnTap: () async {
          final paymentAmount = priceController!.text.toIntegerFromText;
          if (paymentAmount < widget.price) {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'Uang yang diberikan kurang.',
            );
            return;
          }
          context.read<OrderBloc>().add(OrderEvent.addNominalBayar(paymentAmount));
        },
      );
    });
    return const SizedBox();
  }
}
