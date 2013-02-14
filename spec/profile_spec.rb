require 'spec_helper'
describe LanguageDetector::Profile do
  describe "Test is_valid_character() method" do
    before do
      @profile = LanguageDetector::Profile.new("test")
    end

    it "Test '.' is not a valid character" do
      @profile.is_valid_character?(?.).should be_false
    end

    it "Test ',' is not a valid character" do
      @profile.is_valid_character?(?,).should be_false
    end

    it "Test ':' is not a valid character" do
      @profile.is_valid_character?(?:).should be_false
    end

    it "Test ';' is not a valid character" do
      @profile.is_valid_character?(?;).should be_false
    end

    it "Test 'A' is not a valid character" do
      @profile.is_valid_character?(?A).should be_false
    end

    it "Test 'a' is a valid character" do
      @profile.is_valid_character?(?a).should be_true
    end
  end

  describe "Test tokenize() method" do
    before do
      @profile = LanguageDetector::Profile.new("test")
    end

    it "Test '.' is not a valid character" do
      @profile.tokenize("this is; ,+_  A \t 123 test:").should match_array(["this", "is", "a", "test"])
    end
  end

  describe "Test count_ngram() method" do
    before do
      @profile = LanguageDetector::Profile.new("test")
    end

    it "Test 1" do
      @profile.count_ngram('words', 1, {}).should include("w"=>1, "o"=>1, "r"=>1, "d"=>1, "s"=>1)
    end

    it "Test 2" do
      @profile.count_ngram('words', 2, {}).should include("wo"=>1, "or"=>1, "rd"=>1, "ds"=>1, "_w" => 1, "s_" => 1)
    end

    it "Test 3" do
      @profile.count_ngram('words', 3, {}).should include("wor"=>1, "ord"=>1, "rds"=>1, "_wo" => 1, "ds_" => 1, "s__" => 1)
    end

    it "Test 4" do
      @profile.count_ngram('words', 4, {}).should include("word"=>1, "ords"=>1, "_wor" => 1, "rds_" => 1, "ds__" => 1, "s___" => 1)
    end

    it "Test 5" do
      @profile.count_ngram('words', 5, {}).should include("words"=>1, "_word" => 1, "ords_" => 1, "rds__" => 1, "ds___" => 1, "s____" => 1)
    end

    it "Test 6" do
     @profile.count_ngram('words', 6, {}).should include()
    end
  end

  describe "Test init_with_string() method" do
    before do
      @profile = LanguageDetector::Profile.new("test")
    end

    it "Test 1" do
      @profile.init_with_string("this is; ,+_  A \t 123 test:")
      @profile.ngrams.should include("_t"=>1, "s_"=>2, "is"=>3, "_i"=>4, "th"=>5, "_th"=>6, "thi"=>7, "his"=>8, "is_"=>9, "s__"=>10, "_thi"=>11, "this"=>12, "his_"=>13, "is__"=>14, "s___"=>15, "hi"=>16, "te"=>17, "es"=>18, "st"=>19, "t_"=>20, "_te"=>21, "tes"=>22, "est"=>23, "st_"=>24, "t__"=>25, "_tes"=>26, "test"=>27, "est_"=>28, "st__"=>29, "t___"=>30)
    end
  end

  describe "Test compute_distance() method" do
    before do
      @profile1 = LanguageDetector::Profile.new("test")
      @profile1.init_with_string("this is ,+_ A \t 123 test")

      @profile2 = LanguageDetector::Profile.new("test")
      @profile2.init_with_string("this is ,+_ A \t 123 test")

      @profile3 = LanguageDetector::Profile.new("test")
      @profile3.init_with_string("xxxx")
    end

    it "Test 1" do
      @profile1.compute_distance(@profile2).should eql 0
   end

    it "Test 2" do
      @profile1.compute_distance(@profile3).should eql 24000
    end
  end
end
