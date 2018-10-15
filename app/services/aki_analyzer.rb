class AkiAnalyzer
  attr_accessor :test, 
  :test_pairs_7days, 
  :patient

  def initialize(test)
    @test = test
    @patient = test.patient
    @test_pairs_7days = []

    can_trigger_aki_7days = patient.creatinine_tests.in_neighborhood(test, 7.days)

    can_trigger_aki_7days.each do |a_test|
      @test_pairs_7days << TestPair.new(test, a_test)
    end
  end

  def get_diagnosis
    worst_diagnosis = nil
    worst_stage = 0

    self.test_pairs_7days.each do |creatinine_test_pair|
    
      akin = Akin.new(creatinine_test_pair)
      current_diagnosis = akin.diagnosis
    
      unless current_diagnosis.nil?
        if current_diagnosis.stage >= worst_stage
          worst_diagnosis = current_diagnosis
          worst_stage = current_diagnosis.stage
        end

        break if current_diagnosis.stage == 3
      end 

    end

    return worst_diagnosis
  end
  
end