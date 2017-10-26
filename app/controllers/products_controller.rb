require 'date'

class ProductsController < ApplicationController
    # Se llama al mostrar todos los productos
    def index
        @products = Product.all
    end

    # Se llama al mostrar un producto en específico
    def show
        @product = Product.find(params[:id])
    end
end
