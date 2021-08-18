

import 'package:flutter/material.dart';
import 'pages/add_document/add_document_screen.dart';
import 'pages/overdue_transaction_screen.dart/overdue_screen.dart';
import 'pages/profile/profile_screen.dart';
import 'pages/upcoming_transaction_screen.dart/upcoming_screen.dart';
import 'pages/update_profile/update_profile_screen.dart';
import 'pages/dashboard/dashboard_screen.dart';
import 'pages/documents/documents_screen.dart';
import 'pages/forgot_password/forgot_password-screen.dart';
import 'pages/resset_password/resset_password_screen.dart';
import 'pages/task_details/task_details_screen.dart';
import 'pages/tasks/tasks_screen.dart';
import 'pages/verify_otp/verify_otp_screen.dart';
import 'pages/sign_in/signin_screen.dart';

final Map<String, WidgetBuilder> routes = {

  SignInScreen.routeName: (context)=>SignInScreen(),
  ForgotPasswordScreen.routeName: (context)=>ForgotPasswordScreen(),
  OTPScreen.routeName: (context)=>OTPScreen(),
  RessetPasswordScreen.routeName: (context)=>RessetPasswordScreen(),
  DashboardScreen.routeName: (context)=>DashboardScreen(),
  TasksScreen.routeName: (context)=>TasksScreen(),
  TaskDetailsScreen.routeName:(context)=>TaskDetailsScreen(),
  DocumentsScreen.routeName:(context)=>DocumentsScreen(),
  AddDocumentScreen.routeName:(context)=>AddDocumentScreen(),
  ProfileScreen.routeName:(context)=>ProfileScreen(),
  UpdateProfileScreen.routName:(context)=>UpdateProfileScreen(),
  OverdueScreen.routeName:(context)=>OverdueScreen(),
  UpcomingScreen.routeName:(context)=>UpcomingScreen(),
};
