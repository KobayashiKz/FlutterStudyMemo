// flutterのマテリアルデザインによるUIウィジェットがまとめられているパッケージ
import 'package:flutter/material.dart';

// クパティーノUI
import 'package:flutter/cupertino.dart';

// MyApp()がウィジェット
// main関数でMyApp()のウィジェットのアプリを起動させている処理
// runApp(): ウィジェットのインスタンスを実行する
void main() => runApp(MyApp());

// StatelessWidget: ステートを持たないウィジェットのベースクラス
// StatefulWidget: ステートを持つウィジェットのベースクラス
class MyApp extends StatelessWidget {

  final title = "Flutterサンプル";

  @override
  Widget build(BuildContext context) {
    // MaterialApp(): マテリアルデザインを管理するクラス.
    // BuildContext: 組み込まれたウィジェットに関する機能がまとめられたもの.
    // ex. ウィジェットが組み込まれている親や子の情報など
    return MaterialApp(
      title: "Flutter Demo",
      home: new MyHomePage(
        title: this.title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title;

  // コンストラクタ. メンバ変数に受け取る
  MyHomePage({this.title}): super();

  @override
  // これで_MyHomePageState()クラスがステートクラスとして扱われるようになる
  CupertinoUISample createState() => new CupertinoUISample();
}

// Entityクラス
class Date {
  int _price;
  String _name;

  Date(this._name, this._price): super();

  @override
  String toString() {
    return _name + ":" + _price.toString() + "円";
  }
}

class _MyHomePageState extends State<MyHomePage> {

  // あとでリストを改変しないためstatic final
  static final _data = [
    Date("Apple", 200),
    Date("Orange", 150),
    Date("Peach", 300)
  ];

  Date _item;

  @override
  // 初回はデータの1番目をアイテムに取得
  void initState() {
    super.initState();
    _item = _data[0];
  }

  // アイテムにランダム番目のデータを入れる
  void _setData() {
    setState(() {
      // ..shuffle(): リストをランダムに入れ替える
      // .first: リストの1番目を取得
      _item = (_data..shuffle()).first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text(
        // アイテムを表示している
        _item.toString(),
        style: TextStyle(fontSize: 32.0),
      ),

      floatingActionButton: FloatingActionButton(
        // onPressed: タップ時の動作
        // タップされたらランダムのデータを入れる
        onPressed: _setData,
        // tooltip: ツールチップとして表示するテキスト
        tooltip: "set message",
        // child: このウィジェット内に組み込まれるウィジェット類をまとめたもの
        child: Icon(Icons.star),
      ),
    );
  }
}

// テーマを設定するサンプル
class ThemeSettingSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Generated App",
      theme: new ThemeData(
        // 基本色
        primarySwatch: Colors.pink,
        // メインの色
        primaryColor: const Color(0xFFe91e63),
        // アクセントカラー
        accentColor: const Color(0xFFe91e63),
        // キャンバスカラー
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

// Column使用サンプル
// one/two/threeのテキストウィジェットを縦に並べる
// 横に並べたいときはRow()を使用する
class ColumnSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body:
        Column(
          // Columnウィジェットを配置する位置
          mainAxisAlignment: MainAxisAlignment.start,
          // ウィジェットのサイズを指定
          mainAxisSize: MainAxisSize.max,
          // Columnに組み込んだウィジェットを配置する位置
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("one",
              style: TextStyle(fontSize: 32.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto"),
            ),
            Text("two",
                style: TextStyle(fontSize: 32.0,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
            ),
            Text("three",
              style: TextStyle(fontSize: 32.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            ),
          ],
        ),
    );
  }

  void fabPressed() {}
}


// Stack: いくつかのウィジェットを重ね合わせて表示する
// Column/Row -> LinearLayout
// Stack: RelativeLayout
// Container: FrameLayout
class StackSample extends State<MyHomePage> {

  // スタックの中身
  var _stackData = <Widget>[
    Container(
      color: Colors.red,
      width: 200.0,
      height: 200.0,
      // コンテナの中にテキストウィジェットを設定できる
      child: Text(
        "One",
        style: TextStyle(fontSize: 32.0,
        fontWeight: FontWeight.w400,
        fontFamily: "Roboto",),
      ),
    ),
    // このようにコンテナの多重組み込みは便利なのでよく使われる
    Container(
      color: Colors.green,
      width: 200.0,
      height: 200.0,
      child: Text(
        "Two",
        style: TextStyle(fontSize: 32.0,
        fontWeight: FontWeight.w400,
        fontFamily: "Roboto"),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Stack(
        // childrenにスタックインスタンスを指定
        children: _stackData,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.android),
        onPressed: fabPressed),
      );
  }

  void fabPressed() {
    setState(() {
      _stackData.insert(0, _stackData.removeLast());
    });
  }
}

// 縦横に並べるのはColumnとRowを組み合わせてできる
// GridViewで実現することも可能
// GridView.count: 指定した列数でウィジェットを並べて配置するコンテナ.
// 列数を指定して自動的に並べ替えてくれるのがGridView.countの最大の特徴
// GridView.extend: サイズを指定してウィジェットを並べる
class GridViewSample extends State<MyHomePage> {

  // 複数ウィジェットを配列にもつ変数
  var _gridData = <Widget>[
    Container(
      color: Colors.red,
      child: Text(
        "One",
        style: TextStyle(fontSize: 32.0,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
        ),
      ),
    )
    // 必要な分だけウィジェットを用意できる
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      // crossAxisCount: 横2列で並べている. 列数を指定
      // mainAxisCount: 縦方向の行数
      // GridView.countの場合
//      body: GridView.count(crossAxisCount: 2,
//        // 各行間スペース
//        mainAxisSpacing: 10.0,
//        crossAxisSpacing: 10.0,
//        padding: const EdgeInsets.all(10.0),
//        // 組み込まれるウィジェット
//        children: _gridData,
//      )
        // GridView.extendの場合
      body: GridView.extent(maxCrossAxisExtent: 150.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      padding: const EdgeInsets.all(10.0),
      children: _gridData,),
    );
  }

  void fabPressed() {}
}

// Align: ウィジェットの揃え方を指定できるコンテナ
// 基本形: Align(alignment: [Alignment], child: ....ウィジェット....)
class AlignSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Left",
              style: TextStyle(fontSize: 32.0),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Center",
              style: TextStyle(fontSize: 32.0),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Right",
              style: TextStyle(fontSize: 32.0),
            ),
          )
        ],
      ),
    );
  }
}

