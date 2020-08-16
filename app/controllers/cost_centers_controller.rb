class CostCentersController < ApplicationController

  # Generate a cost center, we've just made up some random format for fun
  # Format: NNNN-XXXX-NNN
  def new
    @cost_center = new_cost_center
  end

  def new_cost_center
    # is this a good way to do things?  not sure, but it's neat!
    random_digits(4) + '-' + random_chars(4) + '-' + random_digits(3)
  end

  private

    def random_digits(count)
      ((1..count).collect { rand(1...10) }.collect { |n| n.to_s }).join('')
    end

    def random_chars(count)
      ((1..count).collect { ("A".ord + rand(0...26)).chr }).join('')
    end
end
