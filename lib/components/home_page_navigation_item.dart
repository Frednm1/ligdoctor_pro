import 'package:flutter/material.dart';
import '../utils/routes.dart';

class HomePageNavigationItem extends StatelessWidget {
  const HomePageNavigationItem({
    Key? key,
    required this.category,
    required this.src,
  }) : super(key: key);
  final String category;
  final String src;

  @override
  Widget build(BuildContext context) {
    final Size displaySize = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _selectedCategory(context, category),
      child: Container(
        width: displaySize.width * .27,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              height: displaySize.height * .1,
              width: displaySize.width * .18,
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                src,
                scale: 1.5,
              ),
            ),
            SizedBox(
              width: displaySize.width * .25,
              height: displaySize.height * .05,
              child: Text(
                category,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

_selectedCategory(BuildContext context, String category) {
  final String route;
  switch (category) {
    case 'Teleconsulta':
      {
        route = Routes.teleconsults;
      }
      break;

    case 'Orientação em saúde':
      {
        route = Routes.healthOrientation;
      }
      break;

    case 'Ajuda e suporte':
      {
        route = Routes.support;
      }
      break;
    case 'Financeiro':
      {
        route = Routes.financial;
      }
      break;

    default:
      {
        route = Routes.home;
      }
      break;
  }
  Navigator.of(context).pushNamed(route);
}
