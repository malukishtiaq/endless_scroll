import 'package:car_dealership/feature/home/screens/widgets/title_and_action_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/debouncer.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/car_tile_square.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/header.dart';
import '../widgets/new_cars.dart';

class HomePageContent extends StatelessWidget {
  HomePageContent({super.key});
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        final pixels = scrollNotification.metrics.pixels;
        final maxScrollExtent =
            scrollNotification.metrics.maxScrollExtent * 0.7;

        // Only trigger the debouncer when the scroll position exceeds 70% of the scroll extent
        if (pixels > maxScrollExtent) {
          _debouncer.run(() {
            final state = context.read<HomeBloc>().state;
            final fetchedCount = state is Data
                ? state.fetchedCount
                : (state as MoreDataLoaded).fetchedCount;

            // Fetch more data without using the _isBusy flag
            context.read<HomeBloc>().startBackgroundFetch(fetchedCount);
          });
        } else {
          if (kDebugMode) {
            print('scroll working.');
          }
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          const Header(),
          const NewCars(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding),
            sliver: SliverToBoxAdapter(
              child: TitleAndActionButton(
                title: 'Used Cars',
                onTap: () {},
              ),
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            bloc: context.read<HomeBloc>(),
            buildWhen: (previous, current) =>
                current is Data || current is Loading || current is Error,
            builder: (context, HomeState state) {
              switch (state) {
                case Loading():
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                case InitState():
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                case Error():
                  return const SliverToBoxAdapter(
                      child: Center(child: Text('Error')));
                case Data() || MoreDataLoaded():
                  final usedCars = (state is Data)
                      ? state.usedCars
                      : (state as MoreDataLoaded).usedCars;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDefaults.padding,
                            horizontal: AppDefaults.padding,
                          ),
                          child: UsedCarTile(
                            data: usedCars[index],
                            index: index,
                          ),
                        );
                      },
                      childCount: usedCars.length,
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
