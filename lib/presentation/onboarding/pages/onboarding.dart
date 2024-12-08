import 'package:dots_indicator/dots_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:shoelaundry/core/assets/assets.gen.dart';
import 'package:shoelaundry/core/components/spaces.dart';
import 'package:shoelaundry/core/constants/colors.dart';
import 'package:shoelaundry/presentation/auth/pages/login_page.dart';
import 'package:shoelaundry/presentation/auth/pages/registration_page.dart';
import 'package:shoelaundry/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:shoelaundry/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:shoelaundry/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onboarding extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: controller,
                onPageChanged: (value) {
                  state.pageIndex = value;
                  BlocProvider.of<OnboardingBloc>(context)
                      .add(OnboardingEvents());
                },
                children: [
                  _page(
                    context: context,
                    pageIndex: 0,
                    imageUrl: Assets.json.onboarding1,
                    title: 'Pilih Kategori Layanan',
                    desc: 'Pilih layanan yang sesuai dengan kebutuhan sepatu Anda, mulai dari pembersihan cepat hingga perawatan mendalam. Kami juga menyediakan layanan tambahan untuk memberikan perawatan ekstra!',
                  ),
                  _page(
                    context: context,
                    pageIndex: 1,
                    imageUrl: Assets.json.onboarding2,
                    title: 'Tentukan Layanan',
                    desc: 'Kami menawarkan berbagai layanan, seperti pembersihan sepatu mulai dari yang cepat hingga mendalam, perawatan khusus untuk sepatu kulit dan bahan lainnya agar tetap awet',
                  ),
                  _page(
                    context: context,
                    pageIndex: 2,
                    imageUrl: Assets.json.onboarding3,
                    title: 'Pilih dan Nikmati Hasilnya!',
                    desc: 'Setelah layanan Anda diproses, sepatu Anda akan kembali seperti baru, siap untuk dipakai dengan bangga.',
                  ),
                ],
              ),
              Positioned(
                bottom: 150,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: state.pageIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.disabled,
                    activeColor: AppColors.primary,
                    size: const Size.square(9.0),
                    activeSize: const Size(36.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Row(
                  children: [
                    Visibility(
                      visible: state.pageIndex != 3,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                        ),
                        child: Text('Lanjut'),
                      ),
                    ),
                    SpaceWidth(50),
                    Visibility(
                      visible: state.pageIndex != 3,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                        ),
                        child: Text('Skip'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _page({
    pageIndex,
    imageUrl,
    title,
    desc,
    required BuildContext context,
  }) {
    return Column(
      children: [
        SpaceHeight(100),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Image.asset(
              Assets.images.launcher.path,
              width: 80,
              height: 80,
            )),
        SizedBox(
          height: 300,
          child: Lottie.asset(
            imageUrl,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          selectionColor: AppColors.black,

        ),
        SpaceHeight(10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
