// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Family Space`
  String get appBarHomePageTitle {
    return Intl.message(
      'Family Space',
      name: 'appBarHomePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Grocery`
  String get appBarGroceriePageTitle {
    return Intl.message(
      'Grocery',
      name: 'appBarGroceriePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available Tasks`
  String get appBarTaskPageTitle {
    return Intl.message(
      'Available Tasks',
      name: 'appBarTaskPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get appBarProfileTitle {
    return Intl.message(
      'Profile',
      name: 'appBarProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `About the Space Family app`
  String get appBaraboutUsPageTitle {
    return Intl.message(
      'About the Space Family app',
      name: 'appBaraboutUsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get bottomNavHome {
    return Intl.message(
      'Home',
      name: 'bottomNavHome',
      desc: '',
      args: [],
    );
  }

  /// `Space`
  String get bottomNavSpaceFamily {
    return Intl.message(
      'Space',
      name: 'bottomNavSpaceFamily',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get connexionPageTitle {
    return Intl.message(
      'Log In',
      name: 'connexionPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Always connect with your loved ones!`
  String get homePageSectionTitle1 {
    return Intl.message(
      'Always connect with your loved ones!',
      name: 'homePageSectionTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Easy grocery management, Yum !`
  String get homePageSectionTitle2 {
    return Intl.message(
      'Easy grocery management, Yum !',
      name: 'homePageSectionTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Better when organized as a family!`
  String get homePageSectionTitle3 {
    return Intl.message(
      'Better when organized as a family!',
      name: 'homePageSectionTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Stay updated on family events!`
  String get homePageSectionTitle4 {
    return Intl.message(
      'Stay updated on family events!',
      name: 'homePageSectionTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Overview of your family members!`
  String get homePageSectionTitle5 {
    return Intl.message(
      'Overview of your family members!',
      name: 'homePageSectionTitle5',
      desc: '',
      args: [],
    );
  }

  /// `Grocery list`
  String get homePageTitleGrocerieList {
    return Intl.message(
      'Grocery list',
      name: 'homePageTitleGrocerieList',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get homePageTitleTask {
    return Intl.message(
      'Tasks',
      name: 'homePageTitleTask',
      desc: '',
      args: [],
    );
  }

  /// `Ranking`
  String get homePageTitleRanking {
    return Intl.message(
      'Ranking',
      name: 'homePageTitleRanking',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get homePageTitleEvents {
    return Intl.message(
      'Events',
      name: 'homePageTitleEvents',
      desc: '',
      args: [],
    );
  }

  /// `What's missing in the fridge?`
  String get groceriePageTitle {
    return Intl.message(
      'What\'s missing in the fridge?',
      name: 'groceriePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add here any missing food items.`
  String get groceriePageSubTitle {
    return Intl.message(
      'Add here any missing food items.',
      name: 'groceriePageSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select the task that suits your availability`
  String get taskPageTitle {
    return Intl.message(
      'Select the task that suits your availability',
      name: 'taskPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get appOptionProfile {
    return Intl.message(
      'My Profile',
      name: 'appOptionProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Family`
  String get appOptionFamily {
    return Intl.message(
      'My Family',
      name: 'appOptionFamily',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get appOptionNotifications {
    return Intl.message(
      'Notifications',
      name: 'appOptionNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Edit My Profile`
  String get appOptionEditProfile {
    return Intl.message(
      'Edit My Profile',
      name: 'appOptionEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get appOptionDeconnexion {
    return Intl.message(
      'Log Out',
      name: 'appOptionDeconnexion',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get appOptionAboutUs {
    return Intl.message(
      'About Us',
      name: 'appOptionAboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Evaluations of {profileName}`
  String evaluationProfilePageTitle(Object profileName) {
    return Intl.message(
      'Evaluations of $profileName',
      name: 'evaluationProfilePageTitle',
      desc: '',
      args: [profileName],
    );
  }

  /// `Make a quick evaluation of {profileName}`
  String dialogQuickRatingTitle(Object profileName) {
    return Intl.message(
      'Make a quick evaluation of $profileName',
      name: 'dialogQuickRatingTitle',
      desc: '',
      args: [profileName],
    );
  }

  /// `Rate {profileName}`
  String dialogRatingTitle(Object profileName) {
    return Intl.message(
      'Rate $profileName',
      name: 'dialogRatingTitle',
      desc: '',
      args: [profileName],
    );
  }

  /// `My task details`
  String get dialogTaskDetailTitle {
    return Intl.message(
      'My task details',
      name: 'dialogTaskDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `We would like to hear from you`
  String get dialogUserSuggestionsTitle {
    return Intl.message(
      'We would like to hear from you',
      name: 'dialogUserSuggestionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please let us know your comments or suggestions`
  String get dialogUserSuggestionsSubTitle {
    return Intl.message(
      'Please let us know your comments or suggestions',
      name: 'dialogUserSuggestionsSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get labelUsername {
    return Intl.message(
      'Username',
      name: 'labelUsername',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get labelPasswordConfirm {
    return Intl.message(
      'Confirm your password',
      name: 'labelPasswordConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get labelRegisterPageTitle {
    return Intl.message(
      'Register',
      name: 'labelRegisterPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get labelRegisterPageBirthDate {
    return Intl.message(
      'Birth date',
      name: 'labelRegisterPageBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Register with`
  String get labelRegisterWith {
    return Intl.message(
      'Register with',
      name: 'labelRegisterWith',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get labelNew {
    return Intl.message(
      'New',
      name: 'labelNew',
      desc: '',
      args: [],
    );
  }

  /// `Qty`
  String get labelQuantityShorted {
    return Intl.message(
      'Qty',
      name: 'labelQuantityShorted',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get labelQuantityLong {
    return Intl.message(
      'Quantity',
      name: 'labelQuantityLong',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} mins ago`
  String labelMinutesPassed(Object minutes) {
    return Intl.message(
      '$minutes mins ago',
      name: 'labelMinutesPassed',
      desc: '',
      args: [minutes],
    );
  }

  /// `Sort   `
  String get labelSort {
    return Intl.message(
      'Sort   ',
      name: 'labelSort',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get labelSortBy {
    return Intl.message(
      'Sort by',
      name: 'labelSortBy',
      desc: '',
      args: [],
    );
  }

  /// `Purchased`
  String get labelAchat {
    return Intl.message(
      'Purchased',
      name: 'labelAchat',
      desc: '',
      args: [],
    );
  }

  /// `Food Name`
  String get labelFoodName {
    return Intl.message(
      'Food Name',
      name: 'labelFoodName',
      desc: '',
      args: [],
    );
  }

  /// `Description (optional)`
  String get labelDescriptionOptional {
    return Intl.message(
      'Description (optional)',
      name: 'labelDescriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get labelDescription {
    return Intl.message(
      'Description',
      name: 'labelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Automatic Message`
  String get labeAutomaticMessage {
    return Intl.message(
      'Automatic Message',
      name: 'labeAutomaticMessage',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get labelDaily {
    return Intl.message(
      'Daily',
      name: 'labelDaily',
      desc: '',
      args: [],
    );
  }

  /// `One Time`
  String get labelOneTime {
    return Intl.message(
      'One Time',
      name: 'labelOneTime',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get labelWeekly {
    return Intl.message(
      'Weekly',
      name: 'labelWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Annually`
  String get labelAnnually {
    return Intl.message(
      'Annually',
      name: 'labelAnnually',
      desc: '',
      args: [],
    );
  }

  /// `Periodic`
  String get labelPeriodic {
    return Intl.message(
      'Periodic',
      name: 'labelPeriodic',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get labelDay {
    return Intl.message(
      'Day',
      name: 'labelDay',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get labelWeek {
    return Intl.message(
      'Week',
      name: 'labelWeek',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get labelYear {
    return Intl.message(
      'Year',
      name: 'labelYear',
      desc: '',
      args: [],
    );
  }

  /// `What's new?`
  String get labelHintWhatsUp {
    return Intl.message(
      'What\'s new?',
      name: 'labelHintWhatsUp',
      desc: '',
      args: [],
    );
  }

  /// `What's your task?`
  String get labelHintTaskName {
    return Intl.message(
      'What\'s your task?',
      name: 'labelHintTaskName',
      desc: '',
      args: [],
    );
  }

  /// `Choose recurrence:`
  String get labelChooseRecurrence {
    return Intl.message(
      'Choose recurrence:',
      name: 'labelChooseRecurrence',
      desc: '',
      args: [],
    );
  }

  /// `Assigned Tasks`
  String get labelTaskOwned {
    return Intl.message(
      'Assigned Tasks',
      name: 'labelTaskOwned',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get labelDone {
    return Intl.message(
      'Done',
      name: 'labelDone',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get labelOr {
    return Intl.message(
      'Or',
      name: 'labelOr',
      desc: '',
      args: [],
    );
  }

  /// `Subtasks added`
  String get labelSubTaskAdded {
    return Intl.message(
      'Subtasks added',
      name: 'labelSubTaskAdded',
      desc: '',
      args: [],
    );
  }

  /// `What is your subtask ?`
  String get labelSubTaskHint {
    return Intl.message(
      'What is your subtask ?',
      name: 'labelSubTaskHint',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get labelError {
    return Intl.message(
      'Error',
      name: 'labelError',
      desc: '',
      args: [],
    );
  }

  /// `Your message...`
  String get labelHintMessage {
    return Intl.message(
      'Your message...',
      name: 'labelHintMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get labelYes {
    return Intl.message(
      'Yes',
      name: 'labelYes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get labelNon {
    return Intl.message(
      'No',
      name: 'labelNon',
      desc: '',
      args: [],
    );
  }

  /// `One or several fields can't be empty 😓`
  String get labelErrorFieldEmpty {
    return Intl.message(
      'One or several fields can\'t be empty 😓',
      name: 'labelErrorFieldEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Your answer...`
  String get labelYourAnswer {
    return Intl.message(
      'Your answer...',
      name: 'labelYourAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Your comment (Optional)`
  String get labelOptionalComment {
    return Intl.message(
      'Your comment (Optional)',
      name: 'labelOptionalComment',
      desc: '',
      args: [],
    );
  }

  /// `Well Done`
  String get labelBravo {
    return Intl.message(
      'Well Done',
      name: 'labelBravo',
      desc: '',
      args: [],
    );
  }

  /// `To be done by`
  String get labelToBeDoneBy {
    return Intl.message(
      'To be done by',
      name: 'labelToBeDoneBy',
      desc: '',
      args: [],
    );
  }

  /// `Late`
  String get labelTaksLate {
    return Intl.message(
      'Late',
      name: 'labelTaksLate',
      desc: '',
      args: [],
    );
  }

  /// `Give Up`
  String get labelTaskGiveUp {
    return Intl.message(
      'Give Up',
      name: 'labelTaskGiveUp',
      desc: '',
      args: [],
    );
  }

  /// `Set the recurrence of your task`
  String get labelPeriodicConfigure {
    return Intl.message(
      'Set the recurrence of your task',
      name: 'labelPeriodicConfigure',
      desc: '',
      args: [],
    );
  }

  /// `(optionnal)`
  String get labelOptionnal {
    return Intl.message(
      '(optionnal)',
      name: 'labelOptionnal',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get buttonConnexion {
    return Intl.message(
      'Log In',
      name: 'buttonConnexion',
      desc: '',
      args: [],
    );
  }

  /// `Log In with`
  String get buttonConnexionWith {
    return Intl.message(
      'Log In with',
      name: 'buttonConnexionWith',
      desc: '',
      args: [],
    );
  }

  /// `Join family space`
  String get buttonJoinSpace {
    return Intl.message(
      'Join family space',
      name: 'buttonJoinSpace',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get buttonSeeMore {
    return Intl.message(
      'See More',
      name: 'buttonSeeMore',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get buttonUploadImage {
    return Intl.message(
      'Upload Image',
      name: 'buttonUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Add Food`
  String get buttonAddFood {
    return Intl.message(
      'Add Food',
      name: 'buttonAddFood',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get buttonAdd {
    return Intl.message(
      'Add',
      name: 'buttonAdd',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get buttonCancel {
    return Intl.message(
      'Cancel',
      name: 'buttonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Add Sub-tasks`
  String get buttonAddSubTask {
    return Intl.message(
      'Add Sub-tasks',
      name: 'buttonAddSubTask',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get buttonSend {
    return Intl.message(
      'Send',
      name: 'buttonSend',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get buttonCreateAccont {
    return Intl.message(
      'Register',
      name: 'buttonCreateAccont',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get buttonSave {
    return Intl.message(
      'Save',
      name: 'buttonSave',
      desc: '',
      args: [],
    );
  }

  /// `Send your comments or suggestions`
  String get buttonSendCommentOrSuggestions {
    return Intl.message(
      'Send your comments or suggestions',
      name: 'buttonSendCommentOrSuggestions',
      desc: '',
      args: [],
    );
  }

  /// `I'll take care of it 😌`
  String get buttonOwnAtask {
    return Intl.message(
      'I\'ll take care of it 😌',
      name: 'buttonOwnAtask',
      desc: '',
      args: [],
    );
  }

  /// `Delete image`
  String get buttonDeleteImage {
    return Intl.message(
      'Delete image',
      name: 'buttonDeleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Joinde ma famille`
  String get buttonJoinMyFamily {
    return Intl.message(
      'Joinde ma famille',
      name: 'buttonJoinMyFamily',
      desc: '',
      args: [],
    );
  }

  /// `Tranfer`
  String get buttonTaskTransfer {
    return Intl.message(
      'Tranfer',
      name: 'buttonTaskTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Task is done! 👍`
  String get buttonTaskDone {
    return Intl.message(
      'Task is done! 👍',
      name: 'buttonTaskDone',
      desc: '',
      args: [],
    );
  }

  /// `Create un event`
  String get buttonCreateEvent {
    return Intl.message(
      'Create un event',
      name: 'buttonCreateEvent',
      desc: '',
      args: [],
    );
  }

  /// `Show Schedule`
  String get buttonShowSchedure {
    return Intl.message(
      'Show Schedule',
      name: 'buttonShowSchedure',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment`
  String get labelAddComment {
    return Intl.message(
      'Add a comment',
      name: 'labelAddComment',
      desc: '',
      args: [],
    );
  }

  /// `Your comment may be for an opinion, additional information about the event, a reminder or other.`
  String get labelCommentDescription {
    return Intl.message(
      'Your comment may be for an opinion, additional information about the event, a reminder or other.',
      name: 'labelCommentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment here...`
  String get labelYourCommentHere {
    return Intl.message(
      'Write your comment here...',
      name: 'labelYourCommentHere',
      desc: '',
      args: [],
    );
  }

  /// `Delete my comment`
  String get labelDeleteMyComment {
    return Intl.message(
      'Delete my comment',
      name: 'labelDeleteMyComment',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete your comment ?`
  String get lebelDeleteMyCommentDescription {
    return Intl.message(
      'Do you want to delete your comment ?',
      name: 'lebelDeleteMyCommentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get labelDelete {
    return Intl.message(
      'Delete',
      name: 'labelDelete',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to \n edit this anouncement ?`
  String get messageEditPost {
    return Intl.message(
      'Do you really want to \n edit this anouncement ?',
      name: 'messageEditPost',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to \n delete this anouncement ?`
  String get messageDeletePost {
    return Intl.message(
      'Do you really want to \n delete this anouncement ?',
      name: 'messageDeletePost',
      desc: '',
      args: [],
    );
  }

  /// `Task description cannot be empty`
  String get messageAddTaskDescription {
    return Intl.message(
      'Task description cannot be empty',
      name: 'messageAddTaskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sub-task name cannot be empty`
  String get messageSubTaskError {
    return Intl.message(
      'Sub-task name cannot be empty',
      name: 'messageSubTaskError',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to \n take on this task ?`
  String get messageOwnAtask {
    return Intl.message(
      'Do you really want to \n take on this task ?',
      name: 'messageOwnAtask',
      desc: '',
      args: [],
    );
  }

  /// `The Space Family app was designed and developed by Jean Pierre Nduwimana, a computer engineering student passionate about the world of mobile applications. The application was created in 2025 as part of his personal learning and his desire to acquire new skills. \n Jean Pierre put all his know-how and enthusiasm into the creation of this application, with the aim of offering a smooth and intuitive user experience. This application reflects his commitment to learning, experimenting and creating practical solutions that meet the needs of users. \n As a constantly evolving developer, Jean Pierre would be delighted to receive your comments and suggestions which will be essential for the continuous improvement of the application. Thank you for using the Espace Famille application and being part of this growing project!`
  String get AboutUsText {
    return Intl.message(
      'The Space Family app was designed and developed by Jean Pierre Nduwimana, a computer engineering student passionate about the world of mobile applications. The application was created in 2025 as part of his personal learning and his desire to acquire new skills. \n Jean Pierre put all his know-how and enthusiasm into the creation of this application, with the aim of offering a smooth and intuitive user experience. This application reflects his commitment to learning, experimenting and creating practical solutions that meet the needs of users. \n As a constantly evolving developer, Jean Pierre would be delighted to receive your comments and suggestions which will be essential for the continuous improvement of the application. Thank you for using the Espace Famille application and being part of this growing project!',
      name: 'AboutUsText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
