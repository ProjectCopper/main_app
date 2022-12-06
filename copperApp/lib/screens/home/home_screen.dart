import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/screens/screens.dart';
import '/blocs/blocs.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? OnboardingScreen()
              : HomeScreen();
        });
  }

  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Discover'),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SwipeLoaded) {
          SwipeLoadedHomeScreen(state: state);
        }

        if (state is SwipeMatched) {
          SwipeMatchedHomeScreen(state: state);
        }
        if (state is SwipeError) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Discover'),
            body: Center(
              child: Text('There aren\'t any more users.',
                  style: Theme.of(context).textTheme.headline4),
            ),
          );
        } else {
          return Scaffold(
            appBar: CustomAppBar(title: 'Discover'),
            body: Center(child: Text('Something went wrong.')),
          );
        }
      },
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeMatched state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Congrats, it\'s a match!',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 20),
            Text(
              'You and ${state.user.name} have matched!',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        context.read<AuthBloc>().state.user!.imageUrls[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            CustomElevatedButton(
              text: "SEND A MESSAGE",
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            CustomElevatedButton(
              text: "BACK TO SWIPING",
              beginColor: Theme.of(context).primaryColor,
              endColor: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                context
                    .read<SwipeBloc>()
                    .add(LoadUsers(user: context.read<AuthBloc>().state.user!));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeLoaded state;
  @override
  Widget build(BuildContext context) {
    var userCount = state.users.length;
    return Scaffold(
      appBar: CustomAppBar(title: 'Discover'),
      body: Column(
        children: [
          InkWell(
            onDoubleTap: () {
              Navigator.pushNamed(context, '/users', arguments: state.users[0]);
            },
            child: Draggable<User>(
              data: state.users[0],
              child: UserCard(user: state.users[0]),
              feedback: UserCard(user: state.users[0]),
              childWhenDragging: (userCount > 1)
                  ? UserCard(user: state.users[1])
                  : Container(),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < 0) {
                  context.read<SwipeBloc>()
                    ..add(SwipeLeft(user: state.users[0]));
                  print('Swiped Left');
                } else {
                  context.read<SwipeBloc>()
                    ..add(SwipeRight(user: state.users[0]));
                  print('Swiped Right');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    context.read<SwipeBloc>()
                      ..add(SwipeRight(user: state.users[0]));
                    print('Swiped Right');
                  },
                  child: ChoiceButton(
                    color: Theme.of(context).accentColor,
                    icon: Icons.clear_rounded,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<SwipeBloc>()
                      ..add(SwipeRight(user: state.users[0]));
                    print('Swiped Left');
                  },
                  child: ChoiceButton(
                    width: 80,
                    height: 80,
                    size: 30,
                    color: Colors.white,
                    hasGradient: true,
                    icon: Icons.favorite,
                  ),
                ),
                ChoiceButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.watch_later,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
