class Covid19Tracker::Country
  attr_accessor :name, :total_cases, :total_deaths, :new_cases, :new_deaths, :active_cases, :total_recovered, :serious_critical, :tot_cases_per_million

  def initialize(country)
    self.name = country[0]
    self.total_cases = country[1]
    self.new_cases = country[2]
    self.total_deaths = country[3]
    self.new_deaths = country[4]
    self.total_recovered = country[5]
    self.active_cases = country[6]
    self.serious_critical = country[7]
    self.tot_cases_per_million = country[8]
  end
end
