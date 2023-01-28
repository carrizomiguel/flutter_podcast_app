import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/app/app.dart';
import 'package:podcast_app/ui/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  final Map<String, Map<String, dynamic>> _items = const {
    'Home': {
      'icon': Iconsax.home,
      'view': AppPageStatus.home,
    },
    'Explore': {
      'icon': Iconsax.note,
      'view': AppPageStatus.explore,
    },
    'Favorites': {
      'icon': Iconsax.heart,
      'view': AppPageStatus.favorites,
    },
    // 'Profile': {
    //   'icon': Iconsax.user,
    //   // 'view': ContentNavigation.downloads,
    // },
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final bloc = context.read<AppBloc>();
        return BottomNavigationBar(
          items: _items.map((key, value) => MapEntry(
            key, BottomNavigationBarItem(
              icon: Icon(value['icon']),
              label: key,
            ),
          )).values.toList(),
          currentIndex: _items.values.toList().indexWhere(
            (e) => e['view'] == bloc.state.pageStatus,
          ),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey.shade400,
          onTap: (index) {
            bloc.add(AppPageChangedTo(
              page: _items.values.toList()[index]['view'],
            ));
          },
        );
      },
    );
  }
}
