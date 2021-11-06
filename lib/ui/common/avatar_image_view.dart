import 'package:flutter/material.dart';

class AvatartImageView extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AvatartImageView({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              height: 180,
              width: 180,
              child: child,
            ),
          ),
          Positioned(
            bottom: -15,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
