import 'package:flutter/material.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showProfileAction;
  final Color titleColor;
  const SharedAppBar(
      {super.key,
      required this.title,
      this.showProfileAction = true,
      required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          const Expanded(child: SizedBox()),
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                showProfileAction
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/app_options');
                        },
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/cat_profile_img.jpg',
                              semanticLabel: 'Image du profil',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
