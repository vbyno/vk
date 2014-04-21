class ApartmentPresenter < BasicPresenter
  attr_reader :apartment, :translation
  delegate :title, :description, :short_description, to: :responder

  def initialize(apartment, translation = nil)
    @apartment = apartment
    @translation = translation
  end

  def path
    translated? ? locale_apartment_path(locale, apartment) : apartment_path(apartment)
  end

  def edit_path
    if translated?
      edit_admin_apartment_translation_path(translation)
    else
      edit_admin_apartment_path(apartment)
    end
  end

  def self.all(locale)
    active_apartments = Apartment.active
    return active_apartments.map { |a| ApartmentPresenter.new(a) } if locale.default?

    apartments = active_apartments.translated_to(locale.to_sym)
    # TODO make include with param :locale
    translations = ApartmentTranslation.where(apartment_id: apartments.map(&:id),
                                              locale: locale.to_sym)
    apartments.map do |apartment|
      translation = translations.detect { |t| t.apartment_id == apartment.id }
      ApartmentPresenter.new(apartment, translation)
    end
  end

  def self.create_by_locale(apartment, locale)
    translation =
      apartment.translations.find_by!(locale: locale.to_sym) unless locale.default?
    new(apartment, translation)
  end

  def method_missing(*args)
    apartment.public_send(*args)
  end

private
  def responder
    translated? ? translation : apartment
  end

  def locale
    Locale.new(translation.try(:locale))
  end

  def translated?
    translation.present?
  end
end
