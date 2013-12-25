class ApartmentPresenter
  include Rails.application.routes.url_helpers

  attr_reader :title, :description, :short_description

  def initialize(apartment, params = {locale: nil, translation: nil})
    @apartment = apartment
    translation = params[:translation]
    @locale = params[:locale] || Locale.new(translation.try(:locale))

    @title, @description, @short_description = translated_attributes(
      translation, :title, :description, :short_description
    )
  end

  def path
    @locale.default? ? apartment_path(id) : locale_apartment_path(@locale, id)
  end

  def self.all(locale)
    active_apartments = Apartment.active
    return active_apartments.map { |a| ApartmentPresenter.new(a) } if locale.default?

    apartment_ids = active_apartments.translated_to(locale.to_sym).pluck(:id)
    # TODO make include with param :locale
    translations = ApartmentTranslation.where(apartment_id: apartment_ids,
                                              locale: locale.to_sym)
    active_apartments.find(apartment_ids).map { |apartment|
      ApartmentPresenter.new(apartment,
                             translation: translations.detect { |t|
                               t.apartment_id == apartment.id
                             })
    }
  end

  def method_missing(*args)
    @apartment.public_send(*args)
  end

private
  def translated_attributes(translation, *attributes)
    return attributes.map { |a| @apartment.public_send(a) } if @locale.default?

    translation ||= @apartment.translations.find_by(locale: @locale.to_s)
    return attributes.map { |a| translation.public_send(a) } if translation
    raise ActiveRecord::RecordNotFound.new("No #{@locale} translation for #{@apartment}")
  end
end
