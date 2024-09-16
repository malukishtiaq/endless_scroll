import 'package:car_dealership/core/constants/constants.dart';
import 'package:car_dealership/feature/home/screens/widgets/car_tile_square.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const AspectRatio(
            aspectRatio: 16 / 9,
            child: NetworkImageWithLoader(
              'https://i.imgur.com/H2FAdRP.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
