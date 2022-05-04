class LoginPageConstants {
  static const String heading = 'Login';
  static const String subheading = 'Login to your account';

  static const String errorMessage = 'Invalid email or password';

  static const String emailTextFieldLabel = 'Email';
  static const String passTextFieldLabel = 'Password';

  static const String logoUrl = 'assets/images/logo.jpeg';

  static const String buttonText = 'Login';
  static const String signupText = 'Don\'t have an account?';
  static const String signupButtonText = 'Sign up';
}

class SignupPageConstants {
  static const String heading = 'Sign Up';
  static const String subheading = 'Create a new account';

  static const String errorMessage =
      'Either invalid entries or user with entered email already exists';

  static const String firstNameTextFieldLabel = 'First Name';
  static const String lastNameTextFieldLabel = 'Last Name';
  static const String phoneTextFieldLabel = 'Phone Number';
  static const String emailTextFieldLabel = 'Email';
  static const String passTextFieldLabel = 'Password';
  static const String pharmacyNameLabel = 'Pharmacy\'s Legal Name';
  static const String pharmacyGstin = 'GSTIN';
  static const String pharmacyAddress = 'Phamacy\'s Address';
  static const String pharmacyCity = 'Pharmacy City';
  static const String pharmacyPinCode = 'Pharmacy Pin Code';

  static const String buttonText = 'Sign Up';
  static const String loginText = 'Already have an account?';
  static const String loginButtonText = 'Log in';
}

class BillingPageConstants {
  static const String appBarHeading = 'Generate Bill';
  static const String productName = 'Name';
  static const String price = 'Price';
  static const String paracetamol = 'Paracetamol';
  static const String quantityNumber = '0';
  static const String bottomSheetSearchBarHintText = 'Search Medicine';
  static const String bottomSheetDoneButtonText = 'Add to Bill';

  static const String networkErrorMessage =
      'An error occured. Please check your internet connectivity or contact customer support.';

  static const String billTotalLabel = 'Total';
}

class HomePageConstants {
  static const String replace = '_';
  static const String appBarGreeting = 'Welcome $replace!';

  static const String drawerHeading = '';
  static const String home = 'Home';
  static const String billHistory = 'Bill History';
  static const String analytics = 'Analytics';
  static const String notification = 'Notification';
  static const String generateBill = 'Generate Bill';
  static const String stockExplorer = 'Stock Explorer';
  static const String barcodeScanner = 'Barcode Scanner';
  static const String user = 'Profile';
  static const String help = 'Help';

  static const String logoUrl = 'assets/images/logo.jpeg';

  static const String billiingPageButtonLabel = "Bill";
  static const String scanPageButtonLabel = "Scan";
  static const String lowStockPageLabel = "Stock Notification Settings";

  static const String logOutButtonLabel = 'Log Out';
}

class LowStockPageConstants {
  static const String appBarTitle = 'Notification Settings';
  static const String loadErrorMessage =
      'Error loading preferences. Please check your internet connectivity.';

  static const String replace1 = '_ahfp4h';
  static const String replace2 = '_h4potiaw';
  static const String medicineTileHeading = '$replace1 by $replace2';
}

class ScannerPageConstants {
  static const String appBarHeading = 'Add Stock';
  static const String snackBarErrorMessage =
      'Some error occured while pushing to the database';

  static const String mfgDateHintText = 'Mfg.';
  static const String expDateHintText = 'Exp.';
  static const String costHintText = 'Cost';

  static const String productChoiceHeading = 'Choose the closest medicine';
  static const String productChoiceSubheading =
      'Unable to find exact match for barcode';

  static const String editingStateHeading = 'Scanned Item Details';
  static const String editingStateSubheading =
      'Please fill out the missing information';
  static const String barcodeEditingFieldLabel = 'Barcode';
  static const String nameEditingFieldLabel = 'Salt Name';
  static const String manufacturerEditingFieldLabel = 'Company';
  static const String mrpEditingFieldLabel = 'MRP';
  static const String editingDoneButtonLabel = 'Done';
}
