class ModelsController < ApplicationController
    def select
        @models = Model.all
    end
end
