class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.integer   :number, null: false  #背番号 null: falseはNOT NULL制約をつけ、からの値が保存されないようにする
      t.string    :name, null: false    #名前
      t.string    :full_name             #本名
      t.string    :email                 #メールアドレス
      t.date      :birthday                  #生年月日
      t.integer   :sex, null: false, default: 1  #性別 (1:男 2:女) カラムにNOT NULL制約をつけデフォルトを１とする
      t.boolean   :administrator, null: false, default: false #管理者フラグ
      t.timestamps
    end
  end
end

#stringは文字列型、integerは整数型
