class TopSalesDaysReportJob < ApplicationJob
  queue_as :default
  require 'mailtrap'

  def perform(*args)

    report = Invoice.select("DATE(invoice_date) as day, SUM(total) as total_day")
      .where("EXTRACT(HOUR FROM invoice_date) >= 6 AND EXTRACT(HOUR FROM invoice_date) < 12")
      .group("day")
      .order("total_day DESC")
      .limit(10)

    table_body = report.each_with_index { |invoice_day, index| row_table(index, invoice_day) }.join
    mail = mailtrap_template(table_body)
    client = client_email 
    client.send(mail)
  end

  def row_table(index, invoice_day)
    "<tr>
      <td>#{index + 1}</td>
      <td>#{invoice_day['day']}</td>
      <td>$#{invoice_day['total_day'].to_f}</td>
    </tr>"
  end

  def mailtrap_template(table_body)
    Mailtrap::Mail::FromTemplate.new(
      from:
      {
        email: "invoices@example.com",
        name: "Invoices",
      },
      to: [
        {
          email: "irvintrejoc@gmail.com",
        }
      ],
      template_uuid: "1f481856-9cd5-4344-be01-906b91a7a307",
      template_variables: {"table_body" => table_body}
      )
  end 

  def client_email
    Mailtrap::Client.new(
      api_key: ENV['MAILTRAP_TOKEN'],
      sandbox: true,
      inbox_id: 3833109,
      )
  end
end
