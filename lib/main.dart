// flutterのマテリアルデザインによるUIウィジェットがまとめられているパッケージ
import 'package:flutter/material.dart';

// クパティーノUI
import 'package:flutter/cupertino.dart';

import 'package:flutter/gestures.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';

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
      home: new PreferencesSample(
//        title: this.title,
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
  CustomPainterTapSample createState() => new CustomPainterTapSample();
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

/**
 * 第6章 グラフィックの描画
 */
// ゲームなどのアプリの場合、ウィジェットではなくグラフィックで表示する必要がある
// RenderObjectWidget
// RenderBox
class RenderObjectSample extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "App Name"
        ),
      ),

      body: Center(
        child: MyRenderBoxWidget(),
      ),
    );
  }
}

// RenderObjectWidgetクラス
// 基本形
class MyRenderBoxWidget extends SingleChildRenderObjectWidget {

  @override
  // ここで返されるRenderObjectが描画に用いられる
  RenderObject createRenderObject(BuildContext context) {
    return RenderTapSample();
  }
}

// RenderBoxクラス
// paint()で描画処理を記述
// 正方形を二つペイントするサンプル
class _MyRenderBox extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // 描画に使用するメソッドなどがまとめられているCanvas
    Canvas c = context.canvas;
    // 描画のオフセット値. 描画エリアを示す
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    // 描画に関する設定を行うPaintクラス
    Paint p = Paint();
    // fill: 塗りつぶし, stroke: 輪郭線のみ描画
    p.style = PaintingStyle.fill;
    // 描画色の設定
    p.color = Color.fromARGB(150, 0, 200, 255);
    // 描画領域をRectで指定
    // LTWH: 横位置, 縦位置, 幅, 高さ
    Rect r = Rect.fromLTWH(dx + 50.0, dy + 50.0, 150.0, 150.0);
    // drawRect(Rect, Paint)で描画実行
    c.drawRect(r, p);

    p.style = PaintingStyle.stroke;
    p.color = Color.fromARGB(150, 200, 0, 255);
    // 線の太さ
    p.strokeWidth = 10.0;
    r = Rect.fromLTWH(dx + 100.0, dy + 100.0, 150.0, 150.0);
    c.drawRect(r, p);
  }
}


// 正円と楕円を描くRenderBoxのサンプル
class CirclePaintBox extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    // 正円の描画
    Paint p = Paint();
    p.style = PaintingStyle.fill;
    p.color = Color.fromARGB(150, 0, 200, 255);
    // Offset: 縦横の値をまとめて表すクラス
    Offset ctr = Offset(dx + 100.0, dy + 100.0);
    // 正円を描くにはdrawCircleを用いる
    // [位置], [半径], [Paint]
    c.drawCircle(ctr, 75.0, p);

    // 楕円1の描画
    p.style = PaintingStyle.stroke;
    p.color = Color.fromARGB(150, 200, 0, 255);
    p.strokeWidth = 10.0;
    Rect r = Rect.fromLTWH(dx + 100.0, dy + 50.0, 200.0, 150.0);
    // 楕円を描くにはdrawOval
    // [Rect], [Paint]
    c.drawOval(r, p);

    // 楕円2の描画
    r = Rect.fromLTWH(dx + 50.0, dy + 100.0, 150.0, 200.0);
    c.drawOval(r, p);
  }
}


// 直線を描画するRenderBoxのサンプル
class LinePaintBoxSample extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();
    Paint p = Paint();
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 5.0;
    p.color = Color.fromARGB(150, 0, 200, 255);
    for (var i  = 0; i <= 10; i++) {
      Rect r = Rect.fromLTRB(
        dx + 50.0 + 20 * i, dy + 50.0, dx + 50.0, dy + 250.0 -20 * i);
      // drawLine()で直線を描画
      // Rectの左上と右下を指定して描画する
      c.drawLine(r.topLeft, r.bottomRight, p);
    }
  }
}


