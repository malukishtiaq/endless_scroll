import 'package:car_dealership/core/constants/constants.dart';
import 'package:car_dealership/feature/home/screens/bloc/home_bloc.dart';
import 'package:car_dealership/feature/home/screens/bloc/home_state.dart';
import 'package:car_dealership/feature/home/screens/widgets/car_tile_square.dart';
import 'package:car_dealership/feature/home/screens/widgets/title_and_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCars extends StatelessWidget {
  const NewCars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          TitleAndActionButton(
            title: 'New Cars',
            onTap: () {},
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: AppDefaults.padding),
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: context.read<HomeBloc>(),
              buildWhen: (previous, current) =>
                  current is Data || current is Loading || current is Error,
              builder: (context, HomeState state) {
                switch (state) {
                  case InitState():
                    return const Center(child: CircularProgressIndicator());
                  case Loading():
                    return const Center(child: CircularProgressIndicator());
                  case Error():
                    return const Center(child: Text('Error'));
                  case Data():
                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: AppDefaults.padding,
                      ),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          state.newCars.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                                right: AppDefaults.padding),
                            child: NewCarTile(data: state.newCars[index]),
                          ),
                        ),
                      ),
                    );
                  case MoreDataLoaded():
                    return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
