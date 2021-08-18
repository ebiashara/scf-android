final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your username";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kOtpNullError = "Please enter a valid OTP";

class Constants {
  //appbar
  static const String profile = 'Profile';
  static const String logout = 'Logout';

  //currency
  static const String kenyan_currency = 'KES';
  static const String sa_currency = 'RAND';

  static const List<String> barChoices = <String>[profile, logout];
  static const List<String> currencies = <String>[kenyan_currency, sa_currency];

  // Dashboard Constants
  static const String amount_financed = 'Amount Financed';
  static const String tasks = 'Tasks';

  static const String documents = 'Documents';
  static const String overdue_transactions_title = "Overdue Transactions";
  static const String overdue_transactions = "       Overdue\n   Transactions ";
  static const String upcoming_settlements_title = "Upcoming Settlements";
  static const String upcoming_settlements = "   Upcoming\n  Settlements";
  static const String summary = 'Summarry';
  static const String invoice_financed = 'Invoice Financed';
  static const String invoice_discounted = 'Invoice Discounted';
  static const String customer = 'Customer';
  static const String amount = 'Amount';
  static const String due_date = 'Due Date';

  //onboarding
  static const String sign_in = 'Welcome back';
  static const String login = 'Login';
  static const String remember_me = "Remember me";
  static const String forgot_password = "Forgot Password?";
  static const String find_your_password = "Recover your password";
  static const String sign_in_title =
      "Sign in with your email/phone number and password";
  static const String send = "Send";
  static const String cancel = "Cancel";
  static const String forgot_password_title =
      "Enter yoour username/phone number and a password recovery link will be sent to you";
  static const String otp_sent = "User found OTP has been sent.";
  static const String ok = "Ok";
  static const String confirm = "Confirm";
  static const String login_failed = "Login Failed";
  static const String user_not_found = "User Not Found";
  static const String otp_failed = "OTP verification Failed";
  static const String verify_otp = "Verify OTP";
  static const String otp_title = "Enter the 5 digit PIN sent to you";
  static const String otp_verified = "OTP Verified";
  static const String invalid_otp = "Invalid OTP";
  static const String new_password = "Enter new password";
  static const String confirm_password = "Confirm  password";
  static const String password = "Enter  password";
  static const String username = "Enter  username";
  static const String reset_title = "Enter your new password to reset";
  static const String reset = "Reset Password";
  static const String reset_text = "Reset";
  static const String success = "Success";
  static const String fail = "Fail";
  static const String password_reset_failed = "Password Reset \n Failed";
  static const String password_reset_succes = "Password Reset \n Successfuly";

  //Table
  static const String ref_no = "Ref No";
  static const String status = "Status";

  static const String task_details = "Task Details";
  static const String buyer = "Buyer: ";
  static const String date_received = "Date Received :";
  static const String financial_info = 'Financial Information';
  static const String max_tenor = "Maximum Tenor:";
  static const String financial_tenor = "Financial Tenor:";
  static const String net_amount = "Net Amount";
  static const String total = "Total";

  //Approval

  static const String buyer_approved = "Buyer Approved";
  static const String send_discount_request = "Send Discount Request";
  static const String sent_to_financier = 'Sent To Financier';
  static const String last_status = "Last Status: ";
  static const String requested_by = "Requested By: ";
  static const String draft = "Draft";
  static const String check = "Check";
  static const String checked = "Checked";
  static const String rejected = "Reject";
  static const String checker_rejected = "Checker Rejected";
  static const String checked_by = "Checked By: ";
  static const String approved_by = "Approved By: ";
  static const String buyer_approved_by = "Buyer Approved By: ";
  static const String approver = "Approver";
  static const String maker = "Maker";
  static const String checker = "Checker";
  static const String approve = "Approve";
  static const String maker_checker = "Maker-Checker";
  static const String maker_approver = "Maker-Approver";
  static const String approver_approved = 'Approver Approved';
  static const String approver_rejected = "Approver Rejected";
  static const String buyer_rejected = 'Buyer Rejected';
  static const String maker_checker_approver = "Maker-Checker-Approver";

  //Profile
  static const String profile_firstname = 'First name';
  static const String profile_lastname = 'Last name';
  static const String profile_title = 'Title';
  static const String company_name = "Company Name";
  static const String email_address = 'Email Address';
  static const String phone_number = "Phone Number";
  static const String alt_phone_number = "Alternate Contact No";
  static const String role_name = "Role Name";
  static const String news_letter = "News letter";
  static const String email_subscription = "Email Subscription";
  static const String edit = 'Edit';
  static const String update_profile = 'Update Profile';

  //bottom nnav

  static const String settings = 'Settings';
  static const String home = 'Home';
  static const String quick_document = "Quick Document";
  static const String product = 'Product';
  static const String select_product = 'Select Product';
  static const String financier = 'Financier';
  static const String select_financier = 'Select Financier';
  static const String select_buyer = 'Select Buyer';
  static const String seller = 'Seller';
  static const String select_seller = 'Select Seller';
  static const String supplier = 'Supplier';
  static const String contracts = 'Contracts';
  static const String select_contract = 'Select Contract';
  static const String currency = 'Currency';
  static const String doc_type = "Document Type";
  static const String ksh = 'KSH';
  static const String select_doc_type = "Select Document Type";
  static const String invoice = "Invoice";
  static const String doc_no_1 = "Document No 1";
  static const String doc_no = "Document No ";
  static const String doc_date = "Document Date";
  static const String date_format = 'yyyy-MM-dd';
  static const String maturity_date = "Maturity Date";
  static const String comments = "Comments";
  static const String approval_limit =
      "Please contact your Financier to increase your  approval \n limit for this contract.";

  static const String select_currency = "Select Currency";
  static const String date_error= "Date is not selected";
}
