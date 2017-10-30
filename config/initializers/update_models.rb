models_list = Dir["app/models/Prediction_Models/*"].map! {|x| x[29..-1]}
models_list.each {|m| require_relative "../../app/models/Prediction_Models/" + m}
if defined?(Rails::Server)
    models_list.map! {|m| m.chomp(".rb")}
    all_models = Model.all.map {|x| x[:class_name]}
    models_list = models_list-all_models
    models_list.each {|model|
      temp = Model.new(name: model.constantize.public_name, class_name: model)
      parameters = model.constantize.parameters_list
      local_parameters = model.constantize.local_parameters
      if parameters != nil
        parameters.size.times {|i|
          temp.parameters.build name: parameters[i], class_name: local_parameters[i]
        }
      end
      temp.save
    }
    
    all_models = Model.all
    all_models.each { |model|
      model.class_name.constantize.local_id = model.id
    }
    
end