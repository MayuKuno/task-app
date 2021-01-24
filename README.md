# Project Title
Task-app

## Project Overview


## Production environment


## Motivation

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
|user_id|integer|null: false, foreign_key: true|
|taskname|string|null: false| 
|description|text|null: false| 
|priority(enum)|integer|null: false|
|status(enum)|integer|null: false|
|deadline|date|null: false|


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


 

## Authors
**Mayu Kuno** 
　- [Github](https://github.com/MayuKuno)
　- [Portfolio](https://ninefsblog.herokuapp.com/)


## Function/features to improve
