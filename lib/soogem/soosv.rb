# This is a custom replacement for a CSV parser
class SooSV
  # In theory, this file should be able to handle CSV, TSV and other types of files.
  #
  # Example
  #  ....

  attr_accessor :new_line_char, :delimiter, :header, :body

  def initialize(file_name)
    @file_name = file_name
    @last_header_line = 1
    @new_line_char = "\n"
    @delimiter = ","
    self
  end

  def get_lines
    file = File.open(@file_name)
    header, body = [], []
    i=1

    file.each_line(@new_line_char).each do |line|
      if i <= @last_header_line
        header << line
      else
        body << line
      end
      i=i+1
    end
    @header = header.to_s
    @body = body
    [header, body]
  end

  # Takes in a line and splits it on the delimiter
  # and turns it into an array
  def line_to_array(line)
    attributes = []
    last_split_index = 0
    inside_quote = false
    line.chars.each_with_index do |char, index|
      
      inside_quote = !inside_quote if quote_toggles?(line, index)
      next unless char == @delimiter && !inside_quote
      next if line[index-1]=="\\"

      attributes << line[last_split_index..index-1]
      last_split_index = index+1
    end
    attributes << line[last_split_index..-1]
    attributes
  end

  private #----------------

  # If a valid quote was found, ie one that is not escaped and thus changes the value of
  # whether we are inside a quoted section of text, return true, false otherwise
  def quote_toggles?(line, index)
    return false unless line[index].chr == '"'
    (line[index-1].chr == /\\/) ? false : true
  end

end
