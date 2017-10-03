class UploadController < ApplicationController
    def done
        file = params[:file].tempfile
        Product.upload(file)
    end
end
