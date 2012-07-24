module ApplicationHelper

  def header(content, params={})
    content_for :header do
    	raw "<h1>#{content}</h1> <h4 class=\"subheader\">#{params[:subheader]}</h4>"
    end
  end


  def survey_items_html_array
    init = { 	multiple_fields_question: nil,
      				open_question: nil,
      				multiple_select_question: nil,
      				single_select_question: nil,
      				page_break: nil,
      				image: nil,
      				desc_text: nil,
      				scale_question: nil }.stringify_keys
    init.each_key{|x| init[x] = render("survey_items/forms/#{x}") }.to_json
  end

  def render_survey_item(item)
    render(partial: "survey_items/items/#{item.type.demodulize.underscore}", locals:{item: item})
  end

end

