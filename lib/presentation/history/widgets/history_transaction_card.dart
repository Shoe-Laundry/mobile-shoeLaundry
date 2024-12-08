import 'package:shoelaundry/core/extensions/int_ext.dart';
import 'package:shoelaundry/core/extensions/date_time_ext.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../order/models/order_model.dart';

class HistoryTransactionCard extends StatelessWidget {
  final OrderModel data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({
    super.key,
    required this.data,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    DateTime transactionDateTime = DateTime.parse(data.transactionTime);

    return Container(
      margin: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 16.0,
            spreadRadius: 1,
            color: AppColors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Pembayaran', data.paymentMethod),
            const SizedBox(height: 8),
            _buildRow('Jumlah Item', '${data.totalQuantity} items'),
            const SizedBox(height: 4),
            _buildRow('Nama Pelanggan', data.namaKasir),
            const SizedBox(height: 4),
            _buildRow('Waktu', transactionDateTime.toFormattedTime()),
            const SizedBox(height: 4),
            _buildRow('Nominal Bayar', data.nominalBayar.currencyFormatRp),
            const SizedBox(height: 4),
            _buildRow(
              'Status Pesanan',
              _getDeliveryStatus(transactionDateTime, data.isSync),
              color: data.isSync ? AppColors.green : AppColors.red,
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            _buildRow(
              'Total Harga',
              data.totalPrice.currencyFormatRp,
              fontWeight: FontWeight.bold,
              color: AppColors.green,
            ),
          ],
        ),
      ),
    );
  }

  String _getDeliveryStatus(DateTime transactionDateTime, bool isSync) {
    if (isSync) {
      return 'Siap Diambil';
    } else {
      DateTime now = DateTime.now();
      Duration difference = now.difference(transactionDateTime);

      if (difference.inMinutes >= 10) {
        return 'Siap Diambil';
      } else {
        return 'Dalam Proses';
      }
    }
  }

  Widget _buildRow(String label, String value, {Color color = AppColors.black, FontWeight fontWeight = FontWeight.normal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '$label',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: fontWeight,
              color: color,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

