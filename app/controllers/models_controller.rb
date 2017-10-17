class ModelsController < ApplicationController
    def select
        @models = Model.all
    end
    
    def select_params
        @params = params
    end
end
