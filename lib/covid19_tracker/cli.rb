class Covid19Tracker::CLI
  def call
    start
    menu_1
    goodbye
  end

  def start
    @scraper = Covid19Tracker::Scraper.new()
    @scraper.parse_all
    @scraper.parse_about
    puts "Welcome to the Covid-19 Tracker"
  end

  def menu_1_print
    puts "------------------------------------------"
    puts "Please select a  number: "
    puts ""
    puts "1) Global Info"
    puts "2) Info By Country "
    puts "3) About Covid 10"
    puts "4) Go Back"
    puts ""
    puts "------------------------------------------"
    return
  end

  def menu_2_print
    puts "------------------------------------------"
    puts ""
    puts "1) Dislay top 10 Countries by Total Cases"
    puts "2) Dislay top 10 Countries by Total Deaths"
    puts "3) Dislay top 10 Countries by Total New Cases"
    puts "4) Search by Country name"
    puts "5) Go Back"
    puts ""
    puts "------------------------------------------"
    return
  end

  def menu_3_print
    puts "-----------------------------------------"
    puts ""
    puts "1) Typical Symptoms"
    puts "2) Severity"
    puts "3) Pre-existing Conditions"
    puts "4) How long do symptoms last?"
    puts "5) Go Back"
    puts ""
    puts "-----------------------------------------"
    return

  end

  def menu_1
    menu_1_print
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        print_global
      when "2"
        menu_2
      when "3"
        print_about
      when "4"
        start
      end
    end
  end

  def menu_2
    menu_2_print
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        print_top10_total_cases
      when "2"
        print_top10_total_deaths
      when "3"
        print_top10_new_cases
      when "4"
        search_by_country
      when "5"
        menu_1_print
        return
      end
    end
  end




  def print_top10_total_cases
    puts "-----------------------------------------"
    puts ""
    puts "The following countries have the top 10 total cases:"
    puts ""
    sortedData = @scraper.country_data.sort_by {|obj| -obj.total_cases.to_i}
    (0..9).each do |i|
      puts "Name: #{sortedData[i].name} --> Total Cases: #{sortedData[i].total_cases}"
    end
    puts ""
    puts "-----------------------------------------"
    menu_2_print
    return
  end

  def print_top10_total_deaths
    puts "----------------------------------------"
    puts ""
    puts "The following countries have the top 10 total deaths:"
    puts ""
    sortedData = @scraper.country_data.sort_by {|obj| -obj.total_deaths.to_i}
    (0..9).each do |i|
      puts "Name: #{sortedData[i].name} --> Total Deaths: #{sortedData[i].total_deaths}"
    end
    puts ""
    puts "---------------------------------------"
    menu_2_print
    return
  end

  def print_top10_new_cases
    puts "---------------------------------------"
    puts ""
    puts "The following countries have the top 10 new cases:"
    puts ""
    sortedData = @scraper.country_data.sort_by {|obj| -obj.new_cases.to_i}
    (0..9).each do |i|
      puts "Name: #{sortedData[i].name} --> Total Top Cases: #{sortedData[i].new_cases}"
    end
    puts ""
    puts "---------------------------------------"
    menu_2_print
    return
  end

  def search_by_country
    puts "---------------------------------------"
    puts ""
    puts "Search by Country Name"
    puts "type 1) to go back"
    puts ""
    puts "---------------------------------------"
    input = gets.strip.downcase
    if input == "exit" || input =="1"
      menu_2_print
      return
    end
    counter = 0
    @scraper.country_data.each do |obj|
      if obj.name.strip.downcase == input
        counter += 1
        puts ""
        puts "----------- #{obj.name} -----------"
        puts ""
        puts "Number of Cases:          #{obj.total_cases}"
        puts "Number of Deaths:         #{obj.total_deaths}"
        puts "New Cases:                #{obj.new_cases}"
        puts "New Deaths:               #{obj.new_deaths}"
        puts "Active Cases:             #{obj.active_cases}"
        puts "Recovered Cases:          #{obj.total_recovered}"
        puts "Critical Cases:           #{obj.serious_critical}"
        puts "Total Cases Per Million:  #{obj.tot_cases_per_million}"
        puts ""
      end
    end
    if counter == 1
      menu_2_print
      return
    else
      puts "Please Check your Spelling"
      search_by_country
    end
  end


  def print_global
    puts ""
    puts"-------------Global --------------"
    puts ""
    puts "Total Number of Cases:    #{@scraper.total_cases}"
    puts "Total Number of Deaths:   #{@scraper.total_deaths}"
    puts "Total Active Cases:       #{@scraper.total_active_cases}"
    puts "Total Recovered Cases:    #{@scraper.total_recovered_cases}"
    puts "Total Critical Cases:     #{@scraper.total_critical_cases}"
    puts ""
    menu_1_print
    return
  end


  def print_about
    puts ""
    puts "----------#{@scraper.about_title} ---------------"
    puts ""
    puts "#{@scraper.about_content}"
    puts ""

    menu_1_print
    return
  end

  def goodbye
    puts "Please Wash your Hands."
  end

end
