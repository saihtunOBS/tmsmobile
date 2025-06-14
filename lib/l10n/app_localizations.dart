import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my')
  ];

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get name;

  /// No description provided for @kHomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get kHomeLabel;

  /// No description provided for @kNotiLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get kNotiLabel;

  /// No description provided for @kProfileLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get kProfileLabel;

  /// No description provided for @kAppLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenant - Property\nManagement System'**
  String get kAppLabel;

  /// No description provided for @kLoginToYourAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Login to Your Account'**
  String get kLoginToYourAccountLabel;

  /// No description provided for @kPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get kPhoneNumberLabel;

  /// No description provided for @kPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get kPasswordLabel;

  /// No description provided for @kTermAndConditionLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms & Condition'**
  String get kTermAndConditionLabel;

  /// No description provided for @kContinueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get kContinueLabel;

  /// No description provided for @kLoginLabel.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get kLoginLabel;

  /// No description provided for @kLogoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get kLogoutLabel;

  /// No description provided for @kBackLabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get kBackLabel;

  /// No description provided for @kChangeYourPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Your Password'**
  String get kChangeYourPasswordLabel;

  /// No description provided for @kNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get kNewPasswordLabel;

  /// No description provided for @kOldPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get kOldPasswordLabel;

  /// No description provided for @kConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get kConfirmPasswordLabel;

  /// No description provided for @kYourPasswordMustContainLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Passsword Must Contain:'**
  String get kYourPasswordMustContainLabel;

  /// No description provided for @kCharacterLabel.
  ///
  /// In en, this message translates to:
  /// **'Between 8 and 20 characters'**
  String get kCharacterLabel;

  /// No description provided for @kUppercaseLetterLabel.
  ///
  /// In en, this message translates to:
  /// **'1 uppercase letter'**
  String get kUppercaseLetterLabel;

  /// No description provided for @kOneOrMoreNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'1 or more numbers'**
  String get kOneOrMoreNumberLabel;

  /// No description provided for @kOneOrMoreSpecialCharacterLabel.
  ///
  /// In en, this message translates to:
  /// **'1 or more special characters'**
  String get kOneOrMoreSpecialCharacterLabel;

  /// No description provided for @kConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get kConfirmLabel;

  /// No description provided for @kCloseLabel.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get kCloseLabel;

  /// No description provided for @kForgotPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get kForgotPasswordLabel;

  /// No description provided for @kEnterYourPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Phone Number'**
  String get kEnterYourPhoneNumberLabel;

  /// No description provided for @kSendOTPTextLabel.
  ///
  /// In en, this message translates to:
  /// **'We will send an One Time Password (OTP) on this phone number.'**
  String get kSendOTPTextLabel;

  /// No description provided for @kSendLabel.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get kSendLabel;

  /// No description provided for @kVerificationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get kVerificationCodeLabel;

  /// No description provided for @kSendCodeToNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'We will send a verification code to the number'**
  String get kSendCodeToNumberLabel;

  /// No description provided for @kExpireIn.
  ///
  /// In en, this message translates to:
  /// **'Expired in'**
  String get kExpireIn;

  /// No description provided for @kDidNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get kDidNotReceiveCode;

  /// No description provided for @kResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get kResend;

  /// No description provided for @kResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Your Password'**
  String get kResetPassword;

  /// No description provided for @kContractLabel.
  ///
  /// In en, this message translates to:
  /// **'Contracts'**
  String get kContractLabel;

  /// No description provided for @kBillingLabel.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get kBillingLabel;

  /// No description provided for @kMaintenanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get kMaintenanceLabel;

  /// No description provided for @kFillOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Fit Out'**
  String get kFillOutLabel;

  /// No description provided for @kServiceRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Request'**
  String get kServiceRequestLabel;

  /// No description provided for @kCompliantLabel.
  ///
  /// In en, this message translates to:
  /// **'Compliants'**
  String get kCompliantLabel;

  /// No description provided for @kWriteComplainLabel.
  ///
  /// In en, this message translates to:
  /// **'Write complaint....'**
  String get kWriteComplainLabel;

  /// No description provided for @kParkingLabel.
  ///
  /// In en, this message translates to:
  /// **'Car Parking'**
  String get kParkingLabel;

  /// No description provided for @kAnnouncementLabel.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get kAnnouncementLabel;

  /// No description provided for @kContractInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'Contract Information'**
  String get kContractInformationLabel;

  /// No description provided for @kCreatedDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Created Date'**
  String get kCreatedDateLabel;

  /// No description provided for @kTenantTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenant Type'**
  String get kTenantTypeLabel;

  /// No description provided for @kTenantCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenant Category'**
  String get kTenantCategoryLabel;

  /// No description provided for @kStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get kStartDateLabel;

  /// No description provided for @kEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get kEndDateLabel;

  /// No description provided for @kRoomShopNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Room / Shop Name'**
  String get kRoomShopNameLabel;

  /// No description provided for @kSelectRoomShopLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Room / Shop Name'**
  String get kSelectRoomShopLabel;

  /// No description provided for @kSelectTypeIssueLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Type of Issue'**
  String get kSelectTypeIssueLabel;

  /// No description provided for @kBranchLabel.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get kBranchLabel;

  /// No description provided for @kBuildingLabel.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get kBuildingLabel;

  /// No description provided for @kFloorLabel.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get kFloorLabel;

  /// No description provided for @kZoneViewLabel.
  ///
  /// In en, this message translates to:
  /// **'Zone / View'**
  String get kZoneViewLabel;

  /// No description provided for @kRoomTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Room / Type'**
  String get kRoomTypeLabel;

  /// No description provided for @kTotalAreaLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Area'**
  String get kTotalAreaLabel;

  /// No description provided for @kParkingCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Parking Code'**
  String get kParkingCodeLabel;

  /// No description provided for @kStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get kStatusLabel;

  /// No description provided for @kVehicleNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle No.'**
  String get kVehicleNoLabel;

  /// No description provided for @kParkingInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'Parking Information'**
  String get kParkingInformationLabel;

  /// No description provided for @kNoInvoiceHistoryLabel.
  ///
  /// In en, this message translates to:
  /// **'No Invoice History'**
  String get kNoInvoiceHistoryLabel;

  /// No description provided for @kThereIsNoInvoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no invoice history to show right now.'**
  String get kThereIsNoInvoiceLabel;

  /// No description provided for @kDueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due Date : '**
  String get kDueDateLabel;

  /// No description provided for @kDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get kDetailLabel;

  /// No description provided for @kViewDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get kViewDetailLabel;

  /// No description provided for @kMaintenanceInvoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Invoice'**
  String get kMaintenanceInvoiceLabel;

  /// No description provided for @kMaintenanceProcessLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Process'**
  String get kMaintenanceProcessLabel;

  /// No description provided for @kMaintenanceRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Request'**
  String get kMaintenanceRequestLabel;

  /// No description provided for @kTransactionTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get kTransactionTypeLabel;

  /// No description provided for @kPaymentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get kPaymentTypeLabel;

  /// No description provided for @kPaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get kPaymentLabel;

  /// No description provided for @kTotalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get kTotalAmountLabel;

  /// No description provided for @kTransactionTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Transaction Time'**
  String get kTransactionTimeLabel;

  /// No description provided for @kInvoiceNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice No.'**
  String get kInvoiceNoLabel;

  /// No description provided for @kTenantNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenant Name'**
  String get kTenantNameLabel;

  /// No description provided for @kDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get kDateLabel;

  /// No description provided for @kServicingDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Servicing Date'**
  String get kServicingDateLabel;

  /// No description provided for @kMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get kMonthLabel;

  /// No description provided for @kDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get kDescriptionLabel;

  /// No description provided for @kWriteDescriptionHereLabel.
  ///
  /// In en, this message translates to:
  /// **'Write description here..'**
  String get kWriteDescriptionHereLabel;

  /// No description provided for @kUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get kUnitLabel;

  /// No description provided for @kYesbLabel.
  ///
  /// In en, this message translates to:
  /// **'YESB'**
  String get kYesbLabel;

  /// No description provided for @kQtyLabel.
  ///
  /// In en, this message translates to:
  /// **'QTY'**
  String get kQtyLabel;

  /// No description provided for @kTaxPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax(%)'**
  String get kTaxPercentLabel;

  /// No description provided for @kRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get kRateLabel;

  /// No description provided for @kRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get kRatingLabel;

  /// No description provided for @kAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get kAmountLabel;

  /// No description provided for @kSubTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get kSubTotal;

  /// No description provided for @kTaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get kTaxLabel;

  /// No description provided for @kLateFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Late Fee'**
  String get kLateFeeLabel;

  /// No description provided for @kGrandTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get kGrandTotalLabel;

  /// No description provided for @kPartiallyPaidHistoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Partially Paid History'**
  String get kPartiallyPaidHistoryLabel;

  /// No description provided for @kPartiallyAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Partially Amount'**
  String get kPartiallyAmountLabel;

  /// No description provided for @kRemainingAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining Amount'**
  String get kRemainingAmountLabel;

  /// No description provided for @kViewInvoiceDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'View Invoice Details'**
  String get kViewInvoiceDetailLabel;

  /// No description provided for @kInvoiceDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get kInvoiceDetailLabel;

  /// No description provided for @kMakePaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get kMakePaymentLabel;

  /// No description provided for @kMonthlyInvoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly Invoice'**
  String get kMonthlyInvoiceLabel;

  /// No description provided for @kRentalFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Rental Fee'**
  String get kRentalFeeLabel;

  /// No description provided for @kCommercialTaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Commercial Tax'**
  String get kCommercialTaxLabel;

  /// No description provided for @kAdvertisingFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Advertising Fee'**
  String get kAdvertisingFeeLabel;

  /// No description provided for @kCleanAndSecurityFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Cleaning & Security Fee'**
  String get kCleanAndSecurityFeeLabel;

  /// No description provided for @kAirconAndElevatorFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Air-con & Elevator Fee'**
  String get kAirconAndElevatorFeeLabel;

  /// No description provided for @kPetAndMosquitoControlLabel.
  ///
  /// In en, this message translates to:
  /// **'Pets & Mosquito Control'**
  String get kPetAndMosquitoControlLabel;

  /// No description provided for @kBillBoardAdvertisingChargeLabel.
  ///
  /// In en, this message translates to:
  /// **'Bill Board Advertising Charge'**
  String get kBillBoardAdvertisingChargeLabel;

  /// No description provided for @kPreviousMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Previous Month'**
  String get kPreviousMonthLabel;

  /// No description provided for @kThisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get kThisMonthLabel;

  /// No description provided for @kElectricFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Electric Fee'**
  String get kElectricFeeLabel;

  /// No description provided for @kTypeOfIssueLabel.
  ///
  /// In en, this message translates to:
  /// **'Type of Issue'**
  String get kTypeOfIssueLabel;

  /// No description provided for @kAttachFileLabel.
  ///
  /// In en, this message translates to:
  /// **'Attach File'**
  String get kAttachFileLabel;

  /// No description provided for @kUploadPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get kUploadPhotoLabel;

  /// No description provided for @kLimitedPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Limited Photo'**
  String get kLimitedPhotoLabel;

  /// No description provided for @kUploadImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get kUploadImageLabel;

  /// No description provided for @kUploadLabel.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get kUploadLabel;

  /// No description provided for @kSendRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get kSendRequestLabel;

  /// No description provided for @kPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get kPendingLabel;

  /// No description provided for @kSurveyLabel.
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get kSurveyLabel;

  /// No description provided for @kQuotationLabel.
  ///
  /// In en, this message translates to:
  /// **'Quotation'**
  String get kQuotationLabel;

  /// No description provided for @kAcceptRejectLabel.
  ///
  /// In en, this message translates to:
  /// **'Accept/Reject'**
  String get kAcceptRejectLabel;

  /// No description provided for @kProcessingLabel.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get kProcessingLabel;

  /// No description provided for @kFinishLabel.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get kFinishLabel;

  /// No description provided for @kSurveyStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Survey State'**
  String get kSurveyStateLabel;

  /// No description provided for @kQuotationStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Quotation State'**
  String get kQuotationStateLabel;

  /// No description provided for @kDecisionStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Decision State'**
  String get kDecisionStateLabel;

  /// No description provided for @kProcessingStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Processing State'**
  String get kProcessingStateLabel;

  /// No description provided for @kSuccessFinishLabel.
  ///
  /// In en, this message translates to:
  /// **'Successfully Finished'**
  String get kSuccessFinishLabel;

  /// No description provided for @kIDLabel.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get kIDLabel;

  /// No description provided for @kAcceptLabel.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get kAcceptLabel;

  /// No description provided for @kRejectLabel.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get kRejectLabel;

  /// No description provided for @kSolvedLabel.
  ///
  /// In en, this message translates to:
  /// **'Solved'**
  String get kSolvedLabel;

  /// No description provided for @kHowWouldYouRateLabel.
  ///
  /// In en, this message translates to:
  /// **'How would you rate our services?'**
  String get kHowWouldYouRateLabel;

  /// No description provided for @kSatisfiedLabel.
  ///
  /// In en, this message translates to:
  /// **'Satisfied'**
  String get kSatisfiedLabel;

  /// No description provided for @kGoodLabel.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get kGoodLabel;

  /// No description provided for @kNeutralLabel.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get kNeutralLabel;

  /// No description provided for @kBadlabel.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get kBadlabel;

  /// No description provided for @kUnStatisfiedLabel.
  ///
  /// In en, this message translates to:
  /// **'UnStatisfied'**
  String get kUnStatisfiedLabel;

  /// No description provided for @kCarParkingLabel.
  ///
  /// In en, this message translates to:
  /// **'Car Parking'**
  String get kCarParkingLabel;

  /// No description provided for @kThereisNoInvoiceHistoryLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no Invoice history to show right now.'**
  String get kThereisNoInvoiceHistoryLabel;

  /// No description provided for @kNoServiceRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'No Service Request Here.'**
  String get kNoServiceRequestLabel;

  /// No description provided for @kThereisNoServiceRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no service request to show right now.'**
  String get kThereisNoServiceRequestLabel;

  /// No description provided for @kNoNotificationLabel.
  ///
  /// In en, this message translates to:
  /// **'No Notification Here.'**
  String get kNoNotificationLabel;

  /// No description provided for @kThereisNoNotificationLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no notification to show right now.'**
  String get kThereisNoNotificationLabel;

  /// No description provided for @kNoAnnouncementLabel.
  ///
  /// In en, this message translates to:
  /// **'No Announcement Here.'**
  String get kNoAnnouncementLabel;

  /// No description provided for @kThereisNoAnnouncementLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no announcement to show right now.'**
  String get kThereisNoAnnouncementLabel;

  /// No description provided for @kNewNotificationLabel.
  ///
  /// In en, this message translates to:
  /// **'  New Nofitications  '**
  String get kNewNotificationLabel;

  /// No description provided for @kApprovedLabel.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get kApprovedLabel;

  /// No description provided for @kDepositLabel.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get kDepositLabel;

  /// No description provided for @kExtensionDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Extension Days'**
  String get kExtensionDayLabel;

  /// No description provided for @kDayExtensionDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day Extension'**
  String get kDayExtensionDayLabel;

  /// No description provided for @kViewProfileLabel.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get kViewProfileLabel;

  /// No description provided for @kChangePasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get kChangePasswordLabel;

  /// No description provided for @kEmergencyContactLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get kEmergencyContactLabel;

  /// No description provided for @kHouseholdLabel.
  ///
  /// In en, this message translates to:
  /// **'Household Registration'**
  String get kHouseholdLabel;

  /// No description provided for @kLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get kLanguageLabel;

  /// No description provided for @kDeleteAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get kDeleteAccountLabel;

  /// No description provided for @kConfirmLogoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get kConfirmLogoutLabel;

  /// No description provided for @kAreYouSureLogoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get kAreYouSureLogoutLabel;

  /// No description provided for @kAreYouSureDeleteAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete permanently?'**
  String get kAreYouSureDeleteAccountLabel;

  /// No description provided for @kCancelLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get kCancelLabel;

  /// No description provided for @kOkLabel.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get kOkLabel;

  /// No description provided for @choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get choose_language;

  /// No description provided for @kEnglishlabel.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get kEnglishlabel;

  /// No description provided for @kMyanmarLabel.
  ///
  /// In en, this message translates to:
  /// **'Myanmar (Unicode)'**
  String get kMyanmarLabel;

  /// No description provided for @kPropertyManagementLabel.
  ///
  /// In en, this message translates to:
  /// **'Property Management'**
  String get kPropertyManagementLabel;

  /// No description provided for @kPoliceStationLabel.
  ///
  /// In en, this message translates to:
  /// **'Police Station'**
  String get kPoliceStationLabel;

  /// No description provided for @kFireStationLabel.
  ///
  /// In en, this message translates to:
  /// **'Fire Station'**
  String get kFireStationLabel;

  /// No description provided for @kEpcLabel.
  ///
  /// In en, this message translates to:
  /// **'EPC'**
  String get kEpcLabel;

  /// No description provided for @kCustomerServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Service'**
  String get kCustomerServiceLabel;

  /// No description provided for @kContactNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Name :'**
  String get kContactNameLabel;

  /// No description provided for @kAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address :'**
  String get kAddressLabel;

  /// No description provided for @kTelephoneNormalLabel.
  ///
  /// In en, this message translates to:
  /// **'Telephone Normal Hours :'**
  String get kTelephoneNormalLabel;

  /// No description provided for @kTelephoneNormal24Label.
  ///
  /// In en, this message translates to:
  /// **'Telephone Normal 24 Hours :'**
  String get kTelephoneNormal24Label;

  /// No description provided for @kContractRefLabel.
  ///
  /// In en, this message translates to:
  /// **'Contract Ref :'**
  String get kContractRefLabel;

  /// No description provided for @kRegistrationDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Registration Date'**
  String get kRegistrationDateLabel;

  /// No description provided for @kMoveInDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Move In Date'**
  String get kMoveInDateLabel;

  /// No description provided for @kGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get kGenderLabel;

  /// No description provided for @kSelectGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get kSelectGenderLabel;

  /// No description provided for @kDobLabel.
  ///
  /// In en, this message translates to:
  /// **'DOB (dd/mm/yy)'**
  String get kDobLabel;

  /// No description provided for @kRaceLabel.
  ///
  /// In en, this message translates to:
  /// **'Race'**
  String get kRaceLabel;

  /// No description provided for @kNationalityLabel.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get kNationalityLabel;

  /// No description provided for @kNRCLabel.
  ///
  /// In en, this message translates to:
  /// **'NRC (or) Passport'**
  String get kNRCLabel;

  /// No description provided for @kContactNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get kContactNumberLabel;

  /// No description provided for @kEmailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'E-mail Address'**
  String get kEmailAddressLabel;

  /// No description provided for @kRelatedToOwnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Related to Owner'**
  String get kRelatedToOwnerLabel;

  /// No description provided for @kNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get kNameLabel;

  /// No description provided for @kOwnerInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner Information'**
  String get kOwnerInformationLabel;

  /// No description provided for @kEmergencyContactNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Number'**
  String get kEmergencyContactNumberLabel;

  /// No description provided for @kOwnerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get kOwnerNameLabel;

  /// No description provided for @kResidentDataLabel.
  ///
  /// In en, this message translates to:
  /// **'Resident Data'**
  String get kResidentDataLabel;

  /// No description provided for @kAddResidentLabel.
  ///
  /// In en, this message translates to:
  /// **'+ Add Resident'**
  String get kAddResidentLabel;

  /// No description provided for @kSelectDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get kSelectDateLabel;

  /// No description provided for @kSubmitLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get kSubmitLabel;

  /// No description provided for @kChangeProfileLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Profile'**
  String get kChangeProfileLabel;

  /// No description provided for @kCityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get kCityLabel;

  /// No description provided for @kTownshipLabel.
  ///
  /// In en, this message translates to:
  /// **'Township'**
  String get kTownshipLabel;

  /// No description provided for @kNoOfPropertyLabel.
  ///
  /// In en, this message translates to:
  /// **'No. of properties'**
  String get kNoOfPropertyLabel;

  /// No description provided for @kAgreementLabel.
  ///
  /// In en, this message translates to:
  /// **'Agreement'**
  String get kAgreementLabel;

  /// No description provided for @kTremOfServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get kTremOfServiceLabel;

  /// No description provided for @kLastUpdateOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Last updated on'**
  String get kLastUpdateOnLabel;

  /// No description provided for @kEditLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get kEditLabel;

  /// No description provided for @kSendCompliantLabel.
  ///
  /// In en, this message translates to:
  /// **'Send Complaint'**
  String get kSendCompliantLabel;

  /// No description provided for @kReadMoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get kReadMoreLabel;

  /// No description provided for @kNoRegisterYetLabel.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t registered yet.'**
  String get kNoRegisterYetLabel;

  /// No description provided for @kHouseholdRegistrationFormLabel.
  ///
  /// In en, this message translates to:
  /// **'Household Registration Form'**
  String get kHouseholdRegistrationFormLabel;

  /// No description provided for @kEmptyComplaintLabel.
  ///
  /// In en, this message translates to:
  /// **'No Complaints.'**
  String get kEmptyComplaintLabel;

  /// No description provided for @kThereIsNoComplaintLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no complaints to show right now.'**
  String get kThereIsNoComplaintLabel;

  /// No description provided for @kEmergencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get kEmergencyLabel;

  /// No description provided for @kResidentInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'Resident Information'**
  String get kResidentInformationLabel;

  /// No description provided for @kFillOutProcessLabel.
  ///
  /// In en, this message translates to:
  /// **'Fit Out Process'**
  String get kFillOutProcessLabel;

  /// No description provided for @kFillOutRequestLabel.
  ///
  /// In en, this message translates to:
  /// **'Fit Out Request'**
  String get kFillOutRequestLabel;

  /// No description provided for @kTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get kTypeLabel;

  /// No description provided for @kSettingLabel.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get kSettingLabel;

  /// No description provided for @kPasswordCriteiraLabel.
  ///
  /// In en, this message translates to:
  /// **'*Password does not meet the required criteria'**
  String get kPasswordCriteiraLabel;

  /// No description provided for @kAddNrcLabel.
  ///
  /// In en, this message translates to:
  /// **'Add NRC number'**
  String get kAddNrcLabel;

  /// No description provided for @kEntereNrcLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter NRC number'**
  String get kEntereNrcLabel;

  /// No description provided for @kPleaseSelectNrcLabel.
  ///
  /// In en, this message translates to:
  /// **'* Please select your NRC and enter 6 number.'**
  String get kPleaseSelectNrcLabel;

  /// No description provided for @kPassportLabel.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get kPassportLabel;

  /// No description provided for @kCameraLabel.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get kCameraLabel;

  /// No description provided for @kOrLabel.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get kOrLabel;

  /// No description provided for @kGalleryLabel.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get kGalleryLabel;

  /// No description provided for @kChooseOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose an Option'**
  String get kChooseOptionLabel;

  /// No description provided for @kSelectOneOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Select one of the options below.'**
  String get kSelectOneOptionLabel;

  /// No description provided for @kSessionExpireLabel.
  ///
  /// In en, this message translates to:
  /// **'Your session have expired. Please Login again.!'**
  String get kSessionExpireLabel;

  /// No description provided for @kPasswordDoesNotMatchLabel.
  ///
  /// In en, this message translates to:
  /// **'Password does not match!'**
  String get kPasswordDoesNotMatchLabel;

  /// No description provided for @kNoContractLabel.
  ///
  /// In en, this message translates to:
  /// **'No contracts.'**
  String get kNoContractLabel;

  /// No description provided for @kThereIsNoContractLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no contracts to show right now.'**
  String get kThereIsNoContractLabel;

  /// No description provided for @kNoParkingLabel.
  ///
  /// In en, this message translates to:
  /// **'No parking.'**
  String get kNoParkingLabel;

  /// No description provided for @kThereIsNoParkingLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no parking to show right now.'**
  String get kThereIsNoParkingLabel;

  /// No description provided for @kNoEmergencyLabel.
  ///
  /// In en, this message translates to:
  /// **'No emergency contacts.'**
  String get kNoEmergencyLabel;

  /// No description provided for @kThereIsNoEmergencyLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no emergency contacts to show right now.'**
  String get kThereIsNoEmergencyLabel;

  /// No description provided for @kNoBillingLabel.
  ///
  /// In en, this message translates to:
  /// **'No Billing.'**
  String get kNoBillingLabel;

  /// No description provided for @kThereIsNoBillingLabel.
  ///
  /// In en, this message translates to:
  /// **'There is no billing to show right now.'**
  String get kThereIsNoBillingLabel;

  /// No description provided for @kBookingLabel.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get kBookingLabel;

  /// No description provided for @kFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get kFromLabel;

  /// No description provided for @kToLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get kToLabel;

  /// No description provided for @kNoFoGuestLabel.
  ///
  /// In en, this message translates to:
  /// **'No. of Guests'**
  String get kNoFoGuestLabel;

  /// No description provided for @kReserveLabel.
  ///
  /// In en, this message translates to:
  /// **'Reserve'**
  String get kReserveLabel;

  /// No description provided for @kYouWontBeChargeYetLabel.
  ///
  /// In en, this message translates to:
  /// **'You won\'t be charge yet.'**
  String get kYouWontBeChargeYetLabel;

  /// No description provided for @kTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get kTotalLabel;

  /// No description provided for @kClickToSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Click to select.'**
  String get kClickToSelectLabel;

  /// No description provided for @kSelectDateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date & Time'**
  String get kSelectDateTimeLabel;

  /// No description provided for @kSelectTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get kSelectTimeLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
