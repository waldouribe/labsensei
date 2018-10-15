class Akin < AkiCriteria
  def diagnosis
    worst_diagnosis = nil
    acute_stage = acute_rise_stage
    percentage_stage = percentage_rise_stage

    unless acute_stage.nil? and percentage_stage.nil?
      if acute_stage.nil?
        worst_stage = percentage_stage
        reason = 'percentage_rise'
      elsif percentage_stage.nil?
        worst_stage = acute_stage
        reason = 'acute_rise'
      else
        worst_stage = [acute_stage, percentage_stage].max
        if worst_stage == 0
          reason = 'healthy'
        elsif acute_stage >= percentage_stage
          reason = 'acute_rise'
        else
          reason = 'percentage_rise'
        end
      end

      worst_diagnosis = AkiDiagnosis.new(
                          stage: worst_stage, 
                          reason: reason, 
                          creatinine_test_1: creatinine_test_pair.test_1, 
                          creatinine_test_2: creatinine_test_pair.test_2)
    end

    return worst_diagnosis
  end

  def acute_rise_stage
    worst_stage = nil
    
    if creatinine_test_pair.performed_in_range_of 48.hours
      if creatinine_test_pair.level_raised? 0.5 and creatinine_test_pair.test_2.level >= 4
        worst_stage = 3
      elsif creatinine_test_pair.level_raised? 0.3
        worst_stage = 1
      else
        worst_stage = 0
      end
    end

    return worst_stage
  end

  def percentage_rise_stage
    worst_stage = nil

    if creatinine_test_pair.performed_in_range_of 7.days
      if creatinine_test_pair.level_percentage_raised? 200
        worst_stage = 3
      elsif creatinine_test_pair.level_percentage_raised? 100
        worst_stage = 2
      elsif creatinine_test_pair.level_percentage_raised? 50
        worst_stage = 1
      else
        worst_stage = 0
      end
    end

    return worst_stage
  end

end