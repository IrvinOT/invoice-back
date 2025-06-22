namespace :reports do
  desc "Ejecuta el job TopSalesDaysReportJob manualmente"
  task top_sales_days: :environment do
    TopSalesDaysReportJob.perform_now
    puts "TopSalesDaysReportJob ejecutado"
  end
end