// Expanded: match_parentのように画面最大化できる
// 基本形: Expanded( child: ....ウィジェット....)
class ExpandedSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Expandedが3つあるので、縦に画面三等分されたのが一つの高さ
          // 横には一つのウィジェットしか存在しないので、横幅は画面最大幅になる
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 255, 255, 0),
              child: Text(
                "First Item",
                style: TextStyle(fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"
                ),
              ),
            ),
          ),

          // Padding
          // 基本形: Padding( padding: [パディング])
          Padding(
            padding: EdgeInsets.all(25.0),
          ),

          Expanded(
            // childでもPaddingを指定できる
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(
                color: Color.fromARGB(255, 255, 125, 0),
                child: Text(
                  "Second Item",
                  style: TextStyle(fontSize: 32.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Color.fromARGB(255, 255, 0, 0),
              child: Text(
                "Third Item",
                style: TextStyle(fontSize: 32.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// SizedBox: ウィジェットを決まった大きさで組み込む
// Containerでも実現できるが、、
// 基本形: SizeBox( width: [], height: [], child: ...ウィジェット...)
class SizedBoxSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      // 縦に並べる
      body: Column(
        // 左寄せ
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // サイズを指定
          SizedBox(
            width: 200.0,
            height: 100.0,
            child: Container(
              color: Colors.yellow,
              child: Text(
                "First Item",
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          ),

          SizedBox(
            width: 100.0,
            height: 200.0,
            child: Container(
              color: Colors.red,
              child: Text(
                "Second Item",
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  void fabPressed() {}
}

// FractionalTranslation/FractionallySizedBox: ウィジェットのサイズを指定できる
// 指定方法が割合であることが特徴
class FractionalSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Name"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // FractionallySizedBox:
          // 基本形: FractionallySizedBox( widthFactor: [Double], heightFactor: [Double], child: ..)
          FractionallySizedBox(
            // 横幅を全体の1/4に指定. これでサイズの倍率を指定する
            widthFactor: 0.25,
            child: Container(
              color: Colors.yellow,
              child: Text(
                  "First Item",
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          ),

          // 基本形: FractionalTranslation(translation: [Offset], child: ..)
          FractionalTranslation(
            // オフセット値を指定
            translation: Offset(1.0, 1.0),
            child: Container(
              color: Colors.red,
              child: Text(
                "Second Item",
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Card: パネルのようにシャドウがついた表示領域. CardViewのようなもの
// 基本形: Card(margin: [EdgeInset], child: <Widget>[ リスト ]
class CardSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Text("Hello!",
                style: TextStyle(fontSize: 32.0,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
              ),

              // 同じ文言を5回繰り返す
              Text("This is Card Layout. " * 5,
                style: TextStyle(fontSize: 24.0,
                color: const Color(0xFF0000FF),
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/**
 * 第4章: マテリアルUIの基本
 * - 実際に操作するUIについて
 * */
// FlatButton: 純粋なボタン
// 基本形: FlatButton(key: null, onPressed: ...., color: ...., child: ....)
// RaisedButton: FlatButtonよりも立体的に表示されるボタン. 使い方は同様
// IconButton: IconButton(icon: ...., iconSize: ...., color: ...., onPressed: ....)
// FloatingActionButton: FABを普通のボタンとしても配置できる
// FloatingActionButton(child: ...., onPressed: ....)
// RowMaterialButton: テーマに依存しないボタンで、すべての色を自身で指定する
// RowMaterialButton(fillColor: ....,elevation: ...., padding: ...., child: ....)
class ButtonSample extends State<MyHomePage> {
  var _message;
  static var _janken = <String>["グー", "チョキ", "パー"];

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(_message,
              style: TextStyle(fontSize: 32.0,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto"),),
            ),

            RaisedButton(
              key: null,
              onPressed: buttonPressed,
              color: Colors.black12,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Push me!",
                  style: TextStyle(fontSize: 32.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),),),
            )
          ],
        ),
      ),
    );
  }

  // リストをランダムに混ぜて1番目をメッセージにする
  void buttonPressed() {
    setState(() {
      // .. をカスケード記法と呼ぶ
      _message = (_janken..shuffle()).first;
    });
  }
}

// TextField: テキスト入力ボックス
// 基本形: TextField(controller: ...., style: ....)
// controller: ウィジェットの値をお管理する専用クラス
class TextEditSample extends State<MyHomePage>{
  var _message;

  // TextEdit用のControllerを用意
  final controller = TextEditingController();

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(_message,
                style: TextStyle(fontSize: 32.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 28.0,
                  color: const Color(0xFFFF0000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"
                ),
              ),
            ),

            FlatButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.lightBlueAccent,
              child: Text(
                "Push me!",
                style: TextStyle(fontSize: 32.0,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
              ),
              onPressed: buttonPressed,
            )
          ],
        ),
      ),
    );
  }

  void buttonPressed() {
    setState(() {
      // controller.text: TextFieldに入力されている文字列を取得
      _message = "you said: " + controller.text;
    });
  }
}

// Checkbox
// 基本形: Checkbox(value: [bool], onChanged: ....,)

// Switch
// 基本形: Switch(value: [bool], onChanged: checkChanged,)

// Radio
// 基本形: Radio<型>(value: 値, groupValue: 値, onChanged: ....,)
// Radioのvalueに入る値の型指定をしなくてはいけない
// groupValue: "A"と"B"のRadioが配置されていて、Aが選択中の場合groupValue="A"となる
class RadioSample extends State<MyHomePage> {

  String _message;
  String _selected = "A";

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_message,
            style: TextStyle(fontSize: 32.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto"),
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              Radio<String> (
                value: "A",
                groupValue: _selected,
                onChanged: (String value) => checkChanged(value),
              ),

              Text(
                "radio A",
                style: TextStyle(fontSize: 28.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Radio<String> (
                value: "B",
                groupValue: _selected,
                onChanged: (String value) => checkChanged(value),
              ),

               Text("radio B",
               style: TextStyle(fontSize: 28.0,
                 fontWeight: FontWeight.w400,
                 fontFamily: "Roboto"
               ),),


            ],
          )
        ],
      ),
    );
  }

  void checkChanged(String value) {
    setState(() {
      _selected = value;
      _message = "select: $_selected";
    });
  }
}

// DropdownButton: タップすると選択肢がドロップダウンで表示されるボタン
// 基本形: DropdownButton<型> (onChanged: ...., value: 値, style: [TextStyle], items: [DropdownMenuItemリスト]

// ----実例
//  DropdownButton<String> (
//  onChanged: (String value)=> popupSelected(value),
//  value: _selected,
//  style: TextStyle(fontSize: 32.0),
//  items: <DropdownMenuItem<String>>[
//  const DropdownMenuItem(value: "One",
//  child: const Text("One")),
//
//  const DropdownMenuItem(value: "Two",
//  child: const Text("Two")),
//
//  const DropdownMenuItem(value: "Three",
//  child: const Text("Three"),)
//  ]


// PopupMenuButton: ポップアップメニューを呼び出すための専用ボタン
// 一般的に「：」でメニューを開くような感じ
// itemBuilder: メニューの項目情報がまとめられている
// PopupMenuEntryとPopupMenuItemで成り立つ

// ----実例
//  PopupMenuButton<String> (
//  onSelected: (String value)=> popupSelected(value),
//  itemBuilder: (BuildContext context) =>
//  <PopupMenuEntry<String>>[
//    const PopupMenuItem( child: const Text("One"), value: "One"),
//    const PopupMenuItem( child: const Text("Two"), value: "Two"),
//    const PopupMenuItem( child: const Text("Three"), value: "Three"),
//  ],
//  ),),

// Slider
// 基本形: Slider(onChanged: ...., min: [double], max: [double], divisions: [int], value: [double],)
// divisions: 分割数, value: 現在選択されている値





// アラート/ダイアログ
// 基本形: showDialog(context: [BuildContext], builder: [WidgetBuilder])
class ShowDialogSample extends State<MyHomePage> {
  String _message;

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Text(_message,
            style: TextStyle(
              fontSize: 32.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
          ),

          RaisedButton(
            onPressed: modalBottomSheetSample,
            padding: EdgeInsets.all(10.0),
            child: Text(
              "tap me!",
              style: TextStyle(
                fontSize: 28.0,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"
              ),
            ),
          )
        ],
      ),
    );
  }

  // ダイアログ表示メソッド
  void buttonPressed() {
    // ボタンが押されたらshowDialog()でダイアログを表示する
    showDialog(
      // contextを指定. Stateクラスに用意されているContext
      context: context,
        // AlertDialog: 小さなウィンドウで表示できるダイアログ
        // 基本形: AlertDialog(title: ..., context: ....)
        // actions: ウィジェットリストを用意してダイアログボタンを表示する
        // 独自ダイアログの場合にはContainerインスタンスを生成して返す
        builder: (BuildContext context) => AlertDialog (
          title: Text("Hello!!"),
          content: Text("This is sample."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Cancel"),
              // Navigator.pop: アラートダイアログを削除
              // 第二引数は一意のIDのようなもので、型を指定して実装する
              // ダイアログが閉じた後の処理に必要な値を第二引数に入れるべき
              onPressed: () => Navigator.pop<String>(context, "Cancel"),
            ),

            FlatButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop<String>(context, "OK"),
            )
          ],
      ),
      // thenによって、ダイアログが閉じた後の処理を実現
      // valueに、Navigator.popの第二引数が入ってくる
    ).then<void>((value) => resultAlert(value));
  }

  void resultAlert(String value) {
    setState(() {
      _message = "selected: $value";
    });
  }

  // SimpleDialog: 複数の項目から一つを選ぶダイアログを簡単に実装できる
  // 基本形: SimpleDialog(title: ...., children: [ウィジェットリスト])
  // childrenには SimpleDialogOptionを使用する
  // SimpleDialogOptionの基本形: SimpleDialogOption(child: ..., onPressed: ....)
  void simpleDialogSample() {
    showDialog(context: context,
    builder: (BuildContext context) => SimpleDialog(
      // 選択肢の中から選ぶダイアログのタイトル
      title: const Text("Select assignment"),
      children: <Widget>[
        // ここに選択肢のウィジェットを記載していく
        SimpleDialogOption(
          // 第二引数: thenのvalueに入る
          onPressed: () => Navigator.pop<String>(context, "One"),
          child: const Text("One"),
        ),

        SimpleDialogOption(
          onPressed: () => Navigator.pop<String>(context, "Two"),
          child: const Text("Two"),
        ),

        SimpleDialogOption(
          onPressed: () => Navigator.pop<String>(context, "Three"),
          child: const Text("Three"),
        )
      ],
    )).then<void>((value) => resultAlert(value));
  }

  // showModalBottomSheet: 画面の下から出てくるモーダルボトムシートを表示
  // 基本形: showModalBottomSheet(context: [Context], builder: (BuildContext, context) => ウィジェット,
  void modalBottomSheetSample() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Column(
          children: <Widget>[
            Text(
              "This is Modal Bottom Sheet",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
            ),

            FlatButton(
              onPressed: () => Navigator.pop<String>(context, "Close"),
              child: Text(
                "Close",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.cyan,
                ),
              ),
            )
          ],
        )).then<void>((value) => resultAlert(value));
  }
}


