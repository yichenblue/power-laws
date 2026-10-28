# Optional authoring step only. dist/ is ready to deploy without Ruby or Jekyll.
require 'yaml'
require 'date'
require 'erb'
require 'cgi'
require 'fileutils'
require 'kramdown'
require 'kramdown-parser-gfm'

root = File.expand_path(__dir__)
template = ERB.new(File.read(File.join(root, 'source/template.html.erb')))
%w[en zh].each do |language|
  raw = File.read(File.join(root, "source/#{language}.md"))
  _, front, body = raw.split(/^---\s*$\n?/, 3)
  raise "Missing front matter in #{language}" unless front && body
  meta = YAML.safe_load(front, permitted_classes: [Date, Time], aliases: false)
  raise 'Unexpected template dependency' if body.match?(/\{\{|\{%/)
  html = Kramdown::Document.new(body, input: 'GFM', hard_wrap: false,
    auto_ids: true, entity_output: :as_char, math_engine: 'mathjax',
    syntax_highlighter: nil).to_html
  zh = language == 'zh'
  lang = zh ? 'zh-CN' : 'en'
  guide = meta.fetch('reading_guide')
  title = CGI.escapeHTML(meta.fetch('title'))
  description = CGI.escapeHTML(meta.fetch('excerpt'))
  reading = zh ? "正文约 #{guide['main_minutes']} 分钟；可选推导约 #{guide['optional_minutes']} 分钟" :
    "#{guide['main_minutes']} min main article; #{guide['optional_minutes']} min optional details"
  toc_title = zh ? '本文目录' : 'On this page'
  overview = zh ? '概览' : 'Overview'
  skip_label = zh ? '跳到正文' : 'Skip to article'
  other_file = zh ? 'index.html' : 'zh.html'
  canonical = 'https://yichenblue.github.io/power-laws/' + (zh ? 'zh.html' : '')
  result = template.result(binding)
  name = zh ? 'zh.html' : 'index.html'
  File.write(File.join(root, 'dist', name), result)
  puts "Built dist/#{name}"
end
