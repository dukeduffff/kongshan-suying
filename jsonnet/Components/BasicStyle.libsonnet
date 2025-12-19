local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local keyboardParams = import '../Constants/Keyboard.libsonnet';
local settings = import '../Settings.libsonnet';
local utils = import 'Utils.libsonnet';

local buttonCornerRadius = 8.5;

local swipeTextCenter = {
  up: { x: 0.28, y: 0.28 },
  down: { x: 0.72, y: 0.28 },
};

local getKeyboardActionText(params={}, key='action', isUppercase=false) =
  if std.objectHas(params, 'text') then
    { text: params.text }
  else if std.objectHas(params, key) then
    local action = params[key];
    if std.type(action) == 'object' then
      if std.objectHas(action, 'character') then
        local text = if isUppercase then std.asciiUpper(action.character) else action.character;
        { text: text }
      else if std.objectHas(action, 'symbol') then
        local text = if isUppercase then std.asciiUpper(action.symbol) else action.symbol;
        { text: text }
      else
        {}
    else
      {}
  else
    {};

// 通用键盘背景样式
local keyboardBackgroundStyleName = 'keyboardBackgroundStyle';
local newKeyboardBackgroundStyle(isDark=false, params={}) = {
  [keyboardBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.keyboardBackgroundColor,
  } + params, isDark),
};

// 浮动键盘按钮背景样式
local floatingKeyboardButtonBackgroundStyleName = 'floatingKeyboardButtonBackgroundStyle';
local newFloatingKeyboardButtonBackgroundStyle(isDark=false, params={}) = {
  [floatingKeyboardButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.floatingKeyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.standardButtonBackgroundColor,
    highlightColor: colors.standardButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 字母键按键动画名称
local buttonAnimationName = 'scaleAnimation';
local newButtonAnimation() = {
  [buttonAnimationName]: {
    animationType: 'scale',
    isAutoReverse: true,
    scale: 0.87,
    pressDuration: 60,
    releaseDuration: 80,
  },
};

// 字母键按钮背景样式
local alphabeticButtonBackgroundStyleName = 'alphabeticButtonBackgroundStyle';
local newAlphabeticButtonBackgroundStyle(isDark=false, params={}) = {
  [alphabeticButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.standardButtonBackgroundColor,
    highlightColor: colors.standardButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 字母键按钮前景样式
local newAlphabeticButtonForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    utils.newSystemImageStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    } + params, isDark)
  else if std.objectHas(params, 'assetImageName') then
    utils.newAssetImageStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonImageFontSize,
    } + params, isDark)
  else
    utils.newTextStyle({
      normalColor: colors.standardButtonForegroundColor,
      highlightColor: colors.standardButtonHighlightedForegroundColor,
      fontSize: fonts.standardButtonTextFontSize,
    } + params, isDark) + getKeyboardActionText(params);

// 字母键按钮上下划提示前景样式
local newAlphabeticButtonAlternativeForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    utils.newSystemImageStyle({
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
      fontSize: fonts.alternativeImageFontSize,
    } + params, isDark)
  else
    utils.newTextStyle({
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
      fontSize: fonts.alternativeTextFontSize,
    } + params, isDark) + getKeyboardActionText(params);

// 生成上下划提示前景名称
local generateSwipeForegroundStyleName(name, direction='Up', suffix='') =
  assert direction == 'Up' || direction == 'Down' : 'direction 必须是 Up 或 Down';
  name + suffix + 'Swipe' + direction + 'ForegroundStyle';

local generateSwipeForegroundStyleNames(name, params={}, suffix='', followSetting=false) =
  local swipeUpStyleName = if std.objectHas(params, 'swipeUp') && (!followSetting || settings.showSwipeUpText) then [generateSwipeForegroundStyleName(name, 'Up', suffix)] else [];
  local swipeDownStyleName = if std.objectHas(params, 'swipeDown') && (!followSetting || settings.showSwipeDownText) then [generateSwipeForegroundStyleName(name, 'Down', suffix)] else [];
  swipeUpStyleName + swipeDownStyleName;

// 大写字母键按钮前景样式
local newAlphabeticButtonUppercaseForegroundStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.standardButtonForegroundColor,
    highlightColor: colors.standardButtonHighlightedForegroundColor,
    fontSize: fonts.standardButtonUppercasedTextFontSize,
  } + params, isDark);

