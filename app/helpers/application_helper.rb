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
              video_question: nil,
              single_select_grid: nil,
      				scale_question: nil }.stringify_keys
    init.each_key{|x| init[x] = render("survey_items/forms/#{x}") }.to_json
  end

  def render_survey_item(item)
    render(partial: "survey_items/items/#{item.type.demodulize.underscore}", locals:{item: item})
  end

  def insert_button
    raw '<div class="insert-button-wrapper"><button class="btn insert_buttons success">
    <i class="icon-angle-double-left"></i> <span>Insert here</span> <i class="icon-angle-double-right"></i></button></div>'
  end

  def page_header(text, opts = {nomargin: false, submenu: nil, default_survey_menu: nil})
    opt_classes = opts[:nomargin] ? 'nomargin' : ''
    submenu = opts[:submenu] && "<div class=\"subheader\">#{opts[:submenu]}</div>"
    submenu = opts[:default_survey_menu] && "<div class=\"subheader\">
        #{link_to(raw('<i class="icon-pencil-2"></i>edit'), [:edit, @survey], class: 'light')} | 
        #{link_to(raw('<i class="icon-tools"></i>builder'), [:builder, @survey], class: 'light')} | 
        #{link_to(raw('<i class="icon-chat-1"></i>responses'), [@survey, :responses], class: 'light')} | 
        #{link_to(raw('<i class="icon-doc-text"></i>report'), [:report, @survey], class: 'light')} |
        <b>#{link_to(raw('<i class="icon-share"></i>share'), [:share, @survey], class: 'light')}</b></div>"
    raw <<-EOS
      <div class="page-header #{opt_classes}"><h1>#{text}</h1>#{submenu}</div>
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

