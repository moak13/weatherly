import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchCitySheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  SearchCitySheet({Key key, this.request, this.completer}) : super(key: key);

  final _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var theme = Theme.of(context);
    return Container(
      height: orientation == Orientation.portrait ? 350 : 500,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Search Location',
            style: TextStyle(
              color: theme.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Check Weather by City',
            style: TextStyle(
              color: theme.backgroundColor,
              fontWeight: FontWeight.w300,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: _cityNameController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: theme.backgroundColor,
                    ),
                    fillColor: Colors.blueGrey,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    completer(
                      SheetResponse(
                        confirmed: true,
                        responseData: _cityNameController.text.trim(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'submit',
                      style: TextStyle(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
