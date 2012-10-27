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
      				image: nil,
      				desc_text: nil,
      				drop_down_question: nil,
      				scale_question: nil }.stringify_keys
    init.each_key{|x| init[x] = render("survey_items/forms/#{x}") }.to_json
  end

  def render_survey_item(item)
    render(partial: "survey_items/items/#{item.type.demodulize.underscore}", locals:{item: item})
  end

  def insert_button
    raw '<button class="btn btn-mini btn-success btn-block insert_buttons">
    <i class="icon-circle-arrow-left"></i> Insert here <i class="icon-circle-arrow-right"></i></button>'
  end

  def ribbed_header(text)
    raw <<-EOS
      <div class="ribbon">
        <div class="ribbon-stitches-top"></div>
        <strong class="ribbon-content"><h1>#{text}</h1></strong>
        <div class="ribbon-stitches-bottom"></div>
      </div>
      <div class="ribbon-spacer"></div>
    EOS
  end

end