// Paragraph
// 作成方法: 1. ParagraphBuilder作成, 2. スタイルやテキスト追加, 3. Paragraph作成 4. レイアウトの設定, 5. パラグラフの描画
class ParagraphSample extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    // 1
    ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      // 左から右へ
        ui.ParagraphStyle(textDirection: TextDirection.ltr)
    )

    // 2
    // pushStyleでTextStyleを設定. flutter.ui
      ..pushStyle(ui.TextStyle(color: Colors.red, fontSize: 48.0))
      ..addText("Hello! ")
      ..pushStyle(ui.TextStyle(color: Colors.blue[700], fontSize: 30.0))
      ..addText("This is a sample of paragraph text.")
      ..pushStyle(ui.TextStyle(color: Colors.blue[200], fontSize: 30.0))
      ..addText("You can draw MULTI-FONT text!");

    // 3
    ui.Paragraph paragraph = builder.build()
    // 4
      ..layout(ui.ParagraphConstraints(width: 300.0));

    // 5
    Offset off = Offset(dx + 50.0, dy + 50.0);
    c.drawParagraph(paragraph, off);
  }
}


// 画像の描画サンプル
class ImageRenderBoxSample extends RenderBox {
  ui.Image _image;

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  ImageRenderBoxSample() {
    loadAssetImage("image1.jpg");
  }

  // 画像読み込みメソッド
  // rootBundle.load()で読み込む
  // rootBundle: トップレベルプロパティ. どこからでも利用可能なプロパティ
  // load()は非同期で実行され、戻り値はFuture<ByteData>型
  // Future: Dartの非同期処理の戻り値は、Futureオブジェクトを返す
  // Future<ByteData>型は、非同期処理を行なって将来ByteData型が返ってくるという意味
  // 順序: 1. rootBundle.load 2. Uint8List.view 3. ui.instantiateImageCodec
  // 4. codec.getNextFrame 5. frameinfo.image, markNeedsPaint
  loadAssetImage(String fname) => rootBundle.load(
    "assets/$fname").then( (bd) {
      // bd > 取得したByteData
      // bd.buffer > ByteBuffer
      // Uint8List: イメージのコーデックに関するクラス
      Uint8List u8lst = Uint8List.view(bd.buffer);
      // データを元にイメージのオブジェクトを取得
      // これも非同期処理で、戻り値はFuture<Codec>
      ui.instantiateImageCodec(u8lst).then((codec) {
        // getNextFrame(): 非同期処理で次のアニメーションフレームを取得する
        codec.getNextFrame().then(
            (frameInfo) {
              // ここでようやくイメージを取り出すことができる
              _image = frameInfo.image;
              // 表示更新の通知を送り、UIが更新される
              markNeedsPaint();
              print("_img created; $_image");
            }
        );
      });
  });

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    Paint p = Paint();
    Offset off = Offset(dx + 50.0, dy + 50.0);
    // 200 * 200 の大きさに指定
    Rect r  = Rect.fromLTRB(dx + 50.0, dy + 50.0, 200.0, 200.0);
    if (_image != null) {
      // drawImageで画像を描画
//      c.drawImage(_image, off, p);
      // drawImageRectで領域を指定して画像を描画
      Rect r0 = Rect.fromLTRB(0.0, 0.0, _image.width.toDouble(), _image.height.toDouble());
      c.drawImageRect(_image, r0, r, p);
      print("draw _image.");
    } else {
      print("_image is null.");
    }
  }
}


// パス: 複雑な形状を作成するために用意されているクラス
// 順序: 1. Pathの作成, 2. 図形の追加, 3. パスの描画
class PathSample extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    // 1
    Path path = Path();

    // 2. 楕円形を3つ追加
    Rect r = Rect.fromLTWH(dx + 50.0, dy + 50.0, 75.0, 75.0);
    // addRect: 四角形, addOval: 楕円, addPolygon: 多角形, addArc: 円弧
    path.addOval(r);
    r = Rect.fromLTWH(dx + 75.0, dy + 75.0, 125.0, 125.0);
    path.addOval(r);
    r = Rect.fromLTWH(dx + 125.0, dy + 125.0, 175.0, 175.0);
    path.addOval(r);

    // 現在の状態を保存する
    c.save();

    Paint p = Paint();
    p.color = Color.fromARGB(150, 255, 0, 0);
    p.style = PaintingStyle.fill;
    // 3
    c.drawPath(path, p);

    // 始点を縦に100移動
    c.translate(0.0, 100.0);
    p.color = Color.fromARGB(150, 0, 0, 255);
    c.drawPath(path, p);

    p.color = Color.fromARGB(150, 0, 255, 0);
    // 回転
    c.rotate(-0.5 * pi);
    c.translate(-600.0, -200.0);
    // 1.75倍に拡大
    c.scale(1 * 1.75);
    c.drawPath(path, p);

    // saveした状態に戻す
    // 戻しておかないと、そのほかに描画するものすべてに影響を与えてしまう. 描画したら必ずRestoreする
    c.restore();
  }
}


