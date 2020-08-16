class CostCentersController < ApplicationController
  include CodeGenerator

  # Generate a cost center, we've just made up some random format for fun
  def new
    @cost_center = new_cost_center
  end

  # Format: NNNN-XXXX-NNN
  def new_cost_center
    # is this a good way to do things?  not sure, but it's neat!
    [ random_digits(4), random_chars(4), random_digits(3) ].join('-')
  end

end
