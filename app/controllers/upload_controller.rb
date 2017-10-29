class UploadController < ApplicationController
    # Se llama cuando se termina de cargar un archivo
    def done
        file = params[:file].tempfile
        if Product.upload(file)
            flash[:success] = "Se ha subido el archivo exitosamente"
            redirect_to products_path
        else
            flash[:danger] = "Hubo un error con el archivo subido"
            redirect_to upload_file_path
        end
    end
end
