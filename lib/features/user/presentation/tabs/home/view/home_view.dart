import 'package:flutter/cupertino.dart';
import 'package:hotel_app/core/utils/app_colors.dart';

import '../../../../../../core/utils/app_styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
       top: 60,
        bottom: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'let\'s\nExplore',
            style: AppStyles.settingsTabLabel.copyWith(
              fontSize: 30,
              color: AppColors.blue,
            ),
          ),
          const Spacer(),
          Text(
            'Most Popular',
            style: AppStyles.settingsTabLabel.copyWith(
              color: AppColors.blue,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          roomsList(),
        ],
      ),
    );
  }

  Widget roomItem() => Container(
        width: 250,
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1687960116497-0dc41e1808a2?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Room name',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Price')
                ],
              ),
            )
          ],
        ),
      );

  Widget roomsList() => SizedBox(
        height: 300,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => roomItem(),
          itemCount: 10,
          separatorBuilder: (context, index) => const SizedBox(
            width: 15,
          ),
        ),
      );
}
