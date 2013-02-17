# encoding: UTF-8
module ApplicationHelper

  def header(content, params={})
    content_for :header do
    	raw "<h1>#{content}</h1> <h4 class=\"subheader\">#{params[:subheader]}</h4>"
    end
  end


  def survey_items_html_array
    init = { 	multiple_fields_question: nil,
      				text_field_question: nil,
      				multiple_select_question: nil,
      				single_select_question: nil,
      				page_break: nil,
      				desc_text: nil,
      				drop_down_question: nil,
      				scale_question: nil }.stringify_keys
    init.each_key{|x| init[x] = render("survey_items/forms/#{x}") }.to_json
  end

  def render_survey_item(item)
    render(partial: "survey_items/items/#{item.type.demodulize.underscore}", locals:{item: item})
  end

  def insert_button
    raw '<div class="insert-button-wrapper"><button class="btn insert_buttons success">
    <i class="icon-angle-double-left"></i> Insert here <i class="icon-angle-double-right"></i></button></div>'
  end

  def page_header(text)
    raw <<-EOS
      <div class="page-header"><h1>#{text}</h1></div>
    EOS
  end

  def flash_messages
    raw(flash.collect do |key, value|
      <<-EOS
      <div class="flash-message-outer #{key}">
        <div class="flash-message">
          #{value}
          <a class="close" href="javascript:void(0)">x</a>
        </div>
      </div>
      EOS
    end.join(''))
  end

end

