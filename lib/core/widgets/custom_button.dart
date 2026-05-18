import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;

  final VoidCallback onTap;

  final bool isLoading;

  const CustomButton({
    super.key,

    required this.title,

    required this.onTap,

    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      height: 55,

      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        child: isLoading
            ? const SizedBox(
                height: 24,

                width: 24,

                child: CircularProgressIndicator(
                  strokeWidth: 2,

                  color: Colors.white,
                ),
              )
            : Text(
                title,

                style: const TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.w600,

                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
