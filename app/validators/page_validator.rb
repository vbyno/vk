class PageValidator < ActiveModel::Validator
  def validate(page)
    error = if page.type == ChildPage.to_s && page.parent_id.blank?
              I18n.t('activerecord.errors.models.page.parent_id.should_exist')
            elsif page.type == ParentPage.to_s && page.parent_id.present?
              I18n.t('activerecord.errors.models.page.parent_id.should_not_exist')
            end
    page.errors[:parent_id] << error if error
  end
end
