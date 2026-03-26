class CategoriesController < ApplicationController
  CATEGORY_LIST = [
    # 画面（フロント）側が期待しているカテゴリを常に返す
    "事務",
    "エンジニア",
    "営業",
    "デザイン",
    "マーケティング",
    "物流・運輸",
    "医療・福祉",
    "カスタマーサポート",
    "旅行・観光",
    "教育・研修",
    "販売・接客",
    "企画・マネージャー",
  ].freeze

  # GET /categories
  def index
    render json: CATEGORY_LIST
  end
end

