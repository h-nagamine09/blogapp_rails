$(document).on("turbolinks:load",function() {//jqueryを書くときの決まり文句
  // 日時入力欄の表示非表示を切り替える機能が組み込まれる
  var cd = $("#article_no_expiration");
  var field = #("article_expired_at");

// チェックボックス[掲載終了日時を表示しない]にチェックが入っていたらtrueを、チェックが外れていたらfalseを返す
  var changeExpiredAt = fonction () {
    if(cd.prop("checked"))
      field.hide()
    else
      field.show()
  }
// チェックボックスがクリックされた時に関数changeExpiredAtが呼び出される
  cd.bind("click", changeExpiredAt);

  changeExpiredAt();
})
