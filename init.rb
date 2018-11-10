require 'redmine'

RepositoriesController.class_eval do
  alias markdown_extra_viewer_orig_entry entry
  def entry
    markdown_extra_viewer_orig_entry
    if not performed? and @path =~ /\.(md|markdown)\z/
      formatter_name = Redmine::WikiFormatting.format_names.find {|name| name =~ /Markdown/i}
      @content = Redmine::WikiFormatting.formatter_for(formatter_name).new('テスト出力')
      render :template => "repositories/entry_markdown"
    end
  end
end

Redmine::Plugin.register :redmine_markdown_extra_viewer do
  name 'Redmine Markdown Extra Viewer plugin'
  author 'TOMITA Masahiro'
  description 'Redmine show Markdown Extra in repository'
  version '0.0.1'
  url 'http://github.com/tmtm/redmine_markdown_extra_viewer'
  author_url 'http://github.com/tmtm'
end