/**
 * 第5章: 複雑な構造のウィジェット
 */
// AppBarをカスタマイズする
class AppBarCustomSample extends State<MyHomePage>{
  String _message;
  String _stars = "";
  int _star = 2;

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My App"
        ),
        // leading: AppBarの左側に配置される
        leading: BackButton(
          color: Colors.white,
        ),

        // actions: AppBarの右側に配置される
        // リスト順に左から配置されていく
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.android),
            tooltip: "add star...",
            onPressed: iconPressedA,
          ),

          IconButton(
            icon: Icon(Icons.favorite),
            tooltip: "subtract start...",
            onPressed: iconPressedB,
          ),
        ],

        // bottom: AppBarの下に配置される
        // PreferredSizeを使用する必要がある
        bottom: PreferredSize(
          // 高さを指定
          preferredSize: const Size.fromHeight(30.0),
          child: Center(
            child: Text(_stars,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),),
          ),
        ),
      ),
      body: Center(
        child: Text(
          _message,
          style: const TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }

  void iconPressedA() {
    _message = 'tap "android".';
    _star++;
    update();
  }

  void iconPressedB() {
    _message = 'tap "favorite".';
    _star--;
    update();
  }

  void update() {
    // 0~5の範囲におさめる
    _star = _star < 0 ? 0: _star > 5 ? 5 : _star;
    setState(() {
      _stars = '★★★★★☆☆☆☆☆'.substring(5 - _star ,5 - _star + 5);
      _message = _message + "[$_star]";
    });
  }
}


