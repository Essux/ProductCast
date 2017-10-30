models_list = Dir["app/models/Prediction_Models/*"].map! {|x| x[29..-1]}
models_list.each {|m| require_relative "../../app/models/Prediction_Models/" + m}
if defined?(Rails::Server)
    models_list.map! {|m| m.chomp(".rb")}
    all_models = Model.all.map {|x| x[:class_name]}
    models_list = models_list-all_models
    models_list.each {|model|
      temp = Model.new(name: model.constantize.public_name, class_name: model)
      if model.constantize.parameters_list != nil
        model.constantize.parameters_list.each {|param|
          temp.parameters.build name: param
        }
      end
      temp.save
    }
    
    all_models = Model.all
    all_models.each { |model|
      model.class_name.constantize.local_id = model.id
    }
    
end