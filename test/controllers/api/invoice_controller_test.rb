require 'test_helper'

class Api::InvoiceControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice1 = Invoice.create!(invoice_number: 'A001', total: 100.50, invoice_date: '2025-06-01 07:00', status: 'Vigente')
    @invoice2 = Invoice.create!(invoice_number: 'A002', total: 200.75, invoice_date: '2025-06-01 11:00', status: 'Cancelado')
    @invoice3 = Invoice.create!(invoice_number: 'A003', total: 300.00, invoice_date: '2025-06-02 15:00', status: 'Vigente')
  end

  test 'should get index with valid dates' do
    get api_invoice_url, params: { start_date: '2025-06-01', end_date: '2025-06-01' }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 2, json['data'].length
    assert_equal 1, json['page']
    assert_equal 1, json['total_pages']
  end

  test 'should return error if dates missing' do
    get api_invoice_url
    assert_response :bad_request
    json = JSON.parse(response.body)
    assert_match /requeridos/, json['error']
  end

  test 'should return error if date format invalid' do
    get api_invoice_url, params: { start_date: 'invalid', end_date: '2025-06-01' }
    assert_response :bad_request
    json = JSON.parse(response.body)
    assert_match /inválido/, json['error']
  end
end