// BottomNavigationBar: 画面下部に表示するバー
// 基本形: BottomNavigationBar(currentIndex: [int], items: [BottomNavigationBarItemリスト], onTap: ...)
class BottomNavigationBarSample extends State<MyHomePage> {
  String _message;
  int _index = 0;

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
        child: Text(
          _message,
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,

          items: <BottomNavigationBarItem>[
            // BottomNavigationBarItemをリストで持つ
            BottomNavigationBarItem(
              title: Text("bottom"),
              icon: Icon(Icons.android)
            ),

            BottomNavigationBarItem(
              title: Text("bottom"),
              icon: Icon(Icons.favorite),
            ),
          ],
      onTap: tapBottomIcon,),
    );
  }

  // valueにタップした項目のインデックス番号が入る
  void tapBottomIcon(int value) {
    var items = ['Android', 'Heart'];
    setState(() {
      _index = value;
      _message = 'you tapped: "' + items[_index] + '".';
    });
  }
}


// ListView: 単純にウィジェットをリストで表示する
// 基本形: ListView(shrinkWrap: [bool], padding: [EdgeInsets], children: ...)
// shrinkWrap: 追加された項目によってサイズを自動調整するかどうか
class ListViewSample extends State<MyHomePage> {
  String _message;
  int _index;

