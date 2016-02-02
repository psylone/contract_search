class ContractSearch < OpenStruct

  def self.configure!
    configuration = ROM::Configuration.new(:csv, Application.config[:data_path], encoding: 'utf-8')
    configuration.use(:macros)

    configuration.relation(:contract_searches) do
    end

    configuration.mappers do
      define(:contract_searches) do
        register_as :entity
        model ContractSearch
      end
    end

    @container = ROM.container(configuration)
  end

  def self.all
    @container.relation(:contract_searches).as(:entity)
  end

  def self.prepared_data
    all.to_a.map { |c| [c.duration, c.sum] }
  end

  def duration
    start  = Time.parse(contract_date)
    finish = Time.parse("1.#{finish_date_by_contract}")
    finish - start
  end

  def sum
    contract_target_sum.gsub("'", '').to_f
  end

end
