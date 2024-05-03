class PdfController < ApplicationController
  def wicked_pdf
    @users = DummyUser.all
    render pdf: 'WickedPdfサンプル', template: 'pdf/index', layout: 'pdf'
  end

  def ferrum
    @users = DummyUser.all
    pdf = generate_pdf(template: 'pdf/index')
    send_data pdf, filename: "Ferrumサンプル.pdf", type: "application/pdf", disposition: "inline"
  end

  private

  def generate_pdf(layout: 'pdf', template: nil, **pdf_options)
    # viewファイルをHTMLに変換
    html_content = render_to_string(layout:, template:, formats: :html)
    # HTMLをPDFに変換
    html_to_pdf(html_content, **pdf_options)
  end

  def html_to_pdf(html_content, format: :A4, encoding: :binary, scale: 1.0, print_background: true)
    browser = Ferrum::Browser.new(browser_options: { "no-sandbox": nil }, js_errors: true)
    page = browser.create_page

    # HTMLからdataURLを生成して開く
    page.content = html_content

    # メディアタイプをscreenに設定
    page.command("Emulation.setEmulatedMedia", media: "screen")

    # PDFを生成
    page.pdf(
      format:,
      encoding:,
      scale: scale * 0.8,
      print_background:,
    )
  ensure
    browser&.quit
  end
end
