module DeviseHelper
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  def devise_error_messages!
    return "" if resource.errors.empty?

    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => I18n.t(resource.class.model_name.human.downcase))

    messages = ""
    resource.errors.each { |attr, msg| messages = messages << content_tag(:strong, I18n.t(attr)) << " " << msg << "<br />"}

    html = <<-HTML
    <div id="myModal" class="reveal-modal">
      <h4 class="subheader">#{sentence}</h2>
      <p>#{messages}</p>
      <a class="close-reveal-modal">&#215;</a>
    </div>
    HTML

    html.html_safe
  end
end