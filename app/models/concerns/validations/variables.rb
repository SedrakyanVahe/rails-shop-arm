module Validations::Variables
  extend ActiveSupport::Concern

  VALID_IMAGE_TYPES = %w(image/jpeg image/jpg image/png)
  VALID_FILE_TYPES = %w(
    text/csv 
    application/excel
    application/vnd.ms-excel
    application/x-excel
    application/x-msexcel
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
  )
  CSV = %w[text/csv]
  VALID_URL = %w[http https]

end