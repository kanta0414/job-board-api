class CategoriesController < ApplicationController
  CATEGORY_LIST = [
    # 画面（フロント）側が期待しているカテゴリを常に返す（スクショ準拠）
    "事務",
    "エンジニア",
    "営業",
    "デザイン",
    "マーケティング",
    "財務・経理",
    "人事",
    "カスタマーサポート",
    "製造",
    "医療・介護",
  ].freeze

  # GET /categories
  def index
    render json: CATEGORY_LIST
  end
end

