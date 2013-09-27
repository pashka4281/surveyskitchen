# encoding: UTF-8
module ApplicationHelper

  def header(content, params={})
    content_for :header do
      raw "<h1>#{content}</h1> <h4 class=\"subheader\">#{params[:subheader]}</h4>"
    end
  end

  def title(str)
    content_for :title do
    	raw "SurveysKitchen - #{str}"
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
    <i class="icon-angle-double-left"></i> <span></span> <i class="icon-angle-double-right"></i></button></div>'
  end

  def translates_for_builder
    {
      loading_item:  t('surveys.builder.loading_item')
    }.to_json
  end

  def page_header(text, opts = { submenu: nil, default_survey_menu: false})
    submenu = opts[:submenu] && "<div class=\"subheader\">#{opts[:submenu]}</div>"
    submenu ||= opts[:default_survey_menu] && survey_subtitle
    submenu ||= opts[:default_client_menu] && client_subtitle

    raw <<-EOS
      <div class="row">
        <div class="col-md-12">
          <div class="pull-left">
            <h3>#{text}</h3>#{submenu}
          </div>
          <div class="pull-right">#{ get_survey_nav_links(opts[:survey_nav_step]) }</div>
        </div>
      </div>
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

  private

  def survey_subtitle
    "<div class=\"subheader\">
        #{link_to(raw('<i class="icon-pencil-2"></i>' + t('surveys.common.edit')), [:edit, @survey], class: 'light')} | 
        #{link_to(raw('<i class="icon-tools"></i>'+ t('surveys.common.builder')), [:builder, @survey], class: 'light')} | 
        #{link_to(raw('<i class="icon-chat-1"></i>'+ t('surveys.common.responses')), [@survey, :responses], class: 'light')} | 
        #{link_to(raw('<i class="icon-doc-text"></i>'+ t('surveys.common.report')), [:report, @survey], class: 'light')} |
        <b>#{link_to(raw('<i class="icon-share"></i>'+ t('surveys.common.share')), [:share, @survey], class: 'light')}</b></div>"
  end

  def client_subtitle
    "<div class=\"subheader\">
        #{link_to(raw('<i class="icon-users-1"></i>' + t('clients.common.clients')), [:clients], class: 'light')} | 
        #{link_to(raw('<i class="icon-pencil-2"></i>'+ t('clients.common.edit')), [:edit, @client], class: 'light')}
    </div>"
  end

  def get_survey_nav_links(step)
    {
      report: link_to(t("surveys.navigation.report.prev"), share_survey_path(@survey), class: "btn btn-default btn-sm"),
      share: 
        link_to(t("surveys.navigation.share.prev"), builder_survey_path(@survey), class: "btn btn-default btn-sm") + " " +
        link_to(t("surveys.navigation.share.next"), report_survey_path(@survey), class: "btn btn-default btn-sm"),
      builder:
        link_to(t("surveys.navigation.builder.prev"), edit_survey_path(@survey), class: "btn btn-default btn-xs") + " " +
        link_to(t("surveys.navigation.builder.next"), share_survey_path(@survey), class: "btn btn-default btn-sm"),
      edit: link_to(t("surveys.navigation.edit.next"), builder_survey_path(@survey), class: "btn btn-default btn-sm")
    }[step].to_s
  end

end

