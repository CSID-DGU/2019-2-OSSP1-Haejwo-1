class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def enum_ko(column_name)
    I18n.t("enum.#{self.class.name.downcase}.#{column_name}.#{self.send("#{column_name}")}")
  end

  def self.enum_selectors(column_name)
    I18n.t("enum.#{self.name.downcase}.#{column_name}").invert rescue []
  end
end
