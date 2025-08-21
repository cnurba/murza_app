import 'package:flutter/material.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';

class AppAnimatedButton extends StatelessWidget {
  const AppAnimatedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.stateType = BlocStateType.initial, this.onPressedBack,
  });

  final String title;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedBack;
  final BlocStateType stateType;

  VoidCallback? onTap() {
    if(stateType==BlocStateType.initial){
      return onPressed;
    } else if (stateType == BlocStateType.loading) {
      return null; // Disable tap during loading
    } else if (stateType == BlocStateType.loaded) {
      return onPressedBack; // Allow tap when loaded
    } else if (stateType == BlocStateType.error) {
      return onPressedBack; // Allow tap when error occurred
    } else {
      return null; // Default case, no action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: switch (stateType) {
              BlocStateType.initial => Text(title, key: ValueKey('text')),
              BlocStateType.loading => Text(title, key: ValueKey('text')),

              BlocStateType.loaded => Icon(
                Icons.check,
                color: Colors.white,
                key: ValueKey('icon'),
              ),

              BlocStateType.error => Icon(
                Icons.close,
                color: Colors.red,
                key: ValueKey('icon'),
              ),
            },
          ),
        ),
      ),
    );
  }
}
