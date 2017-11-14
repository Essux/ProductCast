require 'csv'
require_relative './Data/historical_data'
require_relative './Periods/monthly'

class Product < ApplicationRecord
    has_many :records
    has_many :forecast_sets
    validates :name, presence: true, length: {in: 3..100}

    # Recibe un archivo .csv e inserta sus datos en la base de datos
    # Solo inserta los registros que no están repetidos
    def self.upload(current_user, file)
        result = true
        begin
            csv_file = CSV.new(file, headers: true, col_sep: ";")
            is_first = true
            products = []
            csv_file.each do |row|
                # Procesar productos usando el header
                if is_first
                    is_first = false
                    # Recorrer el header que tiene los nombres de los productos
                    product_names = csv_file.headers
                    for i in 1..(product_names.length - 1)
                        # Busco si ya hay un producto con ese nombre
                        product =  current_user.products.find_by(name: product_names[i])

                        # Si no creo uno nuevo
                        if product.nil?
                            product =  current_user.products.create(name: product_names[i])
                        end

                        # Agrego a la lista de productos
                        products.push(product)
                    end
                end

                # Insertar registros
                record_date =  Date.parse(row[0])
                for i in 0..(products.length-1)
                    products[i].records.create(date: record_date, sales: row[i+1].to_i)
                end
            end
        rescue => e
            puts e.to_s
            result = false
        end
        result
    end

    # Recibe el id de un producto y devuelve una instancia de Historical_Data
    # con los registros entre las fechas dadas o todos los registros si no
    # se especifican los limites
    def self.get_historical_data (product_id, num_of_records=nil)
        product =  Product.find(product_id)
        puts "Cantidad de registros"
        puts num_of_records
        if num_of_records.nil?
            records = Record.where("product_id = ?", product_id).order("date ASC")
        else
            records = Record.where("product_id = ?", product_id).order("date ASC").take(num_of_records)
        end

        # En este momento se pasa fijo un periodo de un mes porque no hemos
        # definido como manejar los periodos
        historical_data = Historical_data.new(product_id, Monthly.new)

        # Extraer las ventas y las fechas de cada registro
        sales = []
        dates = []
        records.each do |record|
            sales.push record.sales
            dates.push record.date
        end

        historical_data.load_records(sales, dates)
        historical_data
    end
end
