(require 'nc-timeline)

;; チャンネルの概念で SNS を横断して通知を一括管理
;;
;;   twitter のタイムライン
;;   twitter のリプライ
;;   lingr のルーム
;;   slack のチャンネル
;;   メールのチャンネル
;;
;; ... など
;;
;; 適当な API で通知を投げるとよしなにまとめといてくれる

;; [ユーザーに見える機能]
;;
;; - リアルタイム通知 (minibuffer とかで)
;;   - チャンネルごとにオンオフしたい
;;
;; - 未読の管理
;;   - 同じ通知が複数チャンネルに投げられた場合どうする？ (timeline と
;;     mentions とか)
;;
;; - タイムライン表示
;;   - チャンネルごとに (Notification -> String) のレンダラをセットでき
;;   - る
;;   - SNS 特有の処理 (fav とか) はタイムラインの中に書くチャンネルが自
;;     分でボタンを埋め込めばよさそう
;;   - 一番上まで見たらさかのぼり？
;;
;; - symon への API (未読件数表示) があってもいい
;;
;; - フィルタ的なサムシング
;;   - いくつかのチャンネルにまたがった notifications をなんかしらの基
;;     準でまとめたり、特定の通知を無視したり

;; [チャンネル実装者向けのユーティリティ]
;;
;; - アカウント追加処理、ストリームopen/close処理、タイムラインレンダラ、
;;   とか設定するだけでよしなにしてくれるような (symon 的な) チャンネル
;;   定義 API ?
;;
;; - 汎用のタイムラインレンダラ
;;
;; - アカウント管理とか地味にめんどくさいしよしなにやってくれる機能があっ
;;   てもいいかもね
;;   - oauth の wrapper ?
;;   - access token (パスワード) の暗号化保存
;;
;; - タイムラインのレンダラ作るときに便利なライブラリ
;;   - インライン画像の (jit-lock 使った) 遅延ロードとかいろんなチャン
;;     ネルで使いたいかも
;;   - ほかのチャンネルとある程度見た目をそろえられるように共通の face
;;   - があっていい
;;   - タイムスタンプのフォーマットをいい感じにしてくれるやつ (4d とか)
;;
;; - API access 周りの各種ラッパー？
;;   - comet, stream, json parse/dump

;; [通知オブジェクトのイメージ]
;;
;;   (notification
;;    ;; サービス名 (チャンネルをグループ化するときに使う)
;;    :category  twitter
;;    ;; チャンネル名
;;    :channel   mentions
;;    ;; 通知の内容 (チャンネル共通)
;;    :from      "zk_phi"
;;    :body      "こんにちは！！！！"
;;    :timestamp "0000-00-00 00:00:00" ; (Tが入ってもok)
;;    ;; サービス特有のデータ
;;    :entity    ((in_reply_to_status_id . 100) ....))

;; * utilities

(defun notification-center-make-button (str action &rest props)
  "Make a string button and return it. This is NOT a destructive
function unlike `make-text-button'."
  (declare (indent 1))
  (let ((str (copy-sequence str)))
    (apply 'make-text-button str 0 'action action props)
    str))

(provide 'notification-center)
