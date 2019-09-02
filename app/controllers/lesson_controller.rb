class LessonController < ApplicationController
  def step1
    render plain: "こんにちは、#{params[:name]}さん"
  end

  def step2
    render plain: params[:controller] + "#" + params[:action] #コントローラー名とアクション名を取り出す
  end

  def step3
    redirect_to action: "step4" #step3に飛んだ場合redirect_toアクションで自動的にstep4へジャンプする
  end

  def step4
    render plain: "step4に移動しました"
  end

  def step5
    flash[:notice] = 'step6へ移動します'
    redirect_to action: 'step6'
  end

  def step6
    render plain: flash[:notice]
  end

  def step7
    @price = (2000 * 1.08).floor #税込みの金額を表示する
  end

  def step8
    @price = 1000
    render "step7"
  end

  def step9
    @comment = "<script>alert('危険')</script>こんにちは。"
  end

  def step10
    @comment = "<strong>安全なHTML</strong>"
  end

  def step11
    @population = 70414
    @surface = 141.31
  end

  def step12
    @time = Time.current
  end

  def step13
    @population = 127767944
  end

  def step14
    @message = "ごきげんいかが？\nRailsの勉強を頑張りましょう"
  end

  def step15
    @zaiko = 10
  end

  def step16
    @items = {"フライパン" => 2680, "ワイングラス" => 2550,
              "ペッパーミル" => 4515, "ピーラー" =>945}
  end
end
