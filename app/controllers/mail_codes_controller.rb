class MailCodesController < ApplicationController
  include CodeGenerator

  # Generate a mail code, we've just made up some random format for fun
  def new
    @mail_code = new_mail_code
  end

  # Format: XX-XXX-NNNN-XX
  def new_mail_code
    [ random_chars(2), random_chars(3), random_digits(4), random_chars(2) ].join('-')
  end

end
