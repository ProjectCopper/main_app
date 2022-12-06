import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/screens/screens.dart';
import '/cubits/cubits.dart';
import '/blocs/blocs.dart';
import '/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.authenticated
            ? HomeScreen()
            : LoginScreen();
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'COPPER', hasActions: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailInput(),
            const SizedBox(height: 10),
            PasswordInput(),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'LOGIN',
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                context.read<LoginCubit>().logInWithCredentials();
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'SIGNUP',
              beginColor: Theme.of(context).accentColor,
              endColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('onboarding'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: "Email"),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().emailChanged(password);
          },
          decoration: const InputDecoration(labelText: "Password"),
          obscureText: true,
        );
      },
    );
  }
}
