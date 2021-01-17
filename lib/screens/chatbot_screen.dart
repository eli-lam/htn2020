import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class ChatBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Scaffold();
    Map<int, Color> color = {
      50: Color.fromRGBO(117, 119, 151, .1),
      100: Color.fromRGBO(117, 119, 151, .2),
      200: Color.fromRGBO(117, 119, 151, .3),
      300: Color.fromRGBO(117, 119, 151, .4),
      400: Color.fromRGBO(117, 119, 151, .5),
      500: Color.fromRGBO(117, 119, 151, .6),
      600: Color.fromRGBO(117, 119, 151, .7),
      700: Color.fromRGBO(117, 119, 151, .8),
      800: Color.fromRGBO(117, 119, 151, .9),
      900: Color.fromRGBO(117, 119, 151, 1),
    };
    return new MaterialApp(
      title: 'Example Dialogflow Flutter',
      theme: new ThemeData(
        primarySwatch: MaterialColor(0xFF757797, color),
      ),
      debugShowCheckedModeBanner: false,
      home: new HomePageDialogflow(),
    );
  }
}

class HomePageDialogflow extends StatefulWidget {
  HomePageDialogflow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void res(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,
      name: "Feelix",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
    print("got response");
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "You",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    res(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Chat"),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Image.asset('assets/feelix.png')),
      ),
      new Container(
        child: Card(
          color: Color(0xFFF6F2FF),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: new Radius.circular(15.0),
              topRight: new Radius.circular(15.0),
              bottomRight: new Radius.circular(15.0),
              //bottomLeft: new Radius.circular(20.0),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: new Column(
                children: <Widget>[
                  new Text(this.name,
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Container(
        margin: new EdgeInsets.only(left: 280),
        child: Card(
          color: Color(0xFF4F8BFF),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: new Radius.circular(15.0),
                topRight: new Radius.circular(15.0),
                bottomLeft: new Radius.circular(15.0)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text(
                      text,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
