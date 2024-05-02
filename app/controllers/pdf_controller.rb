class PdfController < ApplicationController
  def index
    @users = DummyUser.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'WickedPdfサンプル', formats: [:html], show_as_html: params.key?('debug')
      end
    end
  end
end
