require 'csv'

class Product < ApplicationRecord
    has_many :records
    validates :name, presence: true, length: {in: 4..100}

    # Recibe un archivo .csv e inserta sus datos en la base de datos
    # Solo inserta los registros que no están repetidos
    def self.upload(file)
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
                    product = Product.find_by(name: product_names[i])

                    # Si no creo uno nuevo
                    if product.nil?
                        product = Product.create(name: product_names[i])
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
    end
end