  @override
  void initState() {
    _message = "ok.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My App"
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            _message,
            style: TextStyle(
              fontSize: 32.0,
            ),
          ),

          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),

            children: <Widget>[
              // ListTile: タップした時の動作をListTileで実現
              // 基本形: ListTile(leading: .., title: ..., selected: ..., onTap: ...)
              ListTile(
                // リストアイテムの左側に位置する
                leading: const Icon(Icons.android),
                title: const Text("First item"),
                // 選択中かどうか
                selected: _index == 1,
                onTap: () {
                  _index = 1;
                  tapTile();
                },
              ),

              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text("Second item"),
                selected: _index == 2,
                onTap: () {
                  _index = 2;
                  tapTile();
                },
              ),

              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text("Third item"),
                selected: _index == 3,
                onTap: () {
                  _index = 3;
                  tapTile();
                  },
              )
            ],
          ),
        ],
      ),
    );
  }

  void tapTile() {
    setState(() {
      _message = "you tapped: No, $_index.";
    });
  }
}


// SingleChildScrollView: スクロールビュー
// 基本形: ShingleChildScrollView(child: ....)
// スクロールした時の上下の限界アニメーションはListView側で表示される
class SingleChildScrollViewSample extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My App"
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 120.0,
              child: const Center(
                child: Text(
                  "One",
                  style: const TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),

            Container(
              color: Colors.white,
              height: 120.0,
              child: const Center(
                child: Text(
                  "Two",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),

            Container(
              color: Colors.blue,
              height: 120.0,
              child: const Center(
                child: Text(
                  "Three",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),

            Container(
              color: Colors.white,
              height: 120.0,
              child: const Center(
                child: Text(
                  "Four",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),

            Container(
              color: Colors.blue,
              height: 120.0,
              child: const Center(
                child: Text(
                  "Five",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SliverAppBar: 可変サイズのAppBarとスクロールするコンテンツが組み合わさったBar
// 下スクロールすると伸びて、上スクロールするとAppBarに戻る
// 基本形: SliverAppBar(pinned: [bool], expandedHeight: [double], flexibleSpace: .., actions: ..)
// pinned: 上スクロールした際に、AppBar部分を残すかどうか
// expandedHeight: 最大高さ, flexibleSpace: コンテンツを指定, actions: AppBar右側に配置するもの
// SliverList: SliverAppBarのアイテム
// 基本形: SliverList(delegate: [SliverChildListDelegate])
// delegate: コンテンツの内容（AppBarでいう body部分）
class SliverAppBarSample extends State<MyHomePage> {
  List _items = <Widget>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      var item = Container(
        color: i.isOdd ? Colors.blue : Colors.white,
        height: 100.0,
        child: Center(
          child: Text(
            "No, $i",
            style: const TextStyle(
              fontSize: 32.0,
            ),
          ),
        ),
      );
      _items.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(

        slivers: <Widget>[

          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            // flexibleSpaceを設定するFlexibleSpaceBar:
            // 基本形: const FlexibleSpaceBar(title: ...., background: [ウィジェット])
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Sliver App Bar"
              ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  // URLを指定した画像の取得方法 Image.network
                  Image.network(
                    "https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg",
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              // SliverAppBarの右側にアイコン配置
              IconButton(
                icon: const Icon(
                  Icons.android
                ),
                tooltip: "icon button",
                onPressed: () {
                  print("pressed.");
                },
              )
            ],
          ),

              SliverList(
                // body部分の設定.
                delegate: SliverChildListDelegate(_items),
              )
        ],
      ),
    );
  }
}

// TabBar: タブのノブ部分に表示するUI
// 基本形: TabBar(controller: [TabController], tabs: [Tabのリスト])
// TabBarView: コンテンツ表示部分
// 基本形: TabBarView(controller: [TabController], children: [ウィジェット])
// TabController
// 基本形: TabController(vsync: [TickerProvider], length: [int])
// length: タブの数
// Tab: TabBarのノブのウィジェットを設定するクラス
// 基本形: Tab(text: [String])
class TabBarSample extends State<MyHomePage> with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin: Tickrを一つ持つTickerProviderクラス
  // ミックスイン: Dartで他のクラスの機能を取り込む仕組み. インターフェースの実装.

  // 実際にノブ部分に表示するリスト
  final List<Tab> tabs = <Tab> [
    Tab(text: "One"),
    Tab(text: "Two"),
    Tab(text: "Three"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      // ノブの個数指定
        length: tabs.length,
        vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My App"
        ),
        // AppBarの下にTabBarを表示する
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs
        ),
      ),

      body: TabBarView(
          controller: _tabController,
          children: tabs.map((Tab tab) {
            // toList()でこれらをリスト化している
            return createTab(tab);
          }).toList(),
      ),
    );
  }

  //
  Widget createTab(Tab tab) {
    return Center(
      child: Text(
        'This is "' + tab.text + '" Tab.',
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}


// Drawer: Scaffoldに組み込んで作ることができる
// 基本形: Drawer(child: ウィジェット)
class DrawerSample extends State<MyHomePage> {
  List _items = <Widget>[];
  String _message;
  int _tapped = 0;

  @override
  void initState() {
    super.initState();
    _message = "ok.";

    for (var i = 0; i < 5; i++) {
      // _itemsにListTileを5つ追加
      var item = ListTile(
        leading: const Icon(Icons.android),
        title: Text("No, $i"),
        onTap: () {
          _tapped = i;
          tapItem();
        },
      );
      _items.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter App"
        ),
      ),
      body: Center(
        child: Text(
          _message,
          style: TextStyle(
            fontSize: 32.0,
          ),
        ),
      ),
      // Scaffoldにdrawerがあるので、ここでドロワーを指定できる
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: _items,
        ),
      ),
    );
  }

  // ドロワーコンテンツがタップされた際の処理
  void tapItem() {
    // ドロワー閉じて、テキスト更新
    Navigator.pop(context);
    setState(() {
      _message = "tapped: [$_tapped]";
    });
  }
}


// クパティーノUI
// iOS用のデザイン. 基本的にTextやColumnなどの表示ためのUIは共通
// 入力のためのUIはクパティーノUIが用意されていたりする
class CupertinoUISample extends State<MyHomePage> {
  String _message = "ok.";
  bool _switch = true;
  double _slider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        title: Text(
          "App Name"
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Text(
            _message,
            style: TextStyle(
              fontSize: 32.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0)
          ),

          // クパティーノスイッチ
          CupertinoSwitch(
            value: _switch,
            onChanged: (bool value) {
              print("switch.");
              setState(() {
                _switch = value;
                _message = "switch: $_switch";
              });
            },
          ),

          // クパティーノスライダー
          CupertinoSlider(
            value: _slider,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            onChanged: (double value) {
              print(value);
              setState(() {
                _slider = value;
                _message = "slider: $_slider";
              });
            },
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            // クパティーノボタン
            child: CupertinoButton(
                // 角丸
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                pressedOpacity: 0.5,
                // CupertinoColorsでクパティーノ標準色がまとめられている
                color: CupertinoColors.activeBlue,
                onPressed: buttonPressed,
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "tap me!",
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"
                  ),
                ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.left_chevron),
        middle: Text(
          "Navigation"
        ),
        trailing: IconButton(
          icon: Icon(CupertinoIcons.right_chevron),
          onPressed: showPicker,
        ),
      ),
    );
  }

  void buttonPressed() {
    // ダイアログの表示
    showDialog(
      context: context,
      // クパティーノアラートダイアログ
      builder: (BuildContext context) => CupertinoAlertDialog(
        // ダイアログタイトル
        title: Text(
          "Hello!"
        ),
        // ダイアログメッセージ
        content: const Text(
          "This is sample."
        ),
        // 選択ボタン. CupertinoDialogActionで設定する
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text(
              "Cancel"
            ),
            onPressed: () => Navigator.pop<String>(context, "Cancel"),
          ),

           CupertinoDialogAction(
             child: const Text(
               "OK"
             ),
             onPressed: () => Navigator.pop<String>(context, "OK"),
           )
        ],
      )
    ).then<void>((value) => resultAlert(value));
  }

  void resultAlert(String value) {
    setState(() {
      _message = "selected: $value";
    });
  }

  void showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          // クパティーノピッカー
          return CupertinoPicker(
            backgroundColor: CupertinoColors.black,
            itemExtent: 50.0,
            children: <Widget>[
              // クパティーノピッカーの選択肢
              Text(
                "One",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                ),
              ),

              Text(
                "Two",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),
              ),

              Text(
                "Three",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),
              ),

              Text(
                "Four",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),
              ),

              Text(
                "Five",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),
              ),
            ],

            onSelectedItemChanged: (int value) {
              print("pick $value");
            },
          );
        });
  }
}