// クリッピング: 一部の領域をクリップして、その部分だけ描画処理を適用できる仕組み
class ClippingSample extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {

    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    c.save();

    // clipRectで領域を切り取り
    // クリップを解除したい場合には、以前のcanvasを保存しておき、restoreするしか現状方法はない
    c.clipRect(Rect.fromLTWH(dx + 75.0, dy + 75.0, 150.0, 150.0));

    Paint p = Paint();
    p.color = Color.fromARGB(150, 255, 0, 0);
    p.style = PaintingStyle.fill;
    Offset off = Offset(dx + 100.0, dy + 100.0);
    c.drawCircle(off, 50.0, p);

    p.color = Color.fromARGB(150, 0, 255, 0);
    off = Offset(dx + 150.0, dy + 150.0);
    c.drawCircle(off, 75.0, p);

    p.color = Color.fromARGB(150, 0, 0, 255);
    off = Offset(dx + 200.0, dy + 200.0);
    c.drawCircle(off, 100.0, p);

    c.restore();
  }
}

// クリッピングパス: 複雑な形状のクリッピング. Pathを使ってクリッピングを行う
class ClippingPathSample extends RenderBox {

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {

    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    // 3つの円を描く
    Path path = Path();
    Rect r = Rect.fromLTWH(dx + 50.0, dy + 50.0, 75.0, 75.0);
    path.addOval(r);
    r = Rect.fromLTWH(dx + 75.0, dy + 75.0, 125.0, 125.0);
    path.addOval(r);
    r = Rect.fromLTWH(dx + 125.0, dy + 125.0, 175.0, 175.0);
    path.addOval(r);

    Paint p = Paint();
    p.style = PaintingStyle.fill;

    c.save();
    // 指定したパスでクリッピング. 三つの円でクリッピングしている
    c.clipPath(path);

    // クリッピングしたキャンバスに合計100個の円を描く
    for (var i = 0; i < 100; i++) {
      Random random = Random();
      // 高さ、幅、半径をランダム抽選
      double w = random.nextInt(dx + 300).toDouble();
      double h = random.nextInt(dy + 300).toDouble();
      double cr = random.nextInt(50).toDouble();

      // 色もランダム抽選
      int r = random.nextInt(255);
      int g = random.nextInt(255);
      int b = random.nextInt(255);

      p.color = Color.fromARGB(50, r, g, b);
      // クリッピングしたキャンバスに円を描く
      c.drawCircle(Offset(w, h), cr, p);
    }
    // 最終的にはキャンバスをリストアしておく
    c.restore();
  }
}


// ブレンドモード: 複数のグラフィックを合成するためにブレンドを用いる
// さまざまなモードがあり、それによってグラフィックが変わってくる
// やり方1. drawColorを使用する
class BlendDrawColorSample extends RenderBox {
  ui.Image _image;

  BlendDrawColorSample() {
    loadAssetImage("image1.jpg");
  }

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    if (_image != null) {
      c.drawImage(_image, Offset(dx + 50.0, dy + 50.0), Paint());
    }

    // ブレンドモードmultiply: 指定の色を乗算する
    // 以下では青色フィルタを通してみたようになる
    c.drawColor(Color.fromARGB(255, 0, 0, 255), BlendMode.multiply);
  }

  // 画像読み込み
  loadAssetImage(String fname) => rootBundle.load(
      "assets/$fname").then( (bd) {
    Uint8List u8lst = Uint8List.view(bd.buffer);
    ui.instantiateImageCodec(u8lst).then((codec) {
      codec.getNextFrame().then(
              (frameInfo) {
            _image = frameInfo.image;
            markNeedsPaint();
            print("_img created; $_image");
          }
      );
    });
  });
}


