# 独立研究文章页面

这是独立的静态网站，不依赖原 homepage、Jekyll、博客主题或在线 CDN。
英文入口为 dist/index.html，中文入口为 dist/zh.html。
正文、数学公式和配图来自 SOURCE.json 记录的版本；只修改资源路径和页面外壳。

## 直接预览与部署

dist 文件夹已经生成，可以用任意静态 HTTP 服务预览，也可以整体上传到
GitHub Pages、Netlify、Cloudflare Pages 等静态托管服务。无需构建命令或 Ruby。
所有资源使用相对地址，支持部署到域名根目录或子目录。

例如使用 Node.js 环境：

    npx serve dist

打开终端给出的本地地址。也可以直接打开 dist/index.html；
正式预览推荐 HTTP，以保证字体、剪贴板和浏览器安全策略的一致性。

## GitHub Pages

- 英文：https://yichenblue.github.io/power-laws/
- 中文：https://yichenblue.github.io/power-laws/zh.html
- 独立仓库：https://github.com/yichenblue/power-laws

推送到 main 后，GitHub Actions 将 dist 文件夹部署到 GitHub Pages；也可以手动运行
Deploy standalone article 工作流。页面已设置独立地址的 canonical 与 og:url。
正文修改后须先运行下方构建命令，并一并提交更新后的 HTML。
原 homepage 和旧博客的入口、内容及重定向均不改变。

## 编辑

- 英文正文：source/en.md
- 中文正文：source/zh.md
- 页面结构：source/template.html.erb
- 独立页面基础样式：dist/assets/css/standalone.css
- 文章配图：dist/assets/images/
- 目录、论文链接预览、系统主题适配：dist/assets/js/

正文保留了原 Markdown 的 front matter，未使用的博客字段不会参与构建。
资源路径已转换为本地相对路径。不要改变公式原有分隔符。
正文修改后，运行可选的轻量构建：

    bundle install
    bundle exec ruby build.rb

该构建只生成两份 HTML，不需要原网站、Liquid 或 Jekyll。页面样式和资源直接保存在 dist 中。

## 保留功能

中英文切换、响应式目录与当前章节提示、折叠推导、数学公式、
论文链接悬停与复制、随系统自动切换的深浅主题、原始 GIF 与减少动画偏好下的静态替代图。
页面不提供手动主题按钮，也不会读取之前保存的手动主题偏好。
字体和 MathJax 3.2.2 已随页面打包；论文引用和代码仓库依然是正常的外部链接。

## 来源与许可

原文及图注中的论文归属与 CC BY 链接完整保留，不代表所有内容采用同一许可。
字体许可见 dist/assets/fonts/research/ 下的 OFL 文件。
MathJax 来自官方 npm mathjax 3.2.2 包，许可证见 dist/assets/vendor/mathjax/LICENSE。
