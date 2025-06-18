class Api::InvoiceController < Api::ApiController 
  def index
    unless params[:start_date].present? && params[:end_date].present?
      return render json: { error: 'start_date y end_date son requeridos' }, status: :bad_request
    end
    begin
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
    rescue ArgumentError
      return render json: { error: 'Formato de fecha inválido para start_date o end_date' }, status: :bad_request
    end

    page = params[:page] || 1
    page_size = params[:page_size] || 10
    invoices = Invoice.where(invoice_date: start_date.beginning_of_day..end_date.end_of_day)
                        .page(page)
                        .per(page_size)
    render json: {
      data: invoices,
      page: invoices.current_page,
      total_pages: invoices.total_pages
    }
  end
end
