import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/onboarding/widgets/widgets.dart';
import '/widgets/widgets.dart';
import '/screens/screens.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/copperIcon.png',
                ),
              ),
              SizedBox(height: 50),
              Text('Welcome to Copper',
                  style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 20),
              Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(height: 1.8),
                textAlign: TextAlign.center,
              ),
              CustomElevatedButton(
                text: 'BACK',
                beginColor: Colors.white,
                endColor: Colors.white,
                textColor: Theme.of(context).primaryColor,
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  ModalRoute.withName('login'),
                ),
              ),
            ],
          ),
          CustomButton(tabController: tabController, text: 'START')
        ],
      ),
    );
  }
}
