class ApartmentPresenter < BasePresenter
  attr_reader :locale
  presents :apartment
  delegate :title, :description, :short_description, to: :responder

  def self.all(locale, view)
    active_apartments = Apartment.active
    return active_apartments.map { |apartment| new(apartment, view) } if locale.default?

    apartments = active_apartments.translated_to(locale.to_sym)
    # TODO make include with param :locale
    translations =
      ApartmentTranslation.where(apartment_id: apartments.map(&:id), locale: locale.to_sym)

    apartments.map do |apartment|
      new(apartment, view,
          translation: translations.detect { |t| t.apartment_id == apartment.id })
    end
  end

  def initialize(apartment, view, locale: nil, translation: nil)
    if translation
      @translation = translation
      @locale = Locale.new(translation.locale)
    else
      @locale = locale.is_a?(Locale) ? locale : Locale.new(locale)
    end

    super(apartment, view)
  end

  def ==(other)
    apartment == other.apartment && translation == other.translation
  end

  def to_partial_path
    '/apartments/apartment'
  end

  def path
    if translated?
      h.locale_apartment_path(locale.to_sym, permalink)
    else
      h.apartment_path(permalink)
    end
  end

  def edit_path
    if translated?
      h.edit_admin_apartment_translation_path(translation)
    else
      h.edit_admin_apartment_path(apartment)
    end
  end

  def translation
    return @translation if defined?(@translation)

    @translation = translation_by_locale(locale)
  end

  private

  def responder
    translated? ? translation : apartment
  end

  def translated?
    translation.present?
  end
end
