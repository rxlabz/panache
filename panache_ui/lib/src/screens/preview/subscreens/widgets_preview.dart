import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class ButtonPreview extends StatelessWidget {
  final ThemeData theme;

  const ButtonPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text(
            'RaisedButton',
            style: theme.textTheme.subtitle1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Snack bar'))),
                  child: Text("A button"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_box),
                  label: Text('ElevatedButton.Icon'),
                ),
                ElevatedButton(onPressed: null, child: Text("Disabled")),
                ElevatedButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.add_box),
                  label: Text('Disabled with icon'),
                ),
              ],
            ),
          ),
          Divider(),
          Text('OutlinedButton'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Wrap(
              spacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                OutlinedButton(onPressed: () {}, child: Text("A button")),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_box),
                  label: Text('OutlinedButton.icon'),
                ),
                OutlinedButton(onPressed: null, child: Text("Disabled")),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_box),
                  label: Text('Disabled with icon icon'),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Text(
                  'IconButton',
                  style: theme.textTheme.subtitle1,
                ),
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {},
              ),
              Text('Enabled', style: theme.textTheme.caption),
              IconButton(icon: Icon(Icons.style), onPressed: null),
              Text(
                'Disabled',
                style: theme.textTheme.caption,
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Dropdown'),
              ),
              DropdownButton(
                  items: [
                    'Paris',
                    'Moscou',
                    'Amsterdam'
                  ].map((item) => DropdownMenuItem(child: Text(item))).toList(growable: false),
                  onChanged: (value) => print('dropdown value $value')),
            ],
          ),
          Divider(),
          Text('TextButton', style: theme.textTheme.subtitle1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Wrap(
              children: [
                TextButton(onPressed: () {}, child: Text("Enabled")),
                TextButton(onPressed: null, child: Text('Disabled')),
                TextButton.icon(
                  icon: Icon(Icons.restore_from_trash),
                  onPressed: () {},
                  label: Text('TextButton.icon'),
                ),
                TextButton.icon(
                  icon: Icon(Icons.restore_from_trash),
                  onPressed: null,
                  label: Text('Disabled.icon'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetPreview1 extends StatelessWidget {
  final ThemeData theme;

  const WidgetPreview1({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final bodyStyle = textTheme.bodyText1.copyWith(fontSize: 12);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: theme.primaryColorDark, borderRadius: BorderRadius.circular(4)),
            child: Text(
                'Active color : ThemeData.unselectedWidgetColor\n'
                'Active selected color : ThemeData.toggleableActiveColor\n'
                'Disabled color : ThemeData.disabledColor',
                style: theme.primaryTextTheme.bodyText1.copyWith(height: 1.4, color: getContrastColor(theme.primaryColorDark))),
          ),
          Divider(),
          Text('Checkbox', style: textTheme.subtitle2),
          Column(
            children: [
              Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: (v) {}),
                  Text('Checkbox', style: bodyStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: true, onChanged: (v) {}),
                  Text('Selected Checkbox', style: bodyStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: null),
                  Text('Disabled Checkbox', style: bodyStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: true, onChanged: null),
                  Text('Selected Disabled Checkbox', style: bodyStyle)
                ],
              ),
            ],
          ),
          Divider(),
          Text('Radio buttons', style: textTheme.subtitle2),
          Column(
            children: [
              Row(children: [
                Radio(value: false, onChanged: (v) {}, groupValue: null),
                Text('RadioButton', style: bodyStyle)
              ]),
              Row(children: [
                Radio(value: false, groupValue: null, onChanged: null),
                Text('RadioButton - disabled', style: bodyStyle)
              ]),
              Row(children: [
                Radio(value: true, onChanged: (v) {}, groupValue: true),
                Text('RadioButton - selected', style: bodyStyle)
              ]),
            ],
          ),
          Divider(),
          Text('Switchs', style: textTheme.subtitle2),
          Column(
            children: [
              Row(children: [
                Switch(value: false, onChanged: (v) {}),
                Text('Switch', style: bodyStyle)
              ]),
              Row(children: [
                Switch(value: true, onChanged: (v) {}),
                Text('selected', style: bodyStyle)
              ]),
              Row(children: [
                Switch(value: false, onChanged: null),
                Text('disabled', style: bodyStyle)
              ]),
              Row(children: [
                Switch(value: true, onChanged: null),
                Text('disabled selected', style: bodyStyle)
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