// クリッピングにより一部だけブレンドモードをかけるサンプル
class BlendDrawColorClipSample extends RenderBox {
  ui.Image _image;

  BlendDrawColorClipSample() {
    loadAssetImage("image1.jpg");
  }

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    if (_image != null) {
      c.drawImage(_image, Offset(dx + 50.0, dy + 50.0), Paint());
    }

    Paint p = Paint();
    p.style = PaintingStyle.fill;

    c.save();
    // クリッピングした領域をブレンドモードをかける
    Rect r = Rect.fromLTWH(dx + 70.0, dy + 70.0, 130.0, 130.0);
    c.clipRect(r);
    c.drawColor(Color.fromARGB(255, 255, 0, 0), BlendMode.darken);

    c.restore();

    // クリッピングした領域をブレンドモードをかける
    r = Rect.fromLTWH(dx + 200.0, dy + 200.0, 130.0, 130.0);
    c.clipRect(r);
    c.drawColor(Color.fromARGB(255, 0, 255, 0), BlendMode.lighten);

    c.restore();
  }

  // 画像読み込み
  loadAssetImage(String fname) => rootBundle.load(
      "assets/$fname").then( (bd) {
    Uint8List u8lst = Uint8List.view(bd.buffer);
    ui.instantiateImageCodec(u8lst).then((codec) {
      codec.getNextFrame().then(
              (frameInfo) {
            _image = frameInfo.image;
            markNeedsPaint();
            print("_img created; $_image");
          }
      );
    });
  });
}


// Paintによるブレンドモードの設定
// 2. Paintによってブレンドモードを設定する
class BlendPaintSample extends RenderBox {
  ui.Image _image;

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    double dx = offset.dx + 30.0;
    double dy = offset.dy + 30.0;

    if (_image != null) {
      c.drawImage(_image, Offset(dx, dy), Paint());
    }

    Paint p = Paint();
    p.style = PaintingStyle.fill;
    p.blendMode = BlendMode.darken;

    for (var i = 0; i < 10; i++) {
      for (var j = 0; j < 10; j++) {
        p.color = Color.fromARGB(255, 25 * i, 0, 25 * j);
        Rect r = Rect.fromLTWH(dx + 30.0 * i, dy + 30.0 * j, 30.0, 30.0);
        c.drawOval(r, p);
      }
    }
  }
}


// グラフィックのタップイベント処理
// RenderBoxにはタップイベントが用意されていないため、メソッドを用意する必要がある
// PointerEvent: タップした位置などの情報をまとめたもの
// HitTestEntry: HitTestによる情報をまとめたもの
class RenderTapSample extends RenderBox {
  ui.Image _image;
  Offset _pos;

  @override
  // result: hitTestの結果をまとめたもの
  // ここにadd()でHitTestEntryを追加 -> その後にhandleEvent()が呼ばれるようになる
  bool hitTest(HitTestResult result, { @required Offset position}) {
    result.add(BoxHitTestEntry(this, position));
    return true;
  }

  @override
  // PointerEvent: ここに発生したイベント情報がまとめられている
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    super.handleEvent(event, entry);
    // event.position: 位置情報(Offset値)
    // そのほかにも、down,buttons,kind,orientation,pressureなどが用意されている
    _pos = event.position;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    c.drawColor(Colors.black, BlendMode.clear);
    if (_pos != null) {
      Paint p = Paint();
      p.style = PaintingStyle.fill;
      for (var i = 0; i < 10; i++) {
        p.color = Color.fromARGB(50, 255, 255, 255);
        c.drawCircle(_pos, i * 5.0, p);
      }
    }
  }
}


// CustomPaint: Canvasを表示するだけのウィジェット
// 基本形: CustomPaint(painter: [CustomPainter])
// CustomPainter: 描画を表示するウィジェットとして機能する
// 基本形: extends CustorPainter{ void paint(), bool shouldRepaint()}
class CustomPainterSample extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "App Name",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      body: Center(
        child: CustomPaint(
          painter: PainterSample(),
        ),
      ),
    );
  }
}

