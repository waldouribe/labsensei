module MyTranslationHelper
  def translate(key, options = {}) 
    translation = super(key, options)
    return translation.html_safe
  end
  alias :t :translate
end