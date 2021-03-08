# Project Title
Task-app

## Project Overview
タスクアプリ
ユーザーは、以下の機能を使うことができます。
・タスクの登録、一覧、編集、削除
・グラフを使ったタスクの可視化
・カレンダーを使ったタスク期日の可視化
・タスクの検索
・CSVファイルによるタスクのインポート、エクスポート
・グループ作成
・作成したグループ内でタスクの管理
・期日の近いタスクがある場合、メール通知
※管理者の場合
・登録ユーザーの管理


## Production environment 本番環境
[サイトへ](https://ninefs-task-app.herokuapp.com/)


## Motivation
アプリ開発としての基本のアプリケーションと言えるtodo管理アプリを作成を作成し、railsだけではなく、JS、JQueryの知識を着実に身に付けました。

## Paper Prototyping and ER Diagram

<img width="1440" src="https://i.gyazo.com/a98b1e795b2d00968f6a8e0a26d5b84e.png">
<img width="1440" src="https://i.gyazo.com/d3be2dec304ddd850b27c7e509d9fe4d.png">
<img width="1440" src="https://i.gyazo.com/c4dc17bd69e92d978908069be50408f9.png">


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|username|string|null: false|
|email|string|null: false, unique: true|
|image|string|null: false|
|password|string|null: false|

### Association
- has_many :tasks



## tasksテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|taskname|string|null: false| 
|description|text| 
|priority(enum)|integer|
|status(enum)|integer|
|deadline|date|


### Association
- belongs_to :user
- has_many :task_labels
- has_many  :labels,  through:  :task_labels



## labelsテーブル
|Column|Type|Options|
|------|----|-------|
|color|string|null: false, foreign_key: true|<!-- データ型チェック 色はtextでOK？ -->

### Association
- has_many :task_labels
- has_many  :tasks,  through:  :task_labels


## task_labelsテーブル
|Column|Type|Options|
|------|----|-------|
|task_id|integer|null: false, foreign_key: true|
|label_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :tasks
- belongs_to :labels


## Tech/framework used
 - Ruby
 - Rails
 - Javascript
 - jQuery
 - HTML・CSS
 - Heroku
 - MySQL
 - Mac Catalina(10.15.5)
 - VSCode
 
## Authors
**Mayu Kuno** 
　- [Github](https://github.com/MayuKuno)
　- [Portfolio](https://ninefsblog.herokuapp.com/)


## Function/Features to improve
- グループ作成時の招待メールの送付機能

