class ForecastSetsController < ApplicationController
  def to_param
    id
  end
  
  def index
    @forecast_set = current_user.forecast_sets.all
  end
  
  def select_models
    @forecast_set = current_user.forecast_sets.new
  end

  def select_params
    @forecast_set = current_user.forecast_sets.new(forecast_set_models)
    @applied_parameters = AppliedParameter.new
  end

  def show
    @forecast_set = current_user.forecast_sets.find(params[:id])
  end
  
  # Este método es todo ProductCast
  def create
    @forecast_set = current_user.forecast_sets.new(forecast_set_params)
    @forecast_set.save
    params[:model_ids]
    params[:model_ids].drop(1).each { |model|
      model = Model.find(model)
      execution = Execution.find_by(model_id: model.id, forecast_set_id: @forecast_set.id)
      # Parámetros de la instancia de Modelo que se va a ejecutar
      model_params = {}
      model.parameters.each { |parameter|
        model_params[:"#{parameter.class_name}"] = params[:forecast_set][:applied_parameters][:"#{parameter.id}"].to_f
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
      # Depende si seleccionó el checkbox de todos los datos para usar pasar un número de parámetros
      if params[:all].nil?
        historical_data = Product.get_historical_data(@forecast_set.product_id, params[:num_of_records])
      else
        historical_data = Product.get_historical_data(@forecast_set.product_id)
      end
      # Ejecuta el modelo
      predicted_data = model_instance.run(historical_data, @forecast_set.forecast_amount)
      # Guarda las predicciones en la base de datos
      Forecast.savePredictedData(predicted_data, execution)
    }
    redirect_to result_path id: @forecast_set.id
  end
  
  # Método usado en la vista para organizar los datos para graficarlos
  def plotData execution
    # Se crea un hash fecha => ventas
    data = {}
    for forecast in execution.forecasts
      data[forecast.date] = forecast.sales
    end
    data
  end

  helper_method :plotData
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