class PainterSample extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();
    p.style = PaintingStyle.fill;
    p.color = Colors.black;
    print(size);

    // ランダムな位置、ランダムな色で円を100個作る
    // 描画処理はRendarBoxとなんらかわりない
    for (var i = 0; i < 100; i++) {
      Random random = Random();
      // -150 ~ 149
      double w = random.nextInt(300).toDouble() - 150;
      double h = random.nextInt(300).toDouble() - 150;
      double cr = random.nextInt(300).toDouble();
      int r = random.nextInt(255);
      int g = random.nextInt(255);
      int b = random.nextInt(255);

      p.color = Color.fromARGB(50, r, g, b);
      canvas.drawCircle(Offset(w, h), cr, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


// CustomPaintのタップイベント
// Listenerを使用する
// ConstrainedBox: なにも表示されないウィジェット
// ConstrainedBoxとListenerを組み合わせてタップイベントを取得する
// 基本形: ConstrainedBox(constraints: BoxConstrains.expand())
class CustomPainterTapSample extends State<MyHomePage> {

  // ウィジェットにIDを割り当てるもの
  GlobalKey _homeStateKey = GlobalKey();
  Offset _pos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "App Name",
          style: TextStyle(
            fontSize: 30.0
          ),
        ),
      ),
      body: Center(
        child: Listener(
          onPointerDown: _pointerDown,
          onPointerMove: _pointerMove,
          child: CustomPaint(
            // 一意のキーを割り当てる. _homeStateKey.currentContextで
            // _homeSateKeyが割り当てられているウィジェットが取り出せる
            key: _homeStateKey,
            painter: PainterTapSample(_pos),
            child: ConstrainedBox(
                constraints: BoxConstraints.expand()
            ),
          ),
        ),
      ),
    );
  }

  void _pointerDown(PointerDownEvent event) {
    // RenderObjectというレンダリングを行うオブジェクトを取得
    RenderBox referenceBox = _homeStateKey.currentContext.findRenderObject();
    setState(() {
      // posの値を更新して、PainterTapSampleのposも変更し、表示を更新している
      // globalToLocalで引数の座標をローカル座標に変換している（相対座標）
      _pos = referenceBox.globalToLocal(event.position);
    });
  }

  void _pointerMove(PointerMoveEvent event) {
    RenderBox referenceBox = _homeStateKey.currentContext.findRenderObject();
    setState(() {
      // posの値を更新して、PainterTapSampleのposも変更し、表示を更新している
      _pos = referenceBox.globalToLocal(event.position);
    });
  }
}

class PainterTapSample extends CustomPainter {
  Offset _pos;

  // コンストラクタでタップした位置情報を取得する
  PainterTapSample(this._pos);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();
    p.style = PaintingStyle.fill;
    p.color = Color.fromARGB(25, 255, 0, 0);
    if (_pos != null) {
      for (var i = 0; i < 10; i++) {
        canvas.drawCircle(_pos, 10.0 * i, p);
      }
      canvas.drawCircle(_pos, 50.0, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


/**
 * 第7章 ナビゲーション/ファイルアクセス/設定情報/データベースアクセス
 */

// Navigator: 画面遷移用のクラス
// Navigator.push([BuildContext], [Route])
// Navigator.pop([BuildContext])    の2つで成り立つ
class FirstScreen extends StatefulWidget {

  // コンストラクタ
  FirstScreen({Key key}): super(key: key);

  @override
  _FirstScreenState createState() => new _FirstScreenState();

}

class _FirstScreenState extends State<FirstScreen> {
  final _controller = TextEditingController();
  String _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: <Widget>[
          Text("Home Screen"),
          Padding(padding: EdgeInsets.all(10.0),),
          TextField(
            controller: _controller,
            onChanged: changeField,
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text("next"),
            icon: Icon(Icons.navigate_next)
          )
        ],
        onTap: (int value) {
          // BottomNavigationBarItemのNextをタップしたら画面遷移
          if (value == 1) {
            // 画面の表示に関する情報はRouteクラスで管理されている
            // RouteのサブクラスPageRouteで現在の表示をそのままPageRouteクラスのインスタンスにおきかえて記憶
            // ある画面から次の画面に遷移 -> この画面をPageRouteインスタンスに置き換えて、これを保管すること
            // 前の画面に戻る -> 保管してあったPageRouteインスタンスを取り出して画面に戻すこと
            // 引数に入れることで画面間の値の受け渡しができる
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SecondScreen(_input)));
          }
        },
      ),
    );
  }

  void changeField(String val) => _input = val;
}



