class UploadController < ApplicationController
    # Se llama cuando se termina de cargar un archivo
    def done
        file = params[:file].tempfile
        Product.upload(file)
    end
end
