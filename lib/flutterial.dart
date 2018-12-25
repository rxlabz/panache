import 'package:flutter/material.dart';
import 'package:flutterial_components/flutterial_components.dart';
import 'package:scoped_model/scoped_model.dart';

class PanacheEditorScreen extends StatefulWidget {
  @override
  PanacheEditorScreenState createState() {
    return new PanacheEditorScreenState();
  }
}

class PanacheEditorScreenState extends State<PanacheEditorScreen> {
  bool showCode = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(
        builder: (BuildContext context, Widget child, model) {
      return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text('Panache'),
          actions: <Widget>[
            FlatButton.icon(
              textColor: Colors.white,
              icon: Icon(Icons.mobile_screen_share),
              label: Text('App preview'),
              onPressed: () => setState(() => showCode = false),
            ),
            FlatButton.icon(
              textColor: Colors.white,
              icon: Icon(Icons.keyboard),
              label: Text('Code preview'),
              onPressed: () => setState(() => showCode = true),
            ),
            FlatButton.icon(
                onPressed: model.exportTheme,
                textColor: Colors.white,
                icon: Icon(Icons.save),
                label: Text('Export')),
          ],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ThemeEditor(model: model)),
            AppPreviewContainer(kIPhone6, showCode: showCode),
          ],
        ),
      );
    });
  }
}
