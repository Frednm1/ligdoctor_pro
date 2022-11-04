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
      onTap: () {},
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
              width: displaySize.width * .2,
              padding: const EdgeInsets.all(8),
              child: Image.asset(src),
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

// _selectedCategory(BuildContext context, String category) {
//   final String route;
//   switch (category) {
//     case 'Teleconsulta':
//       {
//         route = Routes.loadTeleconsultation;
//       }
//       break;
    
//     case 'Orientação em saúde':
//       {
//         route = Routes.loadingHealthOrientation;
//       }
//       break;

//     case 'Suporte':
//       {
//         route = Routes.support;
//       }
//       break;

//     default:
//       {
//         route = '/';
//       }
//       break;
//   }
//   Navigator.of(context).pushNamed(route);
// }