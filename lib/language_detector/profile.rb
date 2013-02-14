class LanguageDetector::Profile

  IGNORE_CHARACTERS = [?., ?\,, ?:, ?;, ?\w, ?\n]
  LIMIT = 2000

  def compute_distance profile
    distance = 0
    profile.ngrams.each {|k, v|
      n = @ngrams[k]
      if n
        distance += (v - n).abs
      else
        distance += LanguageDetector::Profile::LIMIT
      end
    }
    return distance
  end

  attr_reader :ngrams, :name

  def initialize(name)
    @name = name
    @ignore_characters = {}
    IGNORE_CHARACTERS.each {|p| @ignore_characters[p] = 1}
    @ngrams = {}
  end

  def tokenize line
    tokens = []
    new_token = ''

    line.downcase.each_char {|c|
      if is_valid_character?(c)
        new_token << c
      else
        append_next_token(tokens, new_token)
        new_token = ''
      end
    }

    append_next_token(tokens, new_token)
    return tokens
  end

  def append_next_token(tokens, new_token)
    if !new_token.empty?
      tokens << new_token
    end
  end

  def is_valid_character? char
    char.match(/[^a-z]/).nil?
  end

  def init_with_training_file filename
    ngram_count = {}

    path = File.expand_path(File.join(File.dirname(__FILE__), "training_data/" + filename))

    File.open(path).each_line{ |line|
      _init_with_string line, ngram_count
    }

    a = ngram_count.sort {|a,b| b[1] <=> a[1]}

    i = 1
    a.each {|t|
      @ngrams[t[0]] = i
      i += 1
      break if i > LIMIT
    }
  end

  def init_with_string str
    ngram_count = {}

    _init_with_string str, ngram_count

    a = ngram_count.sort {|a,b| b[1] <=> a[1]}
    i = 1
    a.each {|t|
      @ngrams[t[0]] = i
      i += 1
      break if i > LIMIT
    }
  end

  def _init_with_string str, ngram_count
    tokens = tokenize(str)
    tokens.each {|token|
      count_ngram token, 2, ngram_count
      count_ngram token, 3, ngram_count
      count_ngram token, 4, ngram_count
      count_ngram token, 5, ngram_count
    }
  end

  def count_ngram token, n, counts
    if n > 1 && token.length >= n
      token = "_#{token}#{'_' * (n-1)}"
    end

    i = 0
    while i + n <= token.length

      s = ''
      j = 0

      while j < n
        s << token[i+j]
        j += 1
      end

      if counts[s]
        counts[s] = counts[s] + 1
      else
        counts[s] = 1
      end
      i += 1
    end
    return counts
  end
end
