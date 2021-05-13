class Test
  DATA = [
    {
      id: 'CHO',
      name: 'Cholesterol',
      sample_volume_requirement: 100,
      sample_tube_type: :yellow
    },
    {
      id: 'LFT',
      name: 'Liver function',
      sample_volume_requirement: 60,
      sample_tube_type: :yellow
    },
    {
      id: 'VITD',
      name: 'Vitamin D',
      sample_volume_requirement: 120,
      sample_tube_type: :yellow
    },
    {
      id: 'B12',
      name: 'Vitamin B12',
      sample_volume_requirement: 180,
      sample_tube_type: :yellow
    },
    {
      id: 'HBA1C',
      name: 'HbA1C',
      sample_volume_requirement: 40,
      sample_tube_type: :purple
    },
    {
      id: 'FBC',
      name: 'Full blood count',
      sample_volume_requirement: 80,
      sample_tube_type: :purple
    }
  ].freeze

  TEST_LOOKUP = DATA.index_by { |d| d[:id] }.freeze

  def self.find(test_id)
    test_data = TEST_LOOKUP[test_id]

    return unless test_data.present?

    new(**test_data)
  end

  def initialize(id:, name:, sample_volume_requirement:, sample_tube_type:)
    @id = id
    @name = name
    @sample_volume_requirement = sample_volume_requirement
    @sample_tube_type = sample_tube_type
  end

  attr_reader :id, :name, :sample_volume_requirement, :sample_tube_type
end
