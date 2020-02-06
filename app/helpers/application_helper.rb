module ApplicationHelper
  def javascript_pack_exists?(script)
    script = "#{Rails.root}/app/javascript/packs/#{params[:controller]}.js"
    File.exists?(script) || File.exists?("#{script}.coffee") 
  end

  def stylesheet_exists?(stylesheet)
    stylesheet = "#{Rails.root}/app/assets/stylesheets/#{params[:controller]}.css"
    File.exists?(stylesheet) || File.exists?("#{stylesheet}.scss") 
  end
end
