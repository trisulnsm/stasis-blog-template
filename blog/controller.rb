before /postindex.html.haml|index.html.haml/  do
  layout '/layouts/blog/frontpage.html.haml'
end

before /post.html.textile/  do
  layout '/layouts/blog/post.html.haml'

  @posted_date =  File.mtime(@_stasis.path).asctime 
  @posted_user =  Etc.getpwuid(File.stat(@_stasis.path).uid).name
    
end


helpers do 

  # latest posts on blog home page 
  def latest_posts


    # decorated output DOM
    frontpage_dom =Nokogiri::HTML::DocumentFragment.parse ""

    Dir.glob('*/post.html.textile')
       .sort { |a,b| File.mtime(b) <=> File.mtime(a) }
       .each do |pdir|
          add_post_to_frontpage(frontpage_dom, File.dirname(pdir)) 
    end


    frontpage_dom.inner_html

  end

  # adjust any img or href tags that point to images/ or lib/ 
  # idea is you should be able to use relative path for images in your posts 
  def add_post_to_frontpage(fp_dom, pdir)

    dom = Nokogiri::HTML(Tilt.new(pdir + "/post.html.textile").render)

    # relative image paths
    dom.xpath('//img').each do |n|
      if n['src'].start_with? 'images/'
        n['src'] = pdir + '/' + n['src']
      end
    end

    # wrap heading with link 
    tlink = pdir+"/post.html"
    dom.xpath('//h1').slice(0..1).wrap("<a href=\"#{tlink}\"></a>")

    # add posted date 
    owner = Etc.getpwuid(File.stat(pdir).uid).name
    posted_details = Nokogiri::XML::Builder.new do |n|
        n.p(:class=>'muted') {
          n.text "Posted : " + File.mtime(pdir + "/post.html.textile").asctime 
          n.text "  by  " + owner 
        }
    end
    dom.at('//a/h1').parent.add_next_sibling(posted_details.doc.inner_html)


    # add hr at end

    dom.xpath('//body').first.name = "section"

    fp_dom.add_child( dom.xpath('//section').first)
    fp_dom.add_child( "<hr/>")
    
  end


  def post_index

    Nokogiri::XML::Builder.new do |n|

      n.table( :class => 'table table-striped' ) {

        n.thead {
          n.tr {
            n.th "Date published"
            n.th "Title"
          }
        }
        Dir.glob('*/post.html.textile')
           .sort { |a,b| File.mtime(b) <=> File.mtime(a) }
           .each do |fpost|
              dom = Nokogiri::HTML(Tilt.new(fpost).render)

              n.tr {
                n.td { n.text File.mtime(fpost).asctime}
                n.td {
                  n.a(:href => File.dirname(fpost) + "/post.html") {
                    n.text dom.at_css('h1').text
                  }
                }
              }
              
        end
      }

    end.doc.inner_html


  end


  def post_list

    # max 5
    max = 5

    Nokogiri::XML::Builder.new do |n|

      n.ul( :class => 'unstyled' ) {
        Dir.glob('*/post.html.textile')
            .sort { |a,b| File.mtime(b) <=> File.mtime(a) }
            .each do |fpost|
              dom = Nokogiri::HTML(Tilt.new(fpost).render)

              n.li {
                n.a(:href => File.dirname(fpost) + "/post.html") {
                  n.text dom.at_css('h1').text
                }
              }
        end
      }
    end.doc.inner_html

  end



end