class SecondScreen extends StatelessWidget {
  final String _value;

  SecondScreen(this._value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pushで起動するとAppBarに自動的に←ボタンが表示される
      appBar: AppBar(
        title: Text("Next"),
      ),
      body: Center(
        child: Text("you typed: $_value.",),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("prev"),
            icon: Icon(Icons.navigate_before),
          ),
          BottomNavigationBarItem(
            title: Text("?"),
            icon: Icon(Icons.android),
          )
        ],
        onTap: (int value) {
          // BottomNavigationBarItemの戻るを押したら画面を戻す
          if (value == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}


// pushによる画面遷移: インスタンスを作成してPageRouteを作る処理を記述しないといけない欠点がある
// Route: あらかじめルートと表示するウィジェットの関係を定義
// 基本形: routes: {"アドレス" : (context) => ウィジェット, ..繰り返し..}
// routesによるルーティングと呼ぶ
class RoutesSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // ここで指定したキーが最初に表示されるウィジェットになる
      initialRoute: "/",
      routes: {
        // routesでは、以下のように定義
        // initialRouteと同じキーが最初に表示されるウィジェットとなる
        "/": (context) => FirstRouteScreen(),
        "/second": (context) => SecondRouteScreen("Second"),
        "/third": (context) => SecondRouteScreen("Third"),
      },
    );
  }
}

class FirstRouteScreen extends StatefulWidget {

  FirstRouteScreen({Key key}) : super(key: key);

  @override
  _FirstScreenRouteState createState() => new _FirstScreenRouteState();
}

class _FirstScreenRouteState extends State<FirstRouteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("next"),
            icon: Icon(Icons.navigate_next),
          )
        ],
        onTap: (int value) {
          if (value == 1) {
            Navigator.pushNamed(context, "/second");
          }
        },
      ),
    );
  }
}

class SecondRouteScreen extends StatelessWidget {
  final String _value;

  SecondRouteScreen(this._value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next"),
      ),
      body: Center(
        child: Text("$_value screen"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("prev"),
            icon: Icon(Icons.navigate_before)
          ),
          BottomNavigationBarItem(
            title: Text("?"),
            icon: Icon(Icons.android)
          )
        ],
        onTap: (int value) {
          if (value == 0) Navigator.pop(context);
          if (value == 1) {
            Navigator.pushNamed(context, "/third");
          }
        },
      ),
    );
  }
}


// ファイルアクセス
// File(ファイルパス)
// 書き出し（非同期）: Future<File> writeAsString([String]);
// 書き出し（同期）: Future<File> writeAsStringSync([String]);
// 読み込み（非同期）: try {変数 = await [File].readAsString()};
// 読み込み（同期）: try{変数 = await [File].readAsStringSync()};
// Path Providerをpubspec.yamlファイルに記述してインストールする準備が必要
class FileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => FirstFileScreen(),
      },
    );
  }
}

class FirstFileScreen extends StatefulWidget {

  FirstFileScreen({Key key}): super(key: key);

  @override
  _FirstFileScreenState createState() => new _FirstFileScreenState();
}

class _FirstFileScreenState extends State<FirstFileScreen> {

  final _controller = TextEditingController();
  final _fname = "mydata.txt";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: <Widget>[
          Text("Home Screen"),
          Padding(padding: EdgeInsets.all(20.0),),
          TextField(
            controller: _controller,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Save"),
            icon: Icon(Icons.save)
          ),
          BottomNavigationBarItem(
            title: Text("Load"),
            icon: Icon(Icons.open_in_new)
          )
        ],

        onTap: (int value) {
          switch (value) {
            case 0:
              saveIt(_controller.text);
              setState(() {
                // 保存後は入力ボックスを空にしておく
                _controller.text = "";
              });
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("saved!"),
                  content: Text("save message to file."),
                )
              );
              break;

            case 1:
              setState(() {
                loadIt().then((String value) {
                  // 値を読み込んだ後の処理
                  setState(() {
                    _controller.text = value;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("loaded!"),
                      content: Text("load message from file."),
                    )
                  );
                });
              });
              break;

