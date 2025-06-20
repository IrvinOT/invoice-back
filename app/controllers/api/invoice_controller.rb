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
    cache_key = "invoices/#{start_date}/#{end_date}"
    invoice_ids = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      Invoice.where(invoice_date: start_date.beginning_of_day..end_date.end_of_day)
             .pluck(:id)
    end

    invoices = Invoice.where(id: invoice_ids)
              .page(page)
              .per(page_size)

    render json: {
      data: invoices,
      page: invoices.current_page,
      records: invoices.total_count,
      total_pages: invoices.total_pages
    }
  end
end