// 字母提示背景样式
local alphabeticHintBackgroundStyleName = 'alphabeticHintBackgroundStyle';
local newAlphabeticHintBackgroundStyle(isDark=false, params={}) = {
  [alphabeticHintBackgroundStyleName]: utils.newGeometryStyle({
    normalColor: colors.standardCalloutBackgroundColor,
    borderColor: colors.standardCalloutBorderColor,
    borderSize: 0.5,
  } + params, isDark),
};

// 字母提示前景样式
local newAlphabeticButtonHintStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.standardCalloutForegroundColor,
    fontSize: fonts.hintTextFontSize,
  } + params, isDark);

// 系统功能键按钮背景样式
local systemButtonBackgroundStyleName = 'systemButtonBackgroundStyle';
local newSystemButtonBackgroundStyle(isDark=false, params={}) = {
  [systemButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.systemButtonBackgroundColor,
    highlightColor: colors.systemButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

// 文本文字系统功能键按钮前景样式
local newTextSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newTextStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark) + getKeyboardActionText(params);

local newImageSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newSystemImageStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonImageFontSize,
  } + params, isDark);

local newAssetImageSystemButtonForegroundStyle(isDark=false, params={}) =
  utils.newAssetImageStyle({
    normalColor: colors.systemButtonForegroundColor,
    highlightColor: colors.systemButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonImageFontSize,
  } + params, isDark);

// 系统键按钮前景样式
local newSystemButtonForegroundStyle(isDark=false, params={}) =
  if std.objectHas(params, 'systemImageName') then
    newImageSystemButtonForegroundStyle(isDark, params)
  else if std.objectHas(params, 'assetImageName') then
    newAssetImageSystemButtonForegroundStyle(isDark, params)
  else
    newTextSystemButtonForegroundStyle(isDark, params) + getKeyboardActionText(params);

local spaceButtonForegroundStyleName = 'spaceButtonForegroundStyle';

local spaceButtonRimeSchemaForegroundStyleName = 'spaceButtonRimeSchemaForegroundStyle';
local newSpaceButtonRimeSchemaForegroundStyle(isDark=false) =
  if settings.spaceButtonShowSchema then
  {
    [spaceButtonRimeSchemaForegroundStyleName]: utils.newTextStyle({
      text: '$rimeSchemaName',
      fontSize: fonts.alternativeTextFontSize,
      center: settings.spaceButtonSchemaNameCenter,
      normalColor: colors.alternativeForegroundColor,
      highlightColor: colors.alternativeHighlightedForegroundColor,
    }, isDark),
  }
  else
  {};

local spaceButtonForegroundStyle = [
  spaceButtonForegroundStyleName,
]
+ (
  if settings.spaceButtonShowSchema then
    [
      spaceButtonRimeSchemaForegroundStyleName,
    ]
  else []
  );

// 彩色功能键按钮背景样式
local colorButtonBackgroundStyleName = 'colorButtonBackgroundStyle';
local newColorButtonBackgroundStyle(isDark=false, params={}) = {
  [colorButtonBackgroundStyleName]: utils.newGeometryStyle({
    insets: keyboardParams.keyboard.button.backgroundInsets.iPhone.portrait,
    normalColor: colors.colorButtonBackgroundColor,
    highlightColor: colors.colorButtonHighlightedBackgroundColor,
    cornerRadius: buttonCornerRadius,
    normalLowerEdgeColor: colors.lowerEdgeOfButtonNormalColor,
    highlightLowerEdgeColor: colors.lowerEdgeOfButtonHighlightColor,
  } + params, isDark),
};

local colorButtonForegroundStyleName = 'colorButtonForegroundStyle';
local newColorButtonForegroundStyle(isDark=false, params={}, namePrefix='') =
  if std.objectHas(params, 'systemImageName') then
    {
      [namePrefix+colorButtonForegroundStyleName]: utils.newSystemImageStyle({
        normalColor: colors.colorButtonForegroundColor,
        highlightColor: colors.colorButtonHighlightedForegroundColor,
        fontSize: fonts.systemButtonImageFontSize,
      } + params, isDark)
    }
  else
    {
      [namePrefix+colorButtonForegroundStyleName]: utils.newTextStyle({
        normalColor: colors.colorButtonForegroundColor,
        highlightColor: colors.colorButtonHighlightedForegroundColor,
        fontSize: fonts.systemButtonTextFontSize,
      } + params, isDark) + getKeyboardActionText(params),
    };

