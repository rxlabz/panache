import 'package:flutter/material.dart';

class InputsPreview extends StatelessWidget {
  final ThemeData theme;

  const InputsPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emptyController = TextEditingController(text: '');
    final controller = TextEditingController(text: 'A text');
    final disabledController = TextEditingController(text: 'Disabled');

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emptyController,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'label text',
                hintText: 'Hint text',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              autocorrect: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emptyController,
              autocorrect: false,
              maxLength: 20,
              decoration: InputDecoration(
                helperText: 'Helper text',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              enabled: false,
              controller: disabledController,
              autocorrect: false,
              maxLength: 20,
              decoration: InputDecoration(
                helperText: 'Helper text',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              autocorrect: false,
              maxLength: 20,
              decoration: InputDecoration(
                prefixText: '+prefix : ',
                suffixText: ' => Suffix',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emptyController,
              autocorrect: false,
              decoration:
                  InputDecoration(hintText: '', errorText: 'Error text'),
            ),
          ),
        ],
      ),
    );
  }
}
