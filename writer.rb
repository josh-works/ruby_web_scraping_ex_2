require './paragraph_parser'

class Writer
  def self.save_to_file
    contents = ParagraphParser.new.paragraphs
    File.open("sentances.txt", "w+") do |f|
      f.write(contents.join("\n"))
    end
  end
end

Writer.save_to_file