local newFloatingKeyboardButton(name, isDark=false, params={}) =
  {
    [name]: utils.newBackgroundStyle(style=floatingKeyboardButtonBackgroundStyleName)
            +
            {
              foregroundStyle: [
                name + 'ForegroundStyleSystemImage',
                name + 'ForegroundStyleText',
              ],
            }
            + utils.extractProperties(
              params,
              [
                'size',
                'action',
              ]
            ),
    [name + 'ForegroundStyleSystemImage']: utils.newSystemImageStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.floatingKeyboardButtonImageFontSize,
      center: { y: 0.4 }
    } + params, isDark),
    [name + 'ForegroundStyleText']: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.floatingKeyboardButtonTextFontSize,
      center: { y: 0.7 }
    } + params, isDark),
  };

local toolbarSlideButtonsName = 'toolbarSlideButtons';
local newToolbarSlideButtons(buttons, slideButtonsMaxCount, isDark=false) =
  local rightToLeft = std.length(buttons) < slideButtonsMaxCount;
  {
    [toolbarSlideButtonsName]: {
      type: 'horizontalSymbols',
      size: { width: '%d/%d' % [slideButtonsMaxCount, slideButtonsMaxCount + 2] },
      maxColumns: slideButtonsMaxCount,
      contentRightToLeft: rightToLeft,
      insets: { left: 3, right: 3 },
      // backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      dataSource: 'horizontalSymbolsToolbarButtonsDataSource',
      // 用于定义符号列表中每个符号的样式(仅支持文本)
      cellStyle: 'toolbarCollectionCellStyle',
    },
    horizontalSymbolsToolbarButtonsDataSource:
      local adjustOrderButtons = if rightToLeft then std.reverse(buttons) else buttons;
      [
        {
          label: button.name,
          action: button.params.action,
          styleName: button.name + 'Style',
        } for button in adjustOrderButtons
      ],
    toolbarCollectionCellStyle: utils.newBackgroundStyle(style=keyboardBackgroundStyleName)
      + utils.newForegroundStyle(style=keyboardBackgroundStyleName),
  } +
  std.foldl(
    function(acc, button) acc + {
      [button.name + 'Style']: utils.newForegroundStyle(style=button.name + 'ForegroundStyle'),
      [button.name + 'ForegroundStyle']: utils.newSystemImageStyle({
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.toolbarButtonImageFontSize,
      } + button.params, isDark),
    },
    buttons,
    {}
  );

local newToolbarButton(name, isDark=false, params={}) =
  {
    [name]: utils.newForegroundStyle(style=name + 'ForegroundStyle')
            + utils.extractProperties(
              params,
              [
                'action',
                'size',
              ]
            ),
    [name + 'ForegroundStyle']:
      utils.newSystemImageStyle({
        normalColor: colors.toolbarButtonForegroundColor,
        highlightColor: colors.toolbarButtonHighlightedForegroundColor,
        fontSize: fonts.toolbarButtonImageFontSize,
      } + params, isDark),
  };

