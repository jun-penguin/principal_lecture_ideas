module Api::PostsHelper
  def add_search_word(search_params)
    search_word = search_params[:title_or_description_or_content_cont_any]
    full_word = half_to_full(search_word)
    half_word = full_to_half(search_word)
    kana_word = to_kana(search_word)
    hira_word = to_hira(search_word)
    search_params[:title_or_description_or_content_cont_any] = [full_word, half_word, kana_word, hira_word]
    search_params
  end

  def half_to_full(str)
    str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
  end

  def full_to_half(str)
    str.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')
  end

  def to_kana(str)
    str.tr('ぁ-ん', 'ァ-ン')
  end

  def to_hira(str)
    str.tr('ア-ン', 'あ-ん')
  end
end
