local settings = import '../Settings.libsonnet';
local layout9  = import 'iPhonePinyin9.libsonnet';
local layout17 = import 'iPhonePinyin17.libsonnet';
local layout26 = import 'iPhonePinyin26.libsonnet';

{
  new(isDark, isPortrait):
    if settings.keyboardLayout == '9' then
      layout9.new(isDark, isPortrait)
    else if settings.keyboardLayout == '17' then
      layout17.new(isDark, isPortrait)
    else
      layout26.new(isDark, isPortrait),
}