local newAlphabeticButton(name, isDark=false, params={}, needHint=true, swipeTextFollowSetting=false) =
  assert std.objectHas(params, 'asciiModeOn') == std.objectHas(params, 'asciiModeOff') :
    'asciiModeOn 和 asciiModeOff 必须同时存在或同时不存在';
  local isAsciiModeAware = std.objectHas(params, 'asciiModeOn') && std.objectHas(params, 'asciiModeOff');
  local asciiModeOnParams = if std.objectHas(params, 'asciiModeOn') then params + params.asciiModeOn else {};
  local asciiModeOffParams = if std.objectHas(params, 'asciiModeOff') then params + params.asciiModeOff else {};
  {
    [name]: utils.newBackgroundStyle(style=alphabeticButtonBackgroundStyleName)
            + (
              if std.objectHas(params, 'foregroundStyleName') then
                { foregroundStyle: params.foregroundStyleName }
              else if isAsciiModeAware then
                {
                  foregroundStyle: [
                    {
                      styleName: [utils.asciiModeForegroundStyleName(name, true)] + generateSwipeForegroundStyleNames(name, asciiModeOnParams, 'AsciiModeOn', swipeTextFollowSetting),
                      conditionKey: 'rime$ascii_mode',
                      conditionValue: true,
                    },
                    {
                      styleName: [utils.asciiModeForegroundStyleName(name, false)] + generateSwipeForegroundStyleNames(name, asciiModeOffParams, 'AsciiModeOff', swipeTextFollowSetting),
                      conditionKey: 'rime$ascii_mode',
                      conditionValue: false,
                    },
                  ],
                  notification: [
                    utils.asciiModeChangedNotificationName(name, true),
                    utils.asciiModeChangedNotificationName(name, false),
                  ]
                }
              else
                utils.newForegroundStyle(style=[name + 'ForegroundStyle'] + generateSwipeForegroundStyleNames(name, params, followSetting=swipeTextFollowSetting))
            )
            + (
              if std.objectHas(params, 'uppercasedStateAction') then
                utils.newForegroundStyle('uppercasedStateForegroundStyle', [name + 'UppercaseForegroundStyle'] + generateSwipeForegroundStyleNames(name, params, followSetting=swipeTextFollowSetting))
              else {}
            )
            + (
              if needHint then
                utils.newForegroundStyle('hintStyle', name + 'HintStyle')
              else {}
            )
            + (
              if std.objectHas(params, 'swipeUp') then
                { swipeUpAction: params.swipeUp.action }
              else {}
            )
            + (
              if std.objectHas(params, 'swipeDown') then
                { swipeDownAction: params.swipeDown.action }
              else {}
            )
            + utils.newAnimation(animation=[buttonAnimationName])
            + (
              if isAsciiModeAware then
                {
                  notification: [
                    utils.asciiModeChangedNotificationName(name, true),
                    utils.asciiModeChangedNotificationName(name, false),
                  ]
                }
              else {}
            )
            + utils.extractProperties(
              params,
              [
                'size',
                'bounds',
                'action',
                'uppercasedStateAction',
                'repeatAction',
                'preeditStateAction',
                'capsLockedStateForegroundStyle',
                'preeditStateForegroundStyle',
                'notification', // FIXME: 这里会和 ascii mode notification 冲突吗？
              ]
            ),
  }
  + (
    if isAsciiModeAware then
      utils.newAsciiModeChangedNotification(name, true, {
        backgroundStyleName: alphabeticButtonBackgroundStyleName,
        foregroundStyleName: [utils.asciiModeForegroundStyleName(name, true)] + generateSwipeForegroundStyleNames(name, asciiModeOnParams, 'AsciiModeOn', swipeTextFollowSetting),
      } + utils.extractProperties(asciiModeOnParams, ['bounds', 'action']))
    + utils.newAsciiModeChangedNotification(name, false, {
        backgroundStyleName: alphabeticButtonBackgroundStyleName,
        foregroundStyleName: [utils.asciiModeForegroundStyleName(name, false)] + generateSwipeForegroundStyleNames(name, asciiModeOffParams, 'AsciiModeOff', swipeTextFollowSetting),
      } + utils.extractProperties(asciiModeOffParams, ['bounds', 'action']))
    else {}
  )
  + (
    if std.objectHas(params, 'foregroundStyle') then
      params.foregroundStyle
    else if isAsciiModeAware then
      utils.newAsciiModeForegroundStyle(name,
        newAlphabeticButtonForegroundStyle(isDark, asciiModeOffParams),
        newAlphabeticButtonForegroundStyle(isDark, asciiModeOnParams))
    else
      { [name + 'ForegroundStyle']: newAlphabeticButtonForegroundStyle(isDark, params) }
  )
  + (
    if (!swipeTextFollowSetting || settings.showSwipeUpText) then
    {
      [if std.objectHas(asciiModeOnParams, 'swipeUp') then generateSwipeForegroundStyleName(name, 'Up', 'AsciiModeOn')]: newAlphabeticButtonAlternativeForegroundStyle(isDark, { center: swipeTextCenter.up } + asciiModeOnParams.swipeUp),
      [if std.objectHas(asciiModeOffParams, 'swipeUp') then generateSwipeForegroundStyleName(name, 'Up', 'AsciiModeOff')]: newAlphabeticButtonAlternativeForegroundStyle(isDark, { center: swipeTextCenter.up } + asciiModeOffParams.swipeUp),
      [if std.objectHas(params, 'swipeUp') then generateSwipeForegroundStyleName(name, 'Up')]: newAlphabeticButtonAlternativeForegroundStyle(isDark, { center: swipeTextCenter.up } + params.swipeUp)
    }
    else {}
  )
  + (
    if (!swipeTextFollowSetting || settings.showSwipeDownText) then
    {
      [if std.objectHas(asciiModeOnParams, 'swipeDown') then generateSwipeForegroundStyleName(name, 'Down', 'AsciiModeOn')]: newAlphabeticButtonAlternativeForegroundStyle(isDark, { center: swipeTextCenter.down } + asciiModeOnParams.swipeDown),
      [if std.objectHas(asciiModeOffParams, 'swipeDown') then generateSwipeForegroundStyleName(name, 'Down', 'AsciiModeOff')]: newAlphabeticButtonAlternativeForegroundStyle(isDark, { center: swipeTextCenter.down } + asciiModeOffParams.swipeDown),
      [if std.objectHas(params, 'swipeDown') then generateSwipeForegroundStyleName(name, 'Down')]: newAlphabeticButtonAlternativeForegroundStyle(isDark, { center: swipeTextCenter.down } + params.swipeDown),
    }
    else {}
  )
  + (
    if std.objectHas(params, 'uppercasedStateAction') then
      {
        [name + 'UppercaseForegroundStyle']: newAlphabeticButtonUppercaseForegroundStyle(isDark, params) + getKeyboardActionText(params, 'uppercasedStateAction'),
      }
    else {}
  )
  + (
    if needHint then
      {

        [name + 'HintStyle']:
          (
            if std.objectHas(params, 'hintStyle') then
              params.hintStyle
            else
              {}
          )
          + utils.newBackgroundStyle(style=alphabeticHintBackgroundStyleName)
          + utils.newForegroundStyle(style=name + 'HintForegroundStyle'),
        [name + 'HintForegroundStyle']: newAlphabeticButtonHintStyle(isDark, params) + getKeyboardActionText(params, isUppercase=true),
      }
    else
      {}
  );

