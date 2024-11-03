import 'package:flutter/material.dart';

class PokeCard extends StatelessWidget {
  const PokeCard({
    super.key,
    required this.name,
    required this.type,
    required this.heroPrefix,
    this.onTap,
  });

  final String name;
  final String type;
  final String heroPrefix;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Stack(
          children: [
            Hero(
              tag: '${heroPrefix}_$name',
              child: Image.network(
                'https://img.pokemondb.net/artwork/$name.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                height: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    // pokemon.name!.capitalize(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Text(
                  type,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
