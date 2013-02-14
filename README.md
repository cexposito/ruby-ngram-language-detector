# LanguageDetector

    This is a n-gram based language detector (written in ruby) which is based on http://tnlessone.wordpress.com/2007/05/13/how-to-detect-which-language-a-text-is-written-in-or-when-science-meets-human/ and https://github.com/feedbackmine/language_detector

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_ngrams_language_detector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_ngrams_language_detector

## Usage

    require 'language_detector'
    detector = LanguageDetector.new
    detector.detect(file.txt)

## Contributing

    1. Fork it
    2. Create your feature branch (`git checkout -b my-new-feature`)
    3. Commit your changes (`git commit -am 'Add some feature'`)
    4. Push to the branch (`git push origin my-new-feature`)
    5. Create new Pull Request
