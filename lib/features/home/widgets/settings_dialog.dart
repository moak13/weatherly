import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const SettingsDialog({Key key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final theme = Theme.of(context);
    return Dialog(
      child: Container(
          height: orientation == Orientation.portrait ? 300 : 250,
          width: orientation == Orientation.portrait ? 350 : 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: theme.primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                request.title,
                style: TextStyle(
                  color: theme.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                  'Switch Temperature',
                  style: TextStyle(
                    color: theme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Make a choice on the reading your comfortable with',
                  style: TextStyle(
                    color: theme.backgroundColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Switch(
                  value: request.customData,
                  activeColor: theme.backgroundColor,
                  inactiveTrackColor: theme.backgroundColor.withOpacity(0.3),
                  onChanged: (value) {
                    completer(
                      DialogResponse(
                        confirmed: value,
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
