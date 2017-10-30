class ForecastSetsController < ApplicationController
  def to_param
    id
  end
  
  def index
    @forecast_set = ForecastSet.all
  end
  
  def select_models
    @forecast_set = ForecastSet.new
  end

  def select_params
    @forecast_set = ForecastSet.new(forecast_set_models)
    @applied_parameters = AppliedParameter.new
  end
  
  def show
    @forecast_set = ForecastSet.find(params[:id])
  end
  
  def create
    @forecast_set = ForecastSet.new(forecast_set_params)
    @forecast_set.save
    params[:model_ids]
    params[:model_ids].drop(1).each { |model|
      model = Model.find(model)
      model.parameters.each { |parameter|
        execution = Execution.find_by(model_id: model.id, forecast_set_id: @forecast_set.id)
        unless execution == nil
          applied_parameter = AppliedParameter.new(parameter_id: parameter.id, execution_id: execution.id, value: params[:forecast_set][:applied_parameters][:"#{parameter.id}"])
          applied_parameter.save
        end
      }
    }
    redirect_to result_path id: @forecast_set.id
  end

private

    def forecast_set_models
      params.require(:forecast_set).permit(:model_ids => [])
    end
    
    def forecast_set_params
      params.require(:forecast_set).permit(:forecast_amount).tap { |x|
        x[:product_id] = params[:product_id]
        x[:model_ids] = params[:model_ids]
      }
    end
end
