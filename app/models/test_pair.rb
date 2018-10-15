class TestPair
  attr_accessor :test_1, :test_2

  def initialize(a_test, another_test)
    if a_test.performed_at <= another_test.performed_at
      @test_1 = a_test
      @test_2 = another_test
    else
      @test_1 = another_test
      @test_2 = a_test
    end
  end

  def performed_in_range_of(time)
    time_between = @test_2.performed_at - @test_1.performed_at
    return time_between <= time
  end

  def level_raised?(level_delta)
    return test_2.level - test_1.level >= level_delta
  end

  def level_percentage_raised?(increased_percentage)
    return test_1.level*(100+increased_percentage)/100 <= test_2.level
  end
end
