class TrackingSignal < ApplicationRecord
  belongs_to :execution

 def self.saveTrackingSignal(tracking_signal, execution)
    signal = tracking_signal[:signals]
    dates = tracking_signal[:dates]

    signal.zip(dates).each do |signal_dates|
      #Crear un TrackingSignal asociado a execution
      curr_ts = execution.tracking_signals.build
      curr_ts.signal = signal_dates[0]
      curr_ts.date = signal_dates[1]
      curr_ts.save
    end
  end
end