            default:
              print("no default.");
          }
        },
      ),
    );
  }

  // Fileインスタンスを取得する
  // 非同期関数を使用しているためメソッド自体も非同期にしている
  Future<File> getDataFile(String filename) async {
    // アプリに割り当てられているフォルダパスを調べて取得する
    final directory = await getApplicationDocumentsDirectory();
    // アプリのパスとファイル名を付与したパスでFileインスタンス取得
    return File(directory.path + "/" + filename);
  }

  void saveIt(String value) async {
    // Fileインスタンスを呼び出したあとにthen()が走る
    // 値を書き出している
    getDataFile(_fname).then((File file) {
      file.writeAsString(value);
    });
  }

  // 値の読み込み
  Future<String> loadIt() async {
    try {
      final file = await getDataFile(_fname);
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}


// SharedPreference
// アプリのデータ類はFileに保存するが、アプリの細々とした設定情報などは、もっとお手軽に保存できる
// keyとvalueで保存や取得ができる. int,double,bool,String,List<String>のみ
// 基本形: SharedPreferences.getInstance().then((SharedPreferences prefs) .....)
class PreferencesSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Generated App",
      initialRoute: "/",
      routes: {
        "/": (context) => FirstPreferencesScreen()
      },
    );
  }
}

class FirstPreferencesScreen extends StatefulWidget {

  FirstPreferencesScreen({Key key}): super(key: key);

  @override
  _FirstPreferencesScreen createState() => new _FirstPreferencesScreen();
}

class _FirstPreferencesScreen extends State<FirstPreferencesScreen> {
  final _controller = TextEditingController();
  double _r = 0.0;
  double _g = 0.0;
  double _b = 0.0;

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home")
      ),
      body: Container(
        color: Color.fromARGB(200, _r.toInt(), _g.toInt(), _b.toInt()),
        child: Column(
          children: <Widget>[
            Text("Home Screen"),
            Padding(padding: EdgeInsets.all(20.0),),
            TextField(
              controller: _controller,
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            Slider(
              min: 0.0,
              max: 255.0,
              value: _r,
              divisions: 255,
              onChanged: (double value) {
                setState(() {
                  _r = value;
                });
              },
            ),
            Slider(
              min: 0.0,
              max: 255.0,
              value: _g,
              divisions: 255,
              onChanged: (double value) {
                setState(() {
                  _g = value;
                });
              },
            ),
            Slider(
              min: 0.0,
              max: 255.0,
              value: _b,
              divisions: 255,
              onChanged: (double value) {
                setState(() {
                  _b = value;
                });
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: () {
          savePref();
          showDialog(
            context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("saved!"),
                content: Text("save preferences."),
              )
            );
        },
      ),
    );
  }

  // 保存した値の取得処理
  void loadPref() async {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        // 値が存在しなかった場合は0.0を取得
        _r = (prefs.getDouble("r") ?? 0.0);
        _g = (prefs.getDouble("g") ?? 0.0);
        _b = (prefs.getDouble("b") ?? 0.0);
        _controller.text = (prefs.getString("input") ?? "");
      });
    });
  }

  // 値の保存処理
  void savePref() async {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      prefs.setDouble("r", _r);
      prefs.setDouble("g", _g);
      prefs.setDouble("b", _b);
      prefs.setString("input", _controller.text);
    });
  }
}


// データベースアクセス: sqliteを使用
// iPhoneやAndroidは内部にSQLiteが組み込まれている
// pubspec.yamlでSQFLiteを取り込む必要あり
// 基本形: データベースを開く
// Database database = await openDatabase(DBファイル, バージョン, onCreate: ....)
// 基本形: オープン時の作成処理
// (Database db, int version) async {....}
// 基本形: テーブル操作を伴わない処理の実行
// await [Database].execute(.....)
// 基本形: レコード取得
// List<Map> 変数 = await [Database].rawQuery(.....);
// 基本形: テーブルの書き換えとトランザクション
// await database.transaction((txn) async {.....});
// DB操作の主なメソッド
// 取得: rawQuery(), 保存: rawInsert(), 更新: rawUpdate(), 削除: rawDelete()
class DatabaseUsageSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "My APP",
      initialRoute: "/",
      routes: {
        "/": (context) => FirstDatabaseScreen(),
        "/list": (context) => SecondDatabaseScreen(),
      },
    );
  }
}

