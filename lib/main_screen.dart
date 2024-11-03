import 'package:flutter/material.dart';
import 'package:poke_flutter_bloc/pokemons/all/screen_pokemons.dart';
import 'package:poke_flutter_bloc/pokemons/favourite/screen_favourite.dart';

List<Widget> _widgetOptions = <Widget>[
  const PokemonsScreen(),
  const FavouriteScreen(),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          onTap: (value) async {
            _selectedIndex = value;
            pageController.animateToPage(
              value,
              duration: Durations.medium2,
              curve: Curves.easeInOut,
            );
            setState(() {});
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Pokemons',
              icon: Icon(
                Icons.home_rounded,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Favourite',
              icon: Icon(
                Icons.favorite_rounded,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            _selectedIndex = value;
            setState(() {});
          },
          controller: pageController,
          children: _widgetOptions,
        ),
      ),
    );
  }
}
