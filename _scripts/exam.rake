require 'yaml'
require 'erb'

def exam
  Dir.glob("_exams/*") do |e|
    config = YAML.load_file(e)
    title = config["title"]
    footer = config["footer"]

    ques = []
    config["q"].each do |q|
      ques << File.read("_includes/q/" + q)
    end

    template = ERB.new(File.read("_templates/exam.md.erb")).result(binding)
    File.open("temp.md",w) { |f| f.puts template }
    sh "markdown2pdf temp.md -o sinav.md"
    rm "temp.md"
  end
end

task :exam do
  exam
end
