import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:voloc/core/themes/app_theme.dart';
import 'package:voloc/views/screens/profile_screen.dart';
import 'package:voloc/views/screens/search_screen.dart';
import '../../logic/cubit/tab_index_cubit.dart';
import 'booking_screen.dart';
import 'home_screen.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TabIndexCubit>(
        create: (context) => TabIndexCubit(),
        child: const _Tabs(),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context) {
    Widget activeScreen =  HomeScreen();

    return BlocBuilder<TabIndexCubit, TabIndexState>(
      builder: (context, state) {
        if (state.index == 0) {
          activeScreen =  HomeScreen();
        } else if (state.index == 1) {
          activeScreen =  const SearchScreen();
        } else if (state.index == 2) {
          activeScreen =  const BookingScreen();
        } else if (state.index == 3) {
          activeScreen =  const ProfileScreen();
        }
        return Scaffold(
          body: activeScreen,
          bottomNavigationBar: BlocBuilder<TabIndexCubit, TabIndexState>(
            builder: (context, state) {
              return Container(
                color: kColorScheme.onSecondary,

                height: 60,
                child: GNav(
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      backgroundColor: kColorScheme.onBackground,
                    ),
                    GButton(
                        icon: Icons.search,
                        text: 'Search',
                        backgroundColor: kColorScheme.onBackground),
                    GButton(
                        icon: Icons.book_online,
                        text: 'Booking',
                        backgroundColor: kColorScheme.onBackground),
                    GButton(
                        icon: Icons.person,
                        text: 'Profile',
                        backgroundColor: kColorScheme.onBackground),
                  ],
                  selectedIndex: state.index,
                  onTabChange: (value) {
                    BlocProvider.of<TabIndexCubit>(context).changeTab(value);
                    value = state.index;
                  },
                  iconSize: 24,
                  color: kColorScheme.onPrimaryContainer,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
