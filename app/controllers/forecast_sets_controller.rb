class ForecastSetsController < ApplicationController
  def to_param
    id
  end

  def select_models
    @forecast_set = ForecastSet.new
  end

  def select_params
    @forecast_set = ForecastSet.new(forecast_set_models)
    @applied_parameters = AppliedParameter.new
  end

  # Este método es todo ProductCast
  def show
    @forecast_set = ForecastSet.new(forecast_set_params)
    @forecast_set.save
    params[:model_ids]
    params[:model_ids].drop(1).each { |model|
      model = Model.find(model)
      execution = Execution.find_by(model_id: model.id, forecast_set_id: @forecast_set.id)
      # Parámetros de la instancia de Modelo que se va a ejecutar
      model_params = {}
      model.parameters.each { |parameter|
        model_params[parameter.name] = params[:forecast_set][:applied_parameters][:"#{parameter.id}"]
        unless execution == nil
          applied_parameter = AppliedParameter.new(parameter_id: parameter.id, execution_id: execution.id, value: params[:forecast_set][:applied_parameters][:"#{parameter.id}"])
          applied_parameter.save
        end
      }
      # Nombre de la subclase de Modelo que se va a usar
      model_class_name = model.class_name
      # Crea una instancia de la clase de Modelo según su nombre
      model_instance = model_class_name.constantize.new(model_params)
      # Trae los datos para hacer predicciones
      historical_data = Product.get_historical_data(@forecast_set.product_id)
      # Ejecuta el modelo
      predicted_data = model_instance.run(historical_data, @forecast_set.forecast_amount)
      # Guarda las predicciones en la base de datos
      Forecast.savePredictedData(predicted_data, execution)
    }
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
