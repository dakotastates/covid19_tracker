class Covid19Tracker::Scraper
  attr_accessor :country_data, :total_cases, :total_deaths, :total_active_cases, :total_recovered_cases, :total_critical_cases, :about_title, :about_content
  def initialize
    @country_data = []
    @total_cases = 0
    @total_deaths = 0
    @total_active_cases = 0
    @total_recovered_cases = 0
    @total_critical_cases = 0
  end
  #collects all data
  def get_data
     Nokogiri::HTML(open("https://www.worldometers.info/coronavirus/"))
  end

  def get_about_data
    Nokogiri::HTML(open("https://www.cdc.gov/coronavirus/2019-nCoV/summary.html"))
  end

  def parse_about
    parse_about = self.get_about_data
    @about_title = parse_about.search("h2")[0].text
    @about_content = parse_about.search("p")[2..3].text
  end



  def parse_all
    all_data = self.get_data
    @total_cases = all_data.xpath("//div[@class='maincounter-number']/span")[0].text()
    @total_deaths = all_data.xpath("//div[@class='maincounter-number']/span")[1].text()
    @total_active_cases = all_data.xpath("//div[@class='panel_front']/div[@class='number-table-main']")[0].text()
    @total_recovered_cases = all_data.xpath("//div[@class='maincounter-number']/span")[2].text()
    @total_critical_cases = all_data.xpath("//div[@class='panel_front']//span[@class='number-table']")[1].text()
    self.get_all_countries(all_data)
  end

  #Takes the Table data and seperarates it by country and stores it in rows array
  def get_all_countries(data)
      country = []
      counter = 0
      data.xpath("//tbody")[0].xpath("//tr/td").each do |x|
        t = x.text().strip
        #puts "parsing data #{t}. Counter: #{counter}"
        if t.start_with?("<td ")
          country << ""
        else
          t = 0 if t.nil? || t.empty? || t=='.'
          if t != 0
            t = t.tr('+', '')
            t = t.tr(',', '')
          end
          country << t
        end
        if counter == 8
          counter = 0
          #puts "adding country #{country[0]}"
          if country[0] != 'Total:'
            self.country_data << Covid19Tracker::Country.new(country)
          end
          country=[]
        else
          counter += 1
        end
      end
    end
end
