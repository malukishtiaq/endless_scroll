import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF2F6F3),
            shape: const CircleBorder(),
          ),
          child: SvgPicture.asset('assets/icons/side_bar_icon.svg'),
        ),
      ),
      floating: true,
      title: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: SvgPicture.asset(
          "assets/images/app_logo.svg",
          height: 32,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF2F6F3),
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ),
      ],
    );
  }
}
