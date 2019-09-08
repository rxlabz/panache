import 'package:flutter/material.dart';

class ChipsPreview extends StatelessWidget {
  final ThemeData theme;

  const ChipsPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 100),
                    child: Column(
                      children: <Widget>[
                        Text('Chips'),
                        Wrap(
                          spacing: 16.0,
                          children: <Widget>[
                            Chip(label: Text('Chip')),
                            Chip(
                              label: Text('Chip'),
                              avatar: Icon(Icons.person_pin),
                              onDeleted: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Card(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 130),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Choice chips'),
                        Wrap(
                          spacing: 16.0,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            ChoiceChip(
                                label: Text('Selected Choice chip'),
                                selected: true),
                            ChoiceChip(
                                label: Text('Not selected'), selected: false),
                            ChoiceChip(
                                label: Text('Not selected 2'), selected: false),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Text('Filter chips'),
                Wrap(
                  spacing: 16.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    FilterChip(
                        selected: true,
                        label: Text('FilterChip'),
                        onSelected: (_) {}),
                    FilterChip(
                        selected: true,
                        label: Text('FilterChip'),
                        onSelected: (_) {}),
                    FilterChip(
                        label: Text('Disabled FilterChip'), onSelected: null),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
