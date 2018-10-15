module OptionsHelper
  def trigger_kinds
    return Trigger.KINDS.map{ |kind| [t("option.trigger."+kind), kind] }
  end

  def genders
    [['Hombre', 'male'], ['Mujer', 'female']]
  end

  def parameter_kind_types
  	ParameterKind.TYPES.map{ |type| [t("option.parameter_kind."+type), type] }
  end
end