class TestPanel
  DATA = [
    {
      id: 'TP1',
      tests: ['CHO', 'VITD'],
      price: 1700
    },
    {
      id: 'TP2',
      tests: ['HBA1C', 'B12'],
      price: 2100
    },
    {
      id: 'TP3',
      tests: ['LFT', 'VITD', 'CHO'],
      price: 1800
    }
  ].freeze

  TEST_PANEL_LOOKUP = DATA.index_by { |d| d[:id] }.freeze

  def self.find(test_panel_id)
    test_panel_data = TEST_PANEL_LOOKUP[test_panel_id]

    return unless test_panel_data

    new(
      id: test_panel_data[:id],
      test_ids: test_panel_data[:tests],
      price: test_panel_data[:price],
    )
  end

  def initialize(id:, test_ids:, price:)
    @id = id
    @test_ids = test_ids
    @price = price
  end

  attr_reader :id, :test_ids, :tests, :price

  def tests
    @tests ||= test_ids.map { |test_id| Test.find(test_id) }
  end

  def sample_tube_types
    tests.map { |test| test.sample_tube_type }
  end

  def sample_volume_requirement
    tests.sum(&:sample_volume_requirement)
  end
end
