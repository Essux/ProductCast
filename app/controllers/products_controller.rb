require 'date'

class ProductsController < ApplicationController
    # Se llama al mostrar todos los productos
    def index
        @products = current_user.products
    end

    # Se llama al mostrar un producto en específico
    def show
        @product = current_user.products.find(params[:id])
        @plot_records = {}
        for record in @product.records
            @plot_records[record.date] = record.sales
        end
    end
end
