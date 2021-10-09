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
    return Container(
      height: orientation == Orientation.portrait ? 450 : 600,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('Search Location'),
          SizedBox(
            height: 10,
          ),
          Text('Check Weather by City'),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: _cityNameController,
            decoration: InputDecoration(
              hintText: 'Search...',
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
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
