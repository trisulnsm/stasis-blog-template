require  'nokogiri'

layout '/layouts/layout.html.haml'

# hack to get rid of the indentation due to HAML in textile code blocks 
class Tilt::HamlTemplate
  def prepare
    options = @options.merge(:filename => eval_file, :line => line)
    # Custom options
    options = options.merge :ugly => true
    @engine = ::Haml::Engine.new(data, options)
  end
end


ignore /layouts/

helpers do 
	def stylesheet_tag(*args)
		htmls = args.collect do |a|
			"<link rel=\"stylesheet\" href=\"/css/#{a}.css\" type=\"text/css\" media=\"screen\" />"
		end
		htmls.join("\n")
	end

    def javascript_tag(*args)
        jss = args.collect do |a|
            "<script src=\"/js/#{a}.js\"  type=\"text/javascript\"  ></script>"
        end
        jss.join("\n")
    end

	def trisul_logo
		%q(<img src="/images/trisul.png" alt="Trisul Network Traffic Analytics Logo" style="vertical-align:middle"/>)
	end

  def blog_logo
    %q( <a href="/"><img src="/images/bloglogo.png" alt="Trisul Network Traffic Analytics Logo" style="vertical-align:middle"/></a>)
  end

  def blog_logo_flip
    %q( <a href="/"><img src="/images/bloglogo-flip.png" alt="Trisul Network Traffic Analytics Logo" style="vertical-align:middle"/></a>)
  end


  

end

