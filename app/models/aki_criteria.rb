class AkiCriteria
  attr_accessor :creatinine_test_pair

  def initialize(a_creatinine_test_pair)
    self.creatinine_test_pair = a_creatinine_test_pair
  end

  def diagnosis
    return nil
  end
end