local newSystemButton(name, isDark=false, params={}) =
  assert std.objectHas(params, 'asciiModeOn') == std.objectHas(params, 'asciiModeOff') :
    'asciiModeOn 和 asciiModeOff 必须同时存在或同时不存在';
  local isAsciiModeAware = std.objectHas(params, 'asciiModeOn') && std.objectHas(params, 'asciiModeOff');
  local asciiModeOnParams = if std.objectHas(params, 'asciiModeOn') then params + params.asciiModeOn else {};
  local asciiModeOffParams = if std.objectHas(params, 'asciiModeOff') then params + params.asciiModeOff else {};
  {
    [name]: (
              if std.objectHas(params, 'backgroundStyle') then
                { backgroundStyle: params.backgroundStyle }
              else
                utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)
            )
            + (
              if std.objectHas(params, 'foregroundStyle') then
                { foregroundStyle: params.foregroundStyle }
              else if isAsciiModeAware then
                {
                  foregroundStyle: [
                    {
                      styleName: [utils.asciiModeForegroundStyleName(name, value)],
                      conditionKey: 'rime$ascii_mode',
                      conditionValue: value,
                    } for value in [true, false]
                  ],
                  notification: [
                    utils.asciiModeChangedNotificationName(name, true),
                    utils.asciiModeChangedNotificationName(name, false),
                  ]
                }
              else
                utils.newForegroundStyle(style=name + 'ForegroundStyle')
            )
            + (
              if std.objectHas(params, 'swipeUp') then
                { swipeUpAction: params.swipeUp.action }
              else {}
            )
            + (
              if std.objectHas(params, 'swipeDown') then
                { swipeDownAction: params.swipeDown.action }
              else {}
            )
            + (
              if isAsciiModeAware then
                {
                  notification: [
                    utils.asciiModeChangedNotificationName(name, true),
                    utils.asciiModeChangedNotificationName(name, false),
                  ]
                }
              else {}
            )
            + utils.extractProperties(
              params,
              [
                'size',
                'bounds',
                'action',
                'uppercasedStateAction',
                'repeatAction',
                'preeditStateAction',
                'uppercasedStateForegroundStyle',
                'capsLockedStateForegroundStyle',
                'preeditStateForegroundStyle',
                'notification',
              ]
            ),
  }
  + (
    if isAsciiModeAware then
      utils.newAsciiModeChangedNotification(name, true, {
        backgroundStyleName: systemButtonBackgroundStyleName,
        foregroundStyleName: [utils.asciiModeForegroundStyleName(name, true)],
      } + utils.extractProperties(asciiModeOnParams, ['bounds', 'action']))
    + utils.newAsciiModeChangedNotification(name, false, {
        backgroundStyleName: systemButtonBackgroundStyleName,
        foregroundStyleName: [utils.asciiModeForegroundStyleName(name, false)],
      } + utils.extractProperties(asciiModeOffParams, ['bounds', 'action']))
    else {}
  )
  + (
    if isAsciiModeAware then
      utils.newAsciiModeForegroundStyle(name,
        newAlphabeticButtonForegroundStyle(isDark, asciiModeOffParams),
        newAlphabeticButtonForegroundStyle(isDark, asciiModeOnParams))
    else
      { [name + 'ForegroundStyle']: newSystemButtonForegroundStyle(isDark, params) }
  );

