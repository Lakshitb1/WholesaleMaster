import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            //primary: Colors.black, // Text color
            side: const BorderSide(color: Colors.black12, width: 2.5), // Border color
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)), // Border radius
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
