module FormsHelper
  def bootstrap_form(record, options = {}, &block)
    options.update(builder: BootstrapFormBuilder)

    options[:html] ||= {role: 'form'}
    options[:html][:class] ||= ''
    options[:html][:class] << ' form-horizontal'

    form_for(record, options, &block)
  end

  class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
    alias :super_text_field :text_field

    def error_messages
      unless object.errors.empty?
        content = <<HTML
<div class='panel panel-danger'>
  <div class='panel-heading'>#{I18n.t 'labels.fail'}</div>
  <ul class='list-group'>
    #{object.errors.map { |k, v| "<li class='list-group-item'>#{k.capitalize} #{v}</li>" }.join('')}
  </ul>
</div>
HTML
        content.html_safe
      end
    end

    def fieldset(&block)
      @template.content_tag(:fieldset, @template.capture(&block))
    end

    def select(name, choices, options={}, html_options = {})
      update_options_with_class! html_options, 'form-control'
      input_div(super(name, @template.options_for_select(choices, @object.send(name)), options, html_options), 3)
    end

    def group(options={}, &block)
      content = @template.capture(&block)
      update_options_with_class! options, 'form-group'
      @template.content_tag :div, content, options
    end

    def legend(content, options ={})
      @template.content_tag(:legend, content, options)
    end

    def button_group(&block)
      @template.content_tag(:div, @template.content_tag(:div, @template.capture(&block), class: 'col-sm-offset-2 col-sm-10', style: 'margin-top: 20px;'), class: 'form-group')
    end

    def submit(name, options ={})
      update_options_with_class!(options, 'btn btn-primary')
      super(name, options) << ' '
    end

    def reset(name, options={})
      options[:type] = :reset
      update_options_with_class!(options, 'btn btn-default')
      @template.button_tag(name, options) << ' '
    end

    def back(name, options={})
      update_options_with_class!(options, 'btn btn-info')
      @template.link_to(name, :back, options) << ' '
    end

    def cancel(name, options={})
      update_options_with_class!(options, 'btn btn-info')
      @template.link_to(name, :back, options) << ' '
    end

    def label(name, options={})

      case options[:mode]
        when 'checkbox'
          update_options_with_style! options, ' padding-left:20px;'
        when 'radio'
          update_options_with_class! options, 'radio-inline'
          update_options_with_style! options, 'padding-left:20px;padding-top:0px;'
        else
          update_options_with_class!(options, 'col-sm-2 control-label')
      end
      options.delete :mode
      super name, options
    end

    def radios(name, values, options={})

      update_options_with_style! options, 'margin-left:0px;'
      values.map { |v|
        @template.content_tag(:div,
                              radio_button(name, v, @object.send(name)==v ? options.merge(checked: true) : options)+
                                  label("#{name}_#{v}", mode:'radio'), class: 'radio-inline')
      }.join('').html_safe


    end

    def check_box_group(&block)
      @template.content_tag(:div, class: 'col-sm-offset-2 col-sm-10') do
        @template.content_tag(:div, @template.capture(&block), class: 'checkbox')
      end
    end

    def check_box(name, options={})
      update_options_with_style! options, 'margin-left:0;'
      super name, options
    end


    def text_field(name, options={})
      update_options_with_class! options, 'form-control'
      input_div(super(name, options), 9)
    end

    def name_field(name, options={})
      update_options_with_class! options, 'form-control'
      input_div(super_text_field(name, options), 4)
    end

    def text_area(name, options={})
      update_options_with_class! options, 'form-control'
      options[:rows] ||=12
      input_div(super(name, options))
    end

    def email_field(name, options={})
      update_options_with_class! options, 'form-control'
      input_div(super(name, options), 6)
    end

    def password_field(name, options={})
      update_options_with_class! options, 'form-control'
      input_div(super(name, options), 7)
    end

    def date_select(method, options = {})
      existing_date = @object.send(method)
      formatted_date = existing_date.to_date.strftime('%F') if existing_date.present?

      update_options_with_class! options, 'form-control'
      options['data-date-format'] = 'YYYY-MM-DD'
      options['data-date-language'] = I18n.locale
      options['value']=formatted_date

      @template.content_tag(:div, class: 'col-sm-2') do
        @template.content_tag(:div, class: 'input-group date datetimepicker') do
          super_text_field(method, options) +
              @template.content_tag(:span, @template.content_tag(:span, '', class: 'glyphicon glyphicon-calendar'), class: 'input-group-addon')
        end
      end
    end

    def datetime_select(method, options = {})
      existing_time = @object.send(method)
      formatted_time = existing_time.to_time.strftime('%F %I:%M %p') if existing_time.present?

      update_options_with_class! options, 'form-control'
      options['data-date-language'] = I18n.locale
      options['data-date-format'] = 'YYYY-MM-DD hh:mm A'
      options['value'] = formatted_time

      @template.content_tag(:div, class: 'col-sm-3') do
        @template.content_tag(:div, class: 'input-group date datetimepicker') do
          super_text_field(method, options) +
              @template.content_tag(:span, @template.content_tag(:span, '', class: 'glyphicon glyphicon-calendar'), class: 'input-group-addon')
        end
      end
    end

    # def date_picker(name, options={})
    #   update_options_with_class! options, 'form-control'
    #   options['data-provide']='datepicker'
    #   options['data-date-format'] = 'yyyy-mm-dd'
    #   options['data-date-language'] = I18n.locale
    #   options['data-date-autoclose'] = true
    #   options['data-date-today-btn'] = true
    #
    #   c1 = super_text_field(name, options)
    #   c2 = "<span class='input-group-addon'><i class='glyphicon glyphicon-th'></i></span>"
    #   @template.content_tag(:div, @template.content_tag(:div, c1+c2.html_safe, class: 'input-group date'), class: 'col-sm-4')
    # end


    private
    def input_div(content, size=10)
      @template.content_tag :div, content, class: "col-sm-#{size}"
    end

    def update_options_with_class!(options, klass)
      options[:class] ||= ''
      options[:class] << " #{klass}"
      options
    end

    def update_options_with_style!(options, style)
      options[:style] ||= ''
      options[:style] << " #{style}"
      options
    end

  end


end
