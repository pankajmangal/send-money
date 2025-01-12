// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/bloc/auth_bloc/auth_bloc.dart';
import 'package:send_money/bloc/auth_bloc/auth_event.dart';
import 'package:send_money/bloc/auth_bloc/auth_state.dart';
import 'package:send_money/data/models/request/user_authenticate_request_data.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/repository/auth_repo.dart';

import 'package:send_money/presentation/screens/login_screen.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Login Success test cases", (){
    late Dio dio;
    late DioAdapter dioAdapter;
    late MockAuthRepo mockAuthRepo;
    late AuthBloc authBloc;

    setUp(() async {
      final header = {
        'Content-Type': 'application/json',
        'user_agent':Platform.isAndroid ? "android" : "ios"
      };

      dio = Dio(BaseOptions(headers: header));
      mockAuthRepo = MockAuthRepo();
      authBloc = AuthBloc(authRepo: mockAuthRepo);
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });

    blocTest<AuthBloc, AuthState>(
        "When data is empty",
        build: () {
          when(() => mockAuthRepo.userAuthenticate(UserAuthenticateRequestData(email: "", password: "")).then((result) => Result.success(successResponse: [])));
          return authBloc;
        },
        act: (dynamic b) => b.add(AuthLoginEvent(requestData: UserAuthenticateRequestData(email: "", password: ""))),
        wait:  const Duration(milliseconds: 500),
        expect: () => [AuthLoadingState(), const AuthErrorState(errMessage: "Something went wrong!")]);

    blocTest<AuthBloc, AuthState>(
        "When entered correct data in that field",
        build: () {
          when(() => mockAuthRepo.userAuthenticate(UserAuthenticateRequestData(email: "mangal.pankaj5@gmail.com", password: "Mangal@720")).then((result) => Result.success(successResponse: {"token": ""})));
          return authBloc;
        },
        act: (dynamic b) => b.add(AuthLoginEvent(requestData: UserAuthenticateRequestData(email: "mangal.pankaj5@gmail.com", password: "Mangal@720"))),
        wait:  const Duration(milliseconds: 500),
        expect: () => [AuthLoadingState(), const AuthErrorState(errMessage: "Something went wrong!")]);
    /*testWidgets('Counter increments smoke test', (WidgetTester tester) async {


      // Build our app and trigger a frame.
      await tester.pumpWidget(const LoginScreen());

      expect(find.text('Sign In to your Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
    });*/
  });
}
