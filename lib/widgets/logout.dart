import 'package:flutter/material.dart';

/// A simple reusable logout button widget.
///
/// Provides an [onLogout] callback that will be invoked when the user
/// confirms they want to sign out. If [onLogout] is not provided the
/// widget will just pop the confirmation dialog.
class LogoutButton extends StatelessWidget {
  final VoidCallback? onLogout;
  final String? label;

  const LogoutButton({Key? key, this.onLogout, this.label}) : super(key: key);

  Future<void> _confirmAndLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm logout'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true) {
      if (onLogout != null) {
        onLogout!();
      } else {
        // Default behavior: just pop current route if any.
        Navigator.of(context).maybePop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _confirmAndLogout(context),
      icon: const Icon(Icons.logout),
      label: Text(label ?? 'Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
