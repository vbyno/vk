class ApartmentHandler
  def initialize(apartment_params)
    @current_locale = I18n.locale
    @default_locale = I18n.default_locale
    @attributes = apartment_params
  end

  def save_apartment!
    if translated?
      #TODO
    else
      #TODO
    end
  end

  def translated?
    @default_locale == @current_locale
  end

  def self.all(locale = Locale.new)
    if locale.default?
      Apartment.all
    else
      apartments = Apartment.translated_to(locale.to_sym).all
      translations = ApartmentTranslation
                     .by_apartment_ids(apartments.map(&:id), locale.to_sym)
      apartments.zip(translations).map { |arr|
        OpenStruct.new(
          id: arr.first.id,
          title: arr.last.title,
          description: arr.last.description,
          price: arr.first.price
        )
      }
    end
  end
end