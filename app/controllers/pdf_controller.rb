class PdfController < ApplicationController
  def wicked_pdf
    @users = DummyUser.all
    render pdf: 'WickedPdfサンプル', template: 'pdf/index', layout: 'pdf'
  end

  def ferrum
    # TODO: generate PDF with Ferrum
  end
end
