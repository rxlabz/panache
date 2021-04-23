import 'package:flutter/material.dart';
import '../../../widgets/fields_row.dart';

class OthersPreview extends StatelessWidget {
  final ThemeData theme;

  const OthersPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          child: Icon(Icons.person_pin),
                        ),
                        Text('Circle Avatar')
                      ],
                    ),
                    FieldsRow([
                      TextButton.icon(
                        icon: Icon(Icons.event),
                        label: Text('Datepicker'),
                        onPressed: () => showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100)),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.open_in_browser),
                        label: Text('Dialog'),
                        onPressed: () => _showDialog(context),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
          Text('Progress'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: 0.57,
                ),
              ),
              CircularProgressIndicator(
                value: 0.57,
                backgroundColor: Colors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(context) => showDialog(
        context: context,
        builder: (context) => Theme(
            child: Dialog(
              child: Container(
                width: 420.0,
                height: 420.0,
                child: Text(
                  'a simple dialog',
                  style: theme.textTheme.headline5,
                ),
              ),
            ),
            data: theme),
      );
}
