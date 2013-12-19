class ApartmentPresenter
  include Rails.application.routes.url_helpers

  attr_reader :id, :title, :description, :price

  def initialize(apartment, params = {locale: nil, translation: nil})
    translation = params[:translation]
    @locale = params[:locale] || Locale.new(translation.try(:locale))

    @id, @price = apartment.id, apartment.price
    @title, @description = translated_attributes(apartment, translation)
  end

  def path
    @locale.default? ? apartment_path(@id) : locale_apartment_path(@locale, @id)
  end

  def self.all(locale)
    if locale.default?
      Apartment.all.map { |apartment| ApartmentPresenter.new(apartment) }
    else
      apartment_ids = Apartment.translated_to(locale.to_sym).pluck(:id)
      # TODO make include with param :locale
      translations = ApartmentTranslation.where(apartment_id: apartment_ids,
                                                locale: locale.to_sym)
      Apartment.find(apartment_ids).map { |apartment|
        ApartmentPresenter.new(apartment,
                               translation: translations.detect { |t|
                                 t.apartment_id == apartment.id
                               })
      }
    end
  end

private
  def translated_attributes(apartment, translation)
    return [translation.title, translation.description] if translation
    return [apartment.title, apartment.description] if @locale.default?

    # searching for translation if we have no translation and locale is not default
    translation = apartment.translations.find_by(locale: @locale)
    [translation.title, translation.description]
  end
end