local newSpaceButton(name, isDark=false, params={}) =
  {
    [name]: utils.newBackgroundStyle(style=alphabeticButtonBackgroundStyleName)
            + (
              if std.objectHas(params, 'foregroundStyle') then
                { foregroundStyle: params.foregroundStyle }
              else
                utils.newForegroundStyle(style=name + 'ForegroundStyle')
            )
            + (
              if std.objectHas(params, 'uppercasedStateAction') then
                utils.newForegroundStyle('uppercasedStateForegroundStyle', name + 'UppercaseForegroundStyle')
              else {}
            )
            + (
              if std.objectHas(params, 'swipeUp') then
                { swipeUpAction: params.swipeUp.action }
              else {}
            )
            + (
              if std.objectHas(params, 'swipeDown') then
                { swipeDownAction: params.swipeDown.action }
              else {}
            )
            + utils.newAnimation(animation=[buttonAnimationName])
            + utils.extractProperties(
              params,
              [
                'size',
                'bounds',
                'action',
                'uppercasedStateAction',
                'repeatAction',
                'preeditStateAction',
                'capsLockedStateForegroundStyle',
                'preeditStateForegroundStyle',
                'notification',
              ]
            ),
  }
  + {
    [spaceButtonForegroundStyleName]: newAlphabeticButtonForegroundStyle(isDark, params),
  }
  + (
    if settings.spaceButtonShowSchema then
      {
        [spaceButtonRimeSchemaForegroundStyleName]: newSpaceButtonRimeSchemaForegroundStyle(isDark),
      }
    else {}
  )
  + (
    if std.objectHas(params, 'uppercasedStateAction') then
      {
        [name + 'UppercaseForegroundStyle']: newAlphabeticButtonUppercaseForegroundStyle(isDark, params) + getKeyboardActionText(params, 'uppercasedStateAction'),
      }
    else {}
  );

local newSymbolicCollection(name, isDark=false, params={}) =
  {
    [name]: utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)
            + { cellStyle: name + 'CellStyle' }
            + utils.extractProperties(
              params,
              [
                'type',
                'size',
                'insets',
                'dataSource',
              ]
            ),
    [name + 'CellStyle']:
            // utils.newBackgroundStyle(style=systemButtonBackgroundStyleName)+
            utils.newForegroundStyle(style=name + 'CellForegroundStyle'),
    [name + 'CellForegroundStyle']: utils.newTextStyle({
      normalColor: colors.systemButtonForegroundColor,
      highlightColor: colors.systemButtonHighlightedForegroundColor,
      fontSize: fonts.numericCollectionTextFontSize,
    } + params, isDark),
  };


local rimeSchemaChangedNotification =
  if settings.spaceButtonShowSchema then
  {
    rimeSchemaChangedNotification: {
      notificationType: 'rime',
      rimeNotificationType: 'schemaChanged',
      backgroundStyle: alphabeticButtonBackgroundStyleName,
      foregroundStyle: spaceButtonForegroundStyle,
    },
  }
  else
  {};

