import 'package:flutter/material.dart';

class Cardlist extends StatelessWidget {
  final String avatar;
  final String username;
  final void Function()? onTap;
  const Cardlist(
      {Key? key,
      required this.avatar,
      required this.username,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromRGBO(7, 7, 7, 1),
        margin: const EdgeInsets.fromLTRB(10, 4, 4, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatar),
                radius: 25,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  username,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Icon(
                Icons.arrow_right,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
