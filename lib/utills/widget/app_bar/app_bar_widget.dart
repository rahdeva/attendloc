import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/resources/resources.dart';

class AppBarWidget{
  static AppBar defaultAppBar({
    Color? color,
    required Brightness brightness,
    ImageProvider? backImage,
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    List<Widget>? actions,
    Function()? backCallback,
    PreferredSizeWidget? bottom,
    required BuildContext context
  }){
    return AppBar(
      title: Text(
        title ?? '',
        style: titleStyle ??
          Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.textColour80
          ),
      ),
      centerTitle: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0.0,
      leading: InkWell(
        onTap: backCallback ?? () => Get.back(),
        child: backImage == null
          ? const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.textColour80,
            )
          : Image(
              image: backImage,
              width: 24,
              height: 24,
            ),
      ),
      actions: actions ?? [],
      bottom: bottom,
    );
  }

  // AppBar transparent with just Back Button
  static AppBar simple({
    required String titleString, 
    required BuildContext context
  }) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: AppColors.textColour80
      ),
      backgroundColor: Colors.transparent,
      title: Text(
        titleString,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 18,
          color: AppColors.textColour80
        ),
      ),
    );
  }
}