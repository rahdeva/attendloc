import 'package:attendloc/feature/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (controller) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Studyo.io Test',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}