import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemNavigator

class StartupErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry; // Callback function when the retry button is pressed

  /// Constructor
  const StartupErrorScreen({
    Key? key,
    required this.errorMessage,
    this.onRetry, // Make onRetry optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Ensure MaterialApp is used here if this screen is the root
      // Or use Scaffold without MaterialApp if it's part of an existing app structure
      // If used in runApp(), MaterialApp is necessary.
      debugShowCheckedModeBanner: false, // Hide debug banner
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0), // Add some padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // You can add an icon here
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 80,
                ),
                const SizedBox(height: 20),

                // Title (Optional)
                Text(
                  'Application Failed to Start',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // Error Message
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Retry Button (Only shown if onRetry callback is provided)
                if (onRetry != null) // Conditionally show the button
                  ElevatedButton(
                    onPressed: onRetry, // Call the provided callback
                    child: const Text('Retry'),
                  ),
                const SizedBox(height: 10),

                // Optional: Add an Exit button
                TextButton(
                  onPressed: () {
                    // Exit the application
                    SystemNavigator.pop(); // A common way to exit apps
                  },
                  child: const Text('Exit App'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}