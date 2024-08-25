## Flutter Expense Tracker
An Expense Tracker mobile application built with Flutter and Firebase that helps users track their expenses by adding, categorizing, and visualizing them. The app allows for easy expense management and provides features like adding new expenses, deleting expenses with an undo option, and visualizing expenses through charts.

## Features
Add Expenses: Easily add new expenses with details like title, amount, date, and category.

Delete Expenses with Undo: Delete an expense with the option to undo the deletion and restore the data.

Categorize Expenses: Categorize expenses under different categories such as Work, Leisure, Food, Travel, and Others.

Real-Time Data Sync: Syncs data in real-time with Firebase, allowing access from multiple devices.

Expense Visualization: View expenses in a visually intuitive chart format for better understanding and analysis.

Responsive UI: Adapts seamlessly to different screen sizes, providing a smooth user experience on both phones and tablets.

## Installation
To run the Expense Tracker app locally, follow these steps:

## Clone the repository:

bash

Copy code

git clone https://github.com/yourusername/flutter-expense-tracker.git

cd flutter-expense-tracker

## Install dependencies:

Ensure you have Flutter installed. If not, follow the instructions on the Flutter website.

## Then run:

bash

Copy code

flutter pub get

## Set up Firebase:

Create a new Firebase project at Firebase Console.

Add a new Android or iOS app to your Firebase project and follow the setup instructions.

Replace the google-services.json (for Android) or GoogleService-Info.plist (for iOS) in your Flutter project with the file downloaded from Firebase.

## Run the app:

bash

Copy code

flutter run

## Dependencies
Flutter: The framework for building the app.

Firebase: Used for backend services including Firestore for database management.

Cloud Firestore: To store and sync data in real-time.

Firebase Auth: (If implemented) For managing user authentication.

## Usage
 ## Adding an Expense:

Click the '+' button on the main screen.

Enter the expense details: title, amount, date, and category.

Press 'Save' to add the expense to the list and Firestore.

## Deleting an Expense:

Swipe left on any expense to delete it.

A Snackbar will appear with an 'Undo' option to restore the deleted expense.

## Viewing Expense Charts:

Navigate to the charts section to view your expenses visually categorized.

## Project Structure

flutter-expense-tracker/
├── lib/
│   ├── models/          # Data models (Expense model)
│   ├── widgets/         # UI components (ExpensesList, NewExpense, Chart)
│   ├── main.dart        # Main entry point
├── android/             # Android-specific files
├── ios/                 # iOS-specific files
├── pubspec.yaml         # Flutter project configurations and dependencies
└── README.md            # Project readme file


Contributions are welcome! Please fork the repository and submit a pull request for any feature enhancements or bug fixes.

## Acknowledgements
Flutter
Firebase
The Flutter Community

## Contact
For any questions or feedback, please reach out to amishatandon2003@gmail.com.
