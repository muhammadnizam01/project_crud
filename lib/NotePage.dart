import 'package:flutter/material.dart';
import 'package:project_uas/DBHelper.dart';
import 'package:project_uas/mynote.dart';
import 'package:project_uas/tab_bar.dart';

class NotePage extends StatefulWidget {
  NotePage(this._mynote, this._isNew);

  final Mynote _mynote;
  final bool _isNew;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String title;
  bool btnSave = false;
  bool btnEdit = true;
  bool btnDelete = true;

  Mynote mynote;
  String createDate;

  final cTitle = TextEditingController();
  final cNote = TextEditingController();

  var now = DateTime.now();

  bool _enableTextField = true;

  Future addRecord() async {
    var db = DBHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}";

    var mynote =
        Mynote(cTitle.text, cNote.text, dateNow, dateNow, now.toString());
    await db.saveNote(mynote);
    print("save");
  }

  Future updateRecord() async {
    var db = new DBHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}";

    var mynote =
        Mynote(cTitle.text, cNote.text, createDate, dateNow, now.toString());

    mynote.setNoteId(this.mynote.id);
    await db.updateNote(mynote);
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      updateRecord();
    }
    Navigator.of(context).pop();
  }

  void _editData() {
    setState(() {
      _enableTextField = true;
      btnEdit = false;
      btnSave = true;
      btnDelete = true;
      title = "Edit Note";
    });
  }

  void delete(Mynote mynote) {
    var db = new DBHelper();
    db.deleteNote(mynote);
  }

  void _confirmDelete() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Are you sure ??",
        style: TextStyle(fontSize: 20.0),
      ),
      actions: [
        RaisedButton(
          color: Colors.red,
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
            delete(mynote);
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          color: Colors.yellow,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    if (widget._mynote != null) {
      mynote = widget._mynote;
      cTitle.text = mynote.title;
      cNote.text = mynote.note;
      title = "My Note";
      _enableTextField = false;
      createDate = mynote.createDate;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = "New Note";
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CreateButton(
                  icon: Icons.save,
                  enable: btnSave,
                  onpress: _saveData,
                ),
                CreateButton(
                  icon: Icons.edit,
                  enable: btnEdit,
                  onpress: _editData,
                ),
                CreateButton(
                  icon: Icons.delete,
                  enable: btnDelete,
                  onpress: _confirmDelete,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextFormField(
                enabled: _enableTextField,
                controller: cTitle,
                decoration: InputDecoration(
                    hintText: "Title", border: InputBorder.none),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
                maxLines: null,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextFormField(
                enabled: _enableTextField,
                controller: cNote,
                decoration: InputDecoration(
                    hintText: "Write Here...", border: InputBorder.none),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: FancyTabBar(),
    );
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;

  CreateButton({this.icon, this.enable, this.onpress});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: enable ? Colors.purple : Colors.grey),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 18.0,
        onPressed: () {
          if (enable) {
            onpress();
          }
        },
      ),
    );
  }
}
