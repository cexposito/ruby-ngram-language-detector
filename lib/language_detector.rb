require "language_detector/version"
require 'yaml'

module LanguageDetector

  class Detector
    def detect_language file_name
      @profiles ||= load_model

      file_words = File.read(file_name).downcase

      input_file_profile = LanguageDetector::Profile.new("")
      input_file_profile.init_with_string(file_words)

      best_profile_name = 'unknown'
      best_distance = nil

      @profiles.each {|profile|
        calculated_distance = profile.compute_distance(input_file_profile)

        if best_distance.nil? || calculated_distance < best_distance
          best_distance     = calculated_distance
          best_profile_name = profile.name
        end
      }

      return best_profile_name
    end

    def self.train
      training_data = [
        [ "en", "english.txt", "english" ],
        [ "es", "spanish.txt", "spanish" ]
      ]

      @profiles = []

      training_data.each {|data|
        profile = LanguageDetector::Profile.new data[0]
        profile.init_with_training_file data[1]
        @profiles << profile
      }

      filename = File.expand_path(File.join(File.dirname(__FILE__), "model.yml"))
      File.open(filename, 'w') {|f|
        YAML.dump(@profiles, f)
      }
    end

    def load_model
      filename = File.expand_path(File.join(File.dirname(__FILE__), "model.yml"))
      @profiles = YAML.load_file(filename)
    end
  end
end