local preeditChangedForEnterButtonNotification = {
  preeditChangedForEnterButtonNotification: {
    notificationType: 'preeditChanged',
    backgroundStyle: colorButtonBackgroundStyleName,
    foregroundStyle: colorButtonForegroundStyleName,
  },
};

local commitCandidateForegroundStyleName = 'commitCandidateForegroundStyle';
local preeditChangedForSpaceButtonNotification = {
  preeditChangedForSpaceButtonNotification: {
    notificationType: 'preeditChanged',
    backgroundStyle: alphabeticButtonBackgroundStyleName,
    foregroundStyle: commitCandidateForegroundStyleName,
  },
};

local newCommitCandidateForegroundStyle(isDark=false, params={}) = {
  [commitCandidateForegroundStyleName]: utils.newTextStyle({
    normalColor: colors.standardButtonForegroundColor,
    highlightColor: colors.standardButtonHighlightedForegroundColor,
    fontSize: fonts.systemButtonTextFontSize,
  } + params, isDark) + params,
};


{
  getKeyboardActionText: getKeyboardActionText,
  keyboardBackgroundStyleName: keyboardBackgroundStyleName,
  newKeyboardBackgroundStyle: newKeyboardBackgroundStyle,

  floatingKeyboardButtonBackgroundStyleName: floatingKeyboardButtonBackgroundStyleName,
  newFloatingKeyboardButtonBackgroundStyle: newFloatingKeyboardButtonBackgroundStyle,

  buttonAnimationName: buttonAnimationName,
  newButtonAnimation: newButtonAnimation,

  alphabeticButtonBackgroundStyleName: alphabeticButtonBackgroundStyleName,
  newAlphabeticButtonBackgroundStyle: newAlphabeticButtonBackgroundStyle,

  newAlphabeticButtonForegroundStyle: newAlphabeticButtonForegroundStyle,

  newAlphabeticButtonAlternativeForegroundStyle: newAlphabeticButtonAlternativeForegroundStyle,
  newAlphabeticButtonUppercaseForegroundStyle: newAlphabeticButtonUppercaseForegroundStyle,

  generateSwipeForegroundStyleNames: generateSwipeForegroundStyleNames,

  alphabeticHintBackgroundStyleName: alphabeticHintBackgroundStyleName,
  newAlphabeticHintBackgroundStyle: newAlphabeticHintBackgroundStyle,

  newAlphabeticButtonHintStyle: newAlphabeticButtonHintStyle,

  systemButtonBackgroundStyleName: systemButtonBackgroundStyleName,
  newSystemButtonBackgroundStyle: newSystemButtonBackgroundStyle,

  colorButtonBackgroundStyleName: colorButtonBackgroundStyleName,
  newColorButtonBackgroundStyle: newColorButtonBackgroundStyle,

  colorButtonForegroundStyleName: colorButtonForegroundStyleName,
  newColorButtonForegroundStyle: newColorButtonForegroundStyle,

  newTextSystemButtonForegroundStyle: newTextSystemButtonForegroundStyle,
  newImageSystemButtonForegroundStyle: newImageSystemButtonForegroundStyle,
  newAssetImageSystemButtonForegroundStyle: newAssetImageSystemButtonForegroundStyle,
  newSystemButtonForegroundStyle: newSystemButtonForegroundStyle,

  newFloatingKeyboardButton: newFloatingKeyboardButton,
  toolbarSlideButtonsName: toolbarSlideButtonsName,
  newToolbarSlideButtons: newToolbarSlideButtons,
  newToolbarButton: newToolbarButton,

  newAlphabeticButton: newAlphabeticButton,

  newSystemButton: newSystemButton,

  newSymbolicCollection: newSymbolicCollection,

  newSpaceButton: newSpaceButton,
  spaceButtonForegroundStyle: spaceButtonForegroundStyle,
  spaceButtonRimeSchemaForegroundStyleName: spaceButtonRimeSchemaForegroundStyleName,
  newSpaceButtonRimeSchemaForegroundStyle: newSpaceButtonRimeSchemaForegroundStyle,

  newCommitCandidateForegroundStyle: newCommitCandidateForegroundStyle,

  // notification
  rimeSchemaChangedNotification: rimeSchemaChangedNotification,
  preeditChangedForEnterButtonNotification: preeditChangedForEnterButtonNotification,
  preeditChangedForSpaceButtonNotification: preeditChangedForSpaceButtonNotification,
}
