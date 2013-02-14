require 'spec_helper'
describe LanguageDetector do
  describe "Test is_valid_character() method" do
    before do
      LanguageDetector::Detector.train
      @language_detector = LanguageDetector::Detector.new
    end

    it "Test detect spanish" do
     @language_detector.detect_language("spec/spanish.txt").should eql "es"
    end

    it "Test detect english" do
     @language_detector.detect_language("spec/english.txt").should eql "en"
    end
  end
end
