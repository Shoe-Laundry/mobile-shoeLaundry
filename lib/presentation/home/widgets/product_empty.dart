import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';


class ProductEmpty extends StatelessWidget {
  const ProductEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpaceHeight(16.0),
          Lottie.asset(
            Assets.json.empty,
            width: 200,
            height: 200,
          ),
          const SpaceHeight(16.0),
          const Text(
            'Belum ada Produk',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
