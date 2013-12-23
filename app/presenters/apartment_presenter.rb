class ApartmentPresenter
  include Rails.application.routes.url_helpers

  attr_reader :id, :title, :description, :price, :main_image, :short_description

  def initialize(apartment, params = {locale: nil, translation: nil})
    translation = params[:translation]
    @locale = params[:locale] || Locale.new(translation.try(:locale))

    @id, @price, @main_image = apartment.id, apartment.price, apartment.main_image
    @title, @description, @short_description = translated_attributes(apartment,
                                                                     translation,
                                                                     :title,
                                                                     :description,
                                                                     :short_description)
  end

  def path
    @locale.default? ? apartment_path(@id) : locale_apartment_path(@locale, @id)
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

private
  def translated_attributes(apartment, translation, *attributes)
    return attributes.map { |a| apartment.public_send(a) } if @locale.default?

    translation ||= apartment.translations.find_by(locale: @locale.to_s)
    attributes.map { |a| translation.public_send(a) }
  end
end
