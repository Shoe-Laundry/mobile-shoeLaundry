import 'package:shoelaundry/core/constants/colors.dart';
import 'package:shoelaundry/data/models/response/register_response_model.dart';
import 'package:shoelaundry/presentation/auth/bloc/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/variables.dart';
import '../../auth/bloc/login/login_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/product_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);

  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.fetchLocal());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue.value = index;
    String category = 'all';
    switch (index) {
      case 0:
        category = 'all';
        break;
      case 1:
        category = 'washingservice';
        break;
      case 2:
        category = 'careandmaintenance';
        break;
      case 3:
        category = 'additionalservices';
        break;
    }
    context.read<ProductBloc>().add(ProductEvent.fetchByCategory(category));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Beranda',
              style: TextStyle(fontWeight: FontWeight.bold)),
          // backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox(),
              successWithUserData: (userData) {
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primary,
                          child: ClipOval(
                            child: Image.network(
                              '${Variables.imageBaseUrl2}${userData.image}',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SpaceWidth(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good ${DateTime.now().hour < 12 ? 'Morning' : DateTime.now().hour < 17 ? 'Afternoon' : 'Evening'}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Hello 👋, ${userData.name}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SpaceHeight(20.0),
                    SearchInput(
                      controller: searchController,
                      onChanged: (value) {
                        if (value.length > 3) {
                          context
                              .read<ProductBloc>()
                              .add(ProductEvent.searchProduct(value));
                        }
                        if (value.isEmpty) {
                          context
                              .read<ProductBloc>()
                              .add(const ProductEvent.fetchAllFromState());
                        }
                      },
                    ),
                    const SpaceHeight(20.0),
                    ValueListenableBuilder(
                      valueListenable: indexValue,
                      builder: (context, value, _) => Row(
                        children: [
                          MenuButton(
                            iconPath: Assets.icons.allCategories.path,
                            label: 'Semua',
                            isActive: value == 0,
                            onPressed: () => onCategoryTap(0),
                          ),
                          const SpaceWidth(10.0),
                          MenuButton(
                            iconPath: Assets.icons.washingservice.path,
                            label: 'Layanan',
                            isActive: value == 1,
                            onPressed: () => onCategoryTap(1),
                          ),
                          const SpaceWidth(10.0),
                          MenuButton(
                            iconPath: Assets.icons.careandmaintenance.path,
                            label: 'Rawat',
                            isActive: value == 2,
                            onPressed: () => onCategoryTap(2),
                          ),
                          const SpaceWidth(10.0),
                          MenuButton(
                            iconPath: Assets.icons.additionalservices.path,
                            label: 'Tambah',
                            isActive: value == 3,
                            onPressed: () => onCategoryTap(3),
                          ),
                        ],
                      ),
                    ),
                    const SpaceHeight(35.0),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const SizedBox(),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (message) => Center(
                            child: Text(message),
                          ),
                          success: (products) {
                            if (products.isEmpty) return const ProductEmpty();
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.65,
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                data: products[index],
                                onCartButton: () {},
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SpaceHeight(30.0),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
