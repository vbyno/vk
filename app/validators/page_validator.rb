class PageValidator < ActiveModel::Validator
  def validate(page)
    if page.type == ChildPage.to_s && page.parent_id.blank?
      page.errors[:parent_id] << I18n.t('activerecord.errors.models.page.parent_id.should_exist')
    elsif page.type == ParentPage.to_s && page.parent_id.present?
      page.errors[:parent_id] << I18n.t('activerecord.errors.models.page.parent_id.should_not_exist')
    elsif page.type == MainPage.to_s && page.permalink.to_s != page.locale.to_s
      page.errors[:permalink] <<
        I18n.t('activerecord.errors.models.page.permalink.does_not_eq_locale')
    end
  end
end