class FirstDatabaseScreen extends StatefulWidget {

  FirstDatabaseScreen({Key key}): super(key: key);

  @override
  _FirstDatabaseScreenState createState() => new _FirstDatabaseScreenState();
}

class _FirstDatabaseScreenState extends State<FirstDatabaseScreen> {
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();

  final TextStyle styleA = TextStyle(
    fontSize: 28.0,
    color: Colors.black87,
  );

  final TextStyle styleB = TextStyle(
    fontSize: 24.0,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Home Screen"),
            Text("Name: ", style: styleB,),
            TextField(controller: _controllerA, style: styleA,),
            Text("Mail: ", style: styleB,),
            TextField(controller: _controllerB, style: styleA,),
            Text("TEL: ", style: styleB,),
            TextField(controller: _controllerC, style: styleA,)
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("add"), icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text("list"), icon: Icon(Icons.list)
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            // 画面遷移
            Navigator.pushNamed(context, "/list");
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
//          saveData();
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Saved!"),
              content: Text("insert data into database."),
            )
          );
        },
      ),
    );
  }

  // DB保存処理
  // 手順①~④
  // path.dartのインポートの関係でコメント化
//  void saveData() async {
//    // ①パスの取得
//    // dbファイルのパスをgetDatabasePath()で取得
//    String dbPath = await getDatabasesPath();
//    // ファイルパスの取得
//    String path = join(dbPath, "mydata.db");
//
//    // ②データの用意
//    // テキストフィールドに入力されたテキスト
//    String data1 = _controllerA.text;
//    String data2 = _controllerB.text;
//    String data3 = _controllerC.text;
//    // クエリのデータも用意
//    String query = 'INSERT INTO mydata(name, mail, tel) VALUES("$data1", "$data2", "$data3")';
//
//    // ③データベースのオープン
//    Database database = await openDatabase(path, version: 1,
//        onCreate: (Database db, int version) async {
//      // テーブルが存在しない場合はファイルを作成するクエリ文
//          await db.execute("CREATE TABLE IF NOT EXISTS mydata (id INTEGER"
//              "PRIMARY KEY, name TEXT, mail TEXT, tel TEXT)");
//        });
//
//    // ④トランザクションによる保存
//    // DB保存はトランザクションを利用して行われる
//    // トランザクションを管理するクラスインスタンスがtxnに入る
//    await database.transaction((txn) async {
//      // rawInsert: レコードの追加
//      int id = await txn.rawInsert(query);
//      print("insert: $id");
//    });
//
//    setState(() {
//      _controllerA.text = "";
//      _controllerB.text = "";
//      _controllerC.text = "";
//    });
//  }
}

class SecondDatabaseScreen extends StatefulWidget {

  SecondDatabaseScreen({Key key}): super(key: key);

  @override
  _SecondDatabaseScreen createState() => new _SecondDatabaseScreen();
}

class _SecondDatabaseScreen extends State<SecondDatabaseScreen> {
  List<Widget> _items = <Widget>[];

  @override
  void initState() {
    super.initState();
//    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: ListView(
        children: _items,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("add"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text("list"),
            icon: Icon(Icons.list)
          )
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // DB取得処理
  // 手順①~③
  // path.dartのインポートの関係でコメント化
//  void getItems() async {
//    List<Widget> list = <Widget>[];
//    String dbPath = await getDatabasesPath();
//    String path = join(dbPath, "mydata.db");
//
//    Database database = await openDatabase(path, version: 1,
//        onCreate: (Database db, int version) async { await db.execute(
//      "CREATE TABLE IF NOT EXISTS mydata (id INTEGER PRIMARY KEY, name TEXT, mail TEXT, tel TEXT)");
//    });
//
//    // ①レコードの取得
//    // rawQuery: レコードを取得する一文を実行. 各レコードがMapに詰められる
//    List<Map> result = await database.rawQuery("SELECT * FROM mydata");
//
//    // ②レコードからListを作成
//    for (Map item in result) {
//      list.add(ListTile(
//        title: Text(item["name"]),
//        subtitle: Text(item["mail"] + " " + item["tel"]),
//      ));
//    }
//
//    // ③UIを更新する
//    setState(() {
//      _items = list;
//    });
//  }